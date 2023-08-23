import { useRef, ChangeEvent } from 'react';

import Icon from '@assets/Icon';
import Button from '@common/Button';

import { styled } from 'styled-components';

interface FileInputProps {
  fileDescription?: string;
  onChange: (e: ChangeEvent<HTMLInputElement>) => void;
}

const FileInput = ({ fileDescription, onChange }: FileInputProps) => {
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleInputFile = () => fileInputRef.current?.click();

  return (
    <MyFileInput>
      <MyFileButton icon onClick={handleInputFile}>
        <Icon name="camera" size="xl" />
        {fileDescription && <label>{fileDescription}</label>}
      </MyFileButton>
      <input
        type="file"
        ref={fileInputRef}
        accept="image/jpg, image/png, image/jpeg, image/gif"
        onChange={onChange}
        multiple
      />
    </MyFileInput>
  );
};

const MyFileInput = styled.div`
  width: 100%;
  height: 100%;
  border-radius: inherit;
  > input {
    display: none;
  }
`;

const MyFileButton = styled(Button)`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  position: relative;
  width: 100%;
  height: 100%;
  border-radius: inherit;
  overflow: hidden;
  cursor: pointer;
  > label {
    ${({ theme }) => theme.fonts.footnote};
    ${({ theme }) => theme.colors.neutral.textStrong};
  }
`;

export default FileInput;
