import { useCallback } from 'react';

import axios from 'axios';

const GOOGLE_KEY = import.meta.env.VITE_GOOGLE_KEY;

const useAddressToCoords = () => {
  const getCoordinatesFromAddress = useCallback(async (address: string) => {
    try {
      const { data } = await axios.get(
        `https://maps.googleapis.com/maps/api/geocode/json?address=${address},+CA&key=${GOOGLE_KEY}`,
      );
      const index = data.results.findIndex((result: any) =>
        result.formatted_address.startsWith('대한민국'),
      );
      if (index === -1) throw new Error('대한민국 주소가 아닙니다.');
      const coords = data.results[index].geometry.location;
      return coords;
    } catch (error) {
      console.log(error);
    }
  }, []);

  return { getCoordinatesFromAddress };
};

export default useAddressToCoords;
