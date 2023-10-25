import { UserInfo, InputFile } from '@components/login/Join';

import useAPI from './useAPI';

interface UseJoinProps {
  files?: InputFile;
  account: UserInfo;
}

const useJoin = () => {
  const { request } = useAPI();

  const getUploadUrl = async (file: File) => {
    if (!file) return;
    const formData = new FormData();
    formData.append('profileImage', file, file.name);
    const { data } = await request({
      url: '/profile/image',
      method: 'post',
      config: {
        data: formData,
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      },
    });
    return data.uploadUrl;
  };

  const join = async ({ files, account }: UseJoinProps) => {
    try {
      if (files?.file) {
        const image = await getUploadUrl(files.file);
        const updatedAccount: UserInfo = {
          ...account,
          profileImgUrl: image,
        };
        await request({
          url: '/join',
          method: 'post',
          config: {
            data: updatedAccount,
          },
        });
      } else {
        await request({
          url: '/join',
          method: 'post',
          config: {
            data: account,
          },
        });
      }
      return {
        success: true,
        message: '회원가입이 완료되었어요',
      };
    } catch (error) {
      return {
        success: false,
        message: '회원가입에 실패했어요',
      };
    }
  };

  return { join };
};

export default useJoin;
