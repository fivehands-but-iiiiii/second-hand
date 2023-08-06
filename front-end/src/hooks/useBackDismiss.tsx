import { useEffect, useCallback } from 'react';

interface UseBackDismissProps {
  isOpen: boolean;
  onClose: () => void;
}

const useBackDismiss = ({ isOpen, onClose }: UseBackDismissProps) => {
  console.log('onpopstate:', window.onpopstate);

  const handlePopState = useCallback(
    (event: PopStateEvent) => {
      console.log('pop State : /home');
      if (isOpen) {
        event.preventDefault();
        onClose();
      }
    },
    [isOpen, onClose],
  );

  useEffect(() => {
    window.onpopstate = handlePopState;
    console.log('add event listener : pop state');

    return () => {
      console.log('clean up');
      window.onpopstate = null;
    };
  }, []);

  useEffect(() => {
    if (isOpen) {
      console.log('push State : /home + null');
      window.history.pushState(null, document.title, window.location.href);
    }
  }, [isOpen]);
};

export default useBackDismiss;
