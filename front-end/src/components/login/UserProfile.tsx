import { useState } from 'react';

import FileInput from '@common/FileInput';
import { getPreviewFile } from '@utils/getPreviewFile';

import { css, styled } from 'styled-components';

import { InputFile } from './Join';

interface UserProfileProps {
  size?: 's' | 'm';
  profileImgUrl?: string;
  memberId?: string;
  onChange?: (file: InputFile) => void;
}

const UserProfile = ({
  size = 'm',
  profileImgUrl,
  memberId,
  onChange,
}: UserProfileProps) => {
  const [preview, setPreview] = useState<string>('');

  const handleFileChange = async (file: FileList) => {
    if (!file) return;

    const newFile = file?.[0];
    const newPreview = await getPreviewFile(newFile);
    setPreview(newPreview);

    const newFormData: InputFile = {
      preview: newPreview,
      file: newFile,
    };
    onChange && onChange(newFormData);
  };

  return (
    <MyUserProfile>
      {profileImgUrl ? (
        <MyUserImg src={profileImgUrl} alt={memberId} size={size} />
      ) : (
        <>
          <MyDefaultImgBox>
            {preview && <MyPreviewFile src={preview} alt="미리 보기" />}
            <FileInput onChange={handleFileChange} />
          </MyDefaultImgBox>
        </>
      )}
      {memberId && <p>{memberId}</p>}
    </MyUserProfile>
  );
};

const MyUserProfile = styled.div``;

const MyUserImg = styled.img<UserProfileProps>`
  ${({ size }) =>
    size === 's'
      ? css`
          width: 48px;
          height: 48px;
        `
      : css`
          width: 80px;
          height: 80px;
        `};
  border-radius: 50%;
`;

const MyDefaultImgBox = styled.div`
  position: relative;
  width: 80px;
  height: 80px;
  margin: 0 auto;
  border-radius: 50%;
  line-height: 80px;
  border: 1px solid ${({ theme }) => theme.colors.neutral.border};
  > button {
    display: inline-block;
  }
`;

const MyPreviewFile = styled.img`
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: inherit;
`;

export default UserProfile;
