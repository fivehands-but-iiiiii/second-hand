import { useEffect, useState } from 'react';

import axios from 'axios';

import { CoordsType } from './useGeoLocation';

interface GeocodeResult {
  formatted_address: string;
  geometry: {
    location: CoordsType;
  };
}

const GOOGLE_KEY = import.meta.env.VITE_GOOGLE_KEY;

const useAddressToCoords = (address: string | undefined) => {
  const [center, setCenter] = useState<CoordsType>({
    lat: 0,
    lng: 0,
  });

  useEffect(() => {
    if (!address) return;
    const getCords = async () => {
      try {
        const { data } = await axios.get(
          `https://maps.googleapis.com/maps/api/geocode/json?address=${address},+CA&key=${GOOGLE_KEY}`,
        );
        const index = data.results.findIndex((result: GeocodeResult) =>
          result.formatted_address.startsWith('대한민국'),
        );
        if (index === -1) throw new Error('대한민국 주소가 아닙니다.');
        const coords = data.results[index].geometry.location;
        setCenter(coords);
      } catch (error) {
        throw new Error('주소를 찾을 수 없습니다.');
      }
    };
    getCords();
  }, [address]);

  return center;
};

export default useAddressToCoords;
