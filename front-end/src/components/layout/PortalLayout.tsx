import { ReactNode } from 'react';
import { createPortal } from 'react-dom';

import { styled } from 'styled-components';

interface PortalLayoutProps {
  children: ReactNode;
}

const PortalLayout = ({ children }: PortalLayoutProps) => {
  return createPortal(
    <MyPortalLayout>{children}</MyPortalLayout>,
    document.getElementById('root')?.querySelector('main') as HTMLElement,
  );
};

PortalLayout.Alert = ({ children }: PortalLayoutProps) => {
  return createPortal(
    <MyAlertPortal>{children}</MyAlertPortal>,
    document.getElementById('root')?.querySelector('main') as HTMLElement,
  );
};

const MyDefaultPortal = styled.div`
  z-index: 11000;
  position: absolute;
  top: 0;
  width: 100%;
  height: 100%;
  color: ${({ theme }) => theme.colors.neutral.text};
`;

const MyPortalLayout = styled(MyDefaultPortal)`
  background-color: ${({ theme }) => theme.colors.neutral.background};
  overflow: auto;
  -ms-overflow-style: none;
  &::-webkit-scrollbar {
    display: none;
  }
  > div {
    width: 100%;
  }
`;

const MyAlertPortal = styled(MyDefaultPortal)`
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: ${({ theme }) => theme.colors.neutral.border};
  > div {
    background-color: ${({ theme }) => theme.colors.neutral.background};
  }
`;

export default PortalLayout;
