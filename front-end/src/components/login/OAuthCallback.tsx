import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

import { setStorageValue } from '@utils/sessionStorage';
import { AxiosError } from 'axios';

import api from '../../api';
const ENV_MODE = import.meta.env.VITE_ENV_MODE;

export interface GitHubUserInfo {
  id: number;
  login: string;
  avatar_url: string;
}

const OAuthCallback = () => {
  const navigate = useNavigate();
  const currentURL = new URL(window.location.href);
  const queryCode = currentURL.searchParams.get('code');

  const loginOrSignUpWithGitHub = async (userInfo: GitHubUserInfo) => {
    try {
      const { data } = await api.post('/login', {
        memberId: userInfo.login,
      });
      const { id, memberId, profileImgUrl, regions, token } = data.data;

      setStorageValue({
        key: 'userInfo',
        value: {
          id: id,
          memberId: memberId,
          profileImgUrl: profileImgUrl,
          regions: regions,
        },
      });
      setStorageValue({
        key: 'token',
        value: token,
      });

      navigate('/');
    } catch (error) {
      if (error instanceof AxiosError && error.response?.status === 401) {
        navigate('/join', {
          state: { ...userInfo },
          replace: true,
        });
      }
    }
  };

  useEffect(() => {
    const authenticateWithSessionId = async () => {
      try {
        await api.get(`/git/login?code=${queryCode}&env=${ENV_MODE}`);
      } catch (error) {
        if (error instanceof AxiosError && error.response?.status === 401) {
          const gitHubUserInfo: GitHubUserInfo = error.response.data.body;
          loginOrSignUpWithGitHub(gitHubUserInfo);
        }
      }
    };
    authenticateWithSessionId();
  }, [queryCode]);

  return <></>;
};

export default OAuthCallback;
