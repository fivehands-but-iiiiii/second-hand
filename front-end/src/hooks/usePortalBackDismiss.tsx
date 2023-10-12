import { useState, useEffect } from 'react';

type ClosePortalFunction = () => void;

function usePortalBackDismiss() {
  const [closeFunctions, setCloseFunctions] = useState<ClosePortalFunction[]>(
    [],
  );

  useEffect(() => {
    const handlePopState = () => {
      if (closeFunctions.length > 0) {
        const lastCloseFunction = closeFunctions[closeFunctions.length - 1];
        lastCloseFunction();

        const updatedCloseFunctions = [...closeFunctions];
        updatedCloseFunctions.pop();
        setCloseFunctions(updatedCloseFunctions);
      }
    };

    window.addEventListener('popstate', handlePopState);

    return () => {
      window.removeEventListener('popstate', handlePopState);
    };
  }, [closeFunctions]);

  const registerPortal = (closeFunction: ClosePortalFunction) => {
    window.history.pushState({}, '', `#portal-${Date.now()}`);
    setCloseFunctions((prev) => [...prev, closeFunction]);
  };

  return {
    registerPortal,
  };
}

export default usePortalBackDismiss;
