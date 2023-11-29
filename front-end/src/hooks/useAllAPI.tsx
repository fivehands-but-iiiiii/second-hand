import { useState } from 'react';

// eslint-disable-next-line import/named
import { AxiosRequestConfig, AxiosResponse, AxiosError } from 'axios';

import api from '../api';

interface APIProps {
  url: string;
  method?: 'get' | 'post' | 'put' | 'delete' | 'patch';
  config?: AxiosRequestConfig;
}

const useAllAPI = () => {
  const [loading, setLoading] = useState(false);

  const requestAll = async (requests: APIProps[]) => {
    setLoading(true);
    try {
      const requestConfig = requests.map(({ url, config }: APIProps) => ({
        url,
        ...config,
      }));
      const data: AxiosResponse[] = await Promise.all(
        requestConfig.map((config) => api.get(config.url, config)),
      );
      return data.map(({ data }: AxiosResponse) => data);
    } catch (error) {
      if (error instanceof AxiosError) {
        throw error;
      }
      return [];
    } finally {
      setLoading(false);
    }
  };

  return { loading, requestAll };
};

export default useAllAPI;
