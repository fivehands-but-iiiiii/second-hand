import { useEffect, useState } from 'react';

interface useMediaQueryProps {
  mediaQuery: string;
}

const isAPISupported = (api: string): boolean =>
  typeof window !== 'undefined' ? api in window : false;

const isClient = !!(
  typeof window !== 'undefined' &&
  window.document &&
  window.document.createElement
);

const useMediaQuery = ({ mediaQuery }: useMediaQueryProps) => {
  if (!isClient || !isAPISupported('matchMedia')) {
    return false;
  }

  const [isVerified, setIsVerified] = useState(
    !!window.matchMedia(mediaQuery).matches,
  );

  useEffect(() => {
    const mediaQueryList = window.matchMedia(mediaQuery);
    const documentChangeHandler = (event: MediaQueryListEvent) =>
      setIsVerified(!!event.matches);

    try {
      mediaQueryList.addEventListener('change', documentChangeHandler);
    } catch (e) {
      mediaQueryList.addListener(documentChangeHandler);
    }

    return () => {
      try {
        mediaQueryList.removeEventListener('change', documentChangeHandler);
      } catch (e) {
        mediaQueryList.removeListener(documentChangeHandler);
      }
    };
  }, [mediaQuery]);

  return isVerified;
};

export default useMediaQuery;
