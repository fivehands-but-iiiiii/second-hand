import { Suspense } from 'react';
import { Outlet, useOutletContext } from 'react-router-dom';

import MainTabBar from '@common/TabBar/MainTabBar';
import { CategoryInfo } from '@components/home/Category';
import useCategory from '@hooks/useCategory';
import usePortalBackDismiss, {
  PortalHandler,
} from '@hooks/usePortalBackDismiss';
import Loading from '@pages/Loading';

import { styled } from 'styled-components';

interface OutletContext {
  categories: CategoryInfo[];
  portalHandler: PortalHandler;
}

const Layout = () => {
  const categories = useCategory();
  const portalHandler = usePortalBackDismiss();

  return (
    <MyLayout>
      <Suspense fallback={<Loading />}>
        <Outlet context={{ categories, portalHandler }} />
      </Suspense>
      <MainTabBar />
    </MyLayout>
  );
};

export const getOutletContext = () => {
  return useOutletContext<OutletContext>();
};

const MyLayout = styled.div`
  width: 100%;
  height: 100%;
  margin: 0 auto;
  background-color: ${({ theme }) => theme.colors.neutral.background};
  text-align: center;
  overflow: auto;
  -ms-overflow-style: none;
  &::-webkit-scrollbar {
    display: none;
  }
`;

export default Layout;
