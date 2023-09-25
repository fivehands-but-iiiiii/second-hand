import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

import { setStorageValue } from '@utils/sessionStorage';
import { AxiosError } from 'axios';

import api from '../../api';
import Loading from '@pages/Loading';
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

  const loginWithGitHub = async (userInfo: GitHubUserInfo) => {
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

      return true;
    } catch (error) {
      if (error instanceof AxiosError && error.response?.status === 401) {
        return false;
      }
      throw error;
    }
  };

  const signUpWithGitHub = async (userInfo: GitHubUserInfo) => {
    navigate('/join', {
      state: { ...userInfo },
      replace: true,
    });
  };

  useEffect(() => {
    const authenticateWithSessionId = async () => {
      try {
        await api.get(`/git/login?code=${queryCode}&env=${ENV_MODE}`);
      } catch (error) {
        if (error instanceof AxiosError && error.response?.status === 401) {
          const gitHubUser: GitHubUserInfo = error.response.data.body;
          const isLoginSuccess = await loginWithGitHub(gitHubUser);
          if (isLoginSuccess) {
            navigate('/', { replace: true });
          }
          await signUpWithGitHub(gitHubUser);
        }
      }
    };
    authenticateWithSessionId();
  }, [queryCode]);

  return (
    <>
      <Loading />
    </>
  );
};

export default OAuthCallback;
