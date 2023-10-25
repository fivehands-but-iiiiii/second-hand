import { ReactNode } from 'react';
import useMediaQuery from '@hooks/useMediaQuery';
import styled from 'styled-components';
import DesktopLayout from './DesktopLayout';

interface ResponsiveLayoutProps {
  children: ReactNode;
}

const mobileMediaQuery = '(max-width: 768px)';
const tabletMediaQuery = '(min-width: 769px) and (max-width: 1024px)';
const desktopMediaQuery = '(min-width: 1025px)';

const ResponsiveLayout = ({ children }: ResponsiveLayoutProps) => {
  const isMobile = useMediaQuery({ mediaQuery: mobileMediaQuery });
  const isTablet = useMediaQuery({
    mediaQuery: tabletMediaQuery,
  });
  const isDesktop = useMediaQuery({
    mediaQuery: desktopMediaQuery,
  });

  return (
    <>
      {
        <MybackGround>
          {isMobile && <MyMobile>{children}</MyMobile>}
          {isTablet && <MyTablet>{children}</MyTablet>}
        </MybackGround>
      }
      {isDesktop && <DesktopLayout>{children}</DesktopLayout>}
    </>
  );
};

const MybackGround = styled.div`
  background-color: #fef3d6;
`;

const DefaultView = styled.main`
  position: relative;
  max-width: 420px;
  height: 100vh;
  background-color: ${({ theme }) => theme.colors.neutral.background};
`;

const MyMobile = styled(DefaultView)`
  margin: 0 auto;
`;

const MyTablet = styled(DefaultView)`
  min-width: 375px;
  margin: 0 auto;
`;

export default ResponsiveLayout;
