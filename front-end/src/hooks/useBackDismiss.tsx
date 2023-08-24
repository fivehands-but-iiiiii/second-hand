import { useEffect, useCallback } from 'react';

interface UseBackDismissProps {
  isOpen: boolean;
  onClose: () => void;
}

// TODO: 적용 시도해보고 삭제 여부 결정하기
// TODO: 뒤로가기 동작이 아닌 닫기 버튼으로 포탈 닫았을 시 push한 null 값 pop해야 함
const useBackDismiss = ({ isOpen, onClose }: UseBackDismissProps) => {
  const handlePopState = useCallback(
    (event: PopStateEvent) => {
      if (isOpen) {
        event.preventDefault();
        onClose();
      }
    },
    [isOpen, onClose],
  );

  useEffect(() => {
    window.addEventListener('popstate', handlePopState);

    return () => {
      window.removeEventListener('popstate', handlePopState);
    };
  }, [handlePopState]);

  useEffect(() => {
    if (isOpen) {
      window.history.pushState(null, document.title, window.location.href);
    }
  }, [isOpen]);
};

export default useBackDismiss;
