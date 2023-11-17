import { useState } from 'react';

// eslint-disable-next-line import/named
import { AxiosRequestConfig, AxiosResponse, AxiosError } from 'axios';

import api from '../api';

interface APIProps {
  url: string;
  method?: 'get' | 'post' | 'put' | 'delete' | 'patch';
  config?: AxiosRequestConfig;
}

const useAPI = () => {
  const [loading, setLoading] = useState(false);

  const request = async ({ url, method = 'get', config }: APIProps) => {
    setLoading(true);
    try {
      const requestConfig = {
        url,
        method,
        ...config,
      };
      const { data }: AxiosResponse = await api(requestConfig);
      return data;
    } catch (error) {
      if (error instanceof AxiosError) {
        throw error;
      }
    } finally {
      setLoading(false);
    }
  };

  return { loading, request };
};

export default useAPI;
