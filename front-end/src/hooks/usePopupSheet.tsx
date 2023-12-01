import { useState } from 'react';

interface Actions {
  [key: string]: () => void;
}

const usePopupSheet = (actions: Actions) => {
  const [isPopupOpen, setIsPopupOpen] = useState(false);

  const handleAction = (action: string) => {
    if (actions[action]) {
      actions[action]();
    }
    setIsPopupOpen(false);
  };

  const togglePopup = () => {
    setIsPopupOpen(!isPopupOpen);
  };

  return { isPopupOpen, handleAction, togglePopup };
};

export default usePopupSheet;
