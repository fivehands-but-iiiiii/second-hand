import { Suspense } from 'react';
import { Outlet, useOutletContext } from 'react-router-dom';

import MainTabBar from '@common/TabBar/MainTabBar';
import { CategoryInfo } from '@components/home/category';
import useCategory from '@hooks/useCategory';
import Loading from '@pages/Loading';

import { styled } from 'styled-components';

const Layout = () => {
  const categories = useCategory();

  return (
    <MyLayout>
      <Suspense fallback={<Loading />}>
        <Outlet context={categories} />
      </Suspense>
      <MainTabBar />
    </MyLayout>
  );
};

export const useCategories = () => {
  return useOutletContext<CategoryInfo[]>();
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
