import { useCallback, useEffect, useState } from 'react';

import axios from 'axios';

const GOOGLE_KEY = import.meta.env.VITE_GOOGLE_KEY;

export interface CoordsType {
  lat: number;
  lng: number;
}

interface Corrdinates {
  coords: {
    latitude: number;
    longitude: number;
  };
}

export interface LocationType {
  loaded?: boolean;
  coords?: CoordsType;
  address?: string;
  error?: {
    code: number;
    message: string;
  };
}

const useGeoLocation = (
  initialLocation: LocationType = {
    loaded: false,
    coords: { lat: 0, lng: 0 },
    address: '',
  },
) => {
  const [location, setLocation] = useState<LocationType>(initialLocation);

  const getAddressFromCoordinates = useCallback(
    async ({ coords: { latitude, longitude } }: Corrdinates) => {
      if (location.loaded) return;

      try {
        const { data } = await axios.get(
          `https://maps.googleapis.com/maps/api/geocode/json?latlng=${latitude},${longitude}&language=ko&key=${GOOGLE_KEY}`,
        );
        const formattedAddress = data.results[5].formatted_address;
        setLocation({
          loaded: true,
          coords: {
            lat: latitude,
            lng: longitude,
          },
          address: formattedAddress,
        });
      } catch (error) {
        console.log(error);
      }
    },
    [],
  );

  const onError = (error: { code: number; message: string }) => {
    setLocation({
      loaded: true,
      error,
    });
  };

  useEffect(() => {
    if (!('geolocation' in navigator)) {
      onError({
        code: 0,
        message: 'Geolocation not supported',
      });
    }
    navigator.geolocation.getCurrentPosition(
      getAddressFromCoordinates,
      onError,
    );
  }, []);

  return { location };
};

export default useGeoLocation;
