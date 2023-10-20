import { useState, useEffect, useCallback } from 'react';

export interface PortalHandler {
  registerPortal: (
    closeFunction: ClosePortalFunction,
    urlSuffix?: string,
  ) => void;
  unregisterLastPortal: () => void;
}

type ClosePortalFunction = () => void;

const usePortalBackDismiss = (): PortalHandler => {
  const [closeFunctions, setCloseFunctions] = useState<ClosePortalFunction[]>(
    [],
  );

  const handlePopState = useCallback(() => {
    if (closeFunctions.length > 0) {
      const lastCloseFunction = closeFunctions[closeFunctions.length - 1];
      lastCloseFunction();

      const updatedCloseFunctions = [...closeFunctions];
      updatedCloseFunctions.pop();
      setCloseFunctions(updatedCloseFunctions);
    }
  }, [closeFunctions]);

  useEffect(() => {
    window.addEventListener('popstate', handlePopState);

    return () => {
      window.removeEventListener('popstate', handlePopState);
    };
  }, [handlePopState]);

  const unregisterLastPortal = useCallback(() => {
    if (closeFunctions.length > 0) {
      window.history.back();
    }
  }, [closeFunctions]);

  const registerPortal = (
    closeFunction: ClosePortalFunction,
    urlSuffix = `#portal-${Date.now()}`,
  ) => {
    window.history.pushState({}, '', urlSuffix);
    setCloseFunctions((prev) => [...prev, closeFunction]);
  };

  return {
    registerPortal,
    unregisterLastPortal, // 모달 닫기 버튼에서 이 함수를 호출합니다.
  };
};

export default usePortalBackDismiss;

// NOTO: Date.now()로 유니크한 식별자 사용
// 1. 동시 다발적인 포탈이 열릴 경우 유니크한 URL을 가지게 함
// 2. 유니크하지 않을 경우 동일한 URL에 대해 여러 pushState 호출이 허용되지 않을 수 있음
