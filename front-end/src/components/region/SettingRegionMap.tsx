import { useCallback, useState } from 'react';

import NavBar from '@common/NavBar/NavBar';
import PortalLayout from '@components/layout/PortalLayout';
import { RegionInfo } from '@components/login/Join';
import useAddressToCoordinates from '@hooks/useAddressToCoords';
import useAPI from '@hooks/useAPI';
import { CoordsType } from '@hooks/useGeoLocation';
import { GoogleMap, useJsApiLoader, Marker } from '@react-google-maps/api';
import { getStoredValue, setStorageValue } from '@utils/sessionStorage';

import { styled } from 'styled-components';

import SettingRegionSelector from './SettingRegionSelector';

const GOOGLE_KEY = import.meta.env.VITE_GOOGLE_KEY;

const OPTIONS = {
  minZoom: 4,
  maxZoom: 18,
};

const MAP_STYLE = {
  width: '100%',
  height: '100%',
};

interface SettingRegionMapProps {
  regions: RegionInfo[];
  onPortal: () => void;
}

interface UpdatedRegionTypes {
  regions: RegionInfo[];
  center: CoordsType;
}

const SettingRegionMap = ({ regions, onPortal }: SettingRegionMapProps) => {
  const userInfo = getStoredValue({ key: 'userInfo' });
  const [updated, setUpdated] = useState<UpdatedRegionTypes>({
    regions: regions,
    center: { lat: 37.49087142944336, lng: 127.03343963623047 },
  });
  const [, setMap] = useState(null);
  const { getCoordinatesFromAddress } = useAddressToCoordinates();
  const { request } = useAPI();

  const { isLoaded } = useJsApiLoader({
    id: 'google-map-script',
    googleMapsApiKey: GOOGLE_KEY,
  });

  const onLoad = useCallback((map: any) => {
    const bounds = new window.google.maps.LatLngBounds(updated.center);
    map.fitBounds(bounds);
    setMap(map);
  }, []);

  const onUnmount = useCallback(() => setMap(null), []);

  const handleSettingRegions = async () => {
    const prevRegions = regions;
    const isSame = areRegionsSame(prevRegions, updated.regions);
    const isSwitched = haveSwitchedRegions(prevRegions, updated.regions);
    const isChanged = haveChangedRegions(prevRegions, updated.regions);

    if (isSame) return onPortal();
    if (!isSwitched && !isChanged) return;

    const endpoint = '/members/region';
    const method = isSwitched ? 'patch' : 'put';
    const requestBody = { id: userInfo.id, regions: updated.regions };
    const updatedUserAccount = { ...userInfo, regions: updated.regions };
    try {
      const { data } = await request({
        url: endpoint,
        method: method,
        config: { data: requestBody },
      });
      if (data) {
        setStorageValue({ key: 'userInfo', value: updatedUserAccount });
        onPortal();
      }
    } catch (error) {
      console.error(error);
    }
  };

  const areRegionsSame = (prev: RegionInfo[], updated: RegionInfo[]) => {
    return (
      prev.length === updated.length &&
      prev.every((prevRegion) =>
        updated.some(
          (updatedRegion) =>
            prevRegion.id === updatedRegion.id &&
            prevRegion.onFocus === updatedRegion.onFocus,
        ),
      )
    );
  };

  const haveSwitchedRegions = (prev: RegionInfo[], updated: RegionInfo[]) => {
    return (
      prev.length === updated.length &&
      prev.every(
        (prevRegion, index) =>
          prevRegion.id === updated[index].id &&
          prevRegion.district === updated[index].district &&
          prevRegion.onFocus !== updated[index].onFocus,
      )
    );
  };

  const haveChangedRegions = (prev: RegionInfo[], updated: RegionInfo[]) => {
    if (prev.length !== updated.length) return true;
    return (
      prev.some(
        (prevRegion) =>
          !updated.some((updated) => prevRegion.id === updated.id),
      ) ||
      !prev.every((prevRegion, index) => prevRegion.id === updated[index].id)
    );
  };

  const handleUpdateRegions = async (regions: RegionInfo[]) => {
    const focusedRegion = regions.find(({ onFocus }) => onFocus)?.district;
    if (!focusedRegion) return;

    const coords = await getCoordinatesFromAddress(focusedRegion);
    setUpdated({ regions: regions, center: coords });
  };

  return (
    <PortalLayout>
      <NavBar
        left={<button onClick={handleSettingRegions}>닫기</button>}
        center={'동네 설정'}
      />
      <MySettingRegionMap>
        {isLoaded && (
          <GoogleMap
            mapContainerStyle={MAP_STYLE}
            center={updated.center}
            onLoad={onLoad}
            onUnmount={onUnmount}
            options={OPTIONS}
          >
            <Marker position={updated.center}></Marker>
          </GoogleMap>
        )}
        <SettingRegionSelector
          regions={updated.regions}
          onSetRegions={handleUpdateRegions}
        />
      </MySettingRegionMap>
    </PortalLayout>
  );
};

const MySettingRegionMap = styled.div`
  height: 50vh;
  padding: 0 2.7vw;
  > div:first-child {
    margin-bottom: 10px;
  }
`;

export default SettingRegionMap;
