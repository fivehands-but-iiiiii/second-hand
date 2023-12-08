import { KeyboardEvent } from 'react';

interface useEnterKeyPressProps {
  onEnterPress: () => void;
}

const useEnterKeyPress = ({ onEnterPress }: useEnterKeyPressProps) => {
  const handleKeyDown = ({ key }: KeyboardEvent) => {
    if (key === 'Enter') {
      onEnterPress();
    }
  };

  return { handleKeyDown };
};

export default useEnterKeyPress;
