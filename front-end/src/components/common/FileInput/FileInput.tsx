import { useRef, ChangeEvent } from 'react';

import Icon from '@assets/Icon';
import Button from '@common/Button';

import { styled } from 'styled-components';

interface FileInputProps {
  fileDescription?: string;
  onChange: (files: FileList) => void;
}

const FileInput = ({ fileDescription, onChange }: FileInputProps) => {
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleInputFile = () => fileInputRef.current?.click();

  const handleFileChange = ({ target }: ChangeEvent<HTMLInputElement>) => {
    const { files } = target;
    if (!files) return;
    onChange(files);
    target.value = '';
  };

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
        onChange={handleFileChange}
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
