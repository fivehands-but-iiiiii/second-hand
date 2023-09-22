import { useCallback } from 'react';

import axios from 'axios';

const GOOGLE_KEY = import.meta.env.VITE_GOOGLE_KEY;

const useAddressToCoords = () => {
  const getCoordinatesFromAddress = useCallback(async (address: string) => {
    try {
      const { data } = await axios.get(
        `https://maps.googleapis.com/maps/api/geocode/json?address=${address}&language=ko&key=${GOOGLE_KEY}`,
      );
      const coords = data.results[0].geometry.location;
      return coords;
    } catch (error) {
      console.log(error);
    }
  }, []);

  return { getCoordinatesFromAddress };
};

export default useAddressToCoords;
