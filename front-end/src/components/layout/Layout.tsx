import { Suspense, useEffect, useState } from 'react';
import { Outlet, useOutletContext } from 'react-router-dom';

import MainTabBar from '@common/TabBar/MainTabBar';
import { CategoryInfo } from '@components/home/category';
import Loading from '@components/login/Loading';
import useAPI from '@hooks/useAPI';

import { styled } from 'styled-components';

const Layout = () => {
  const [categories, setCategories] = useState<CategoryInfo[]>([]);
  const { request } = useAPI();

  const getCategories = async () => {
    if (categories.length) return;
    try {
      const { data } = await request({
        url: '/resources/categories',
      });
      setCategories(data.categories);
    } catch (error) {
      console.error(error);
    }
  };

  useEffect(() => {
    getCategories();
  }, []);

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
  width: 100vw;
  height: 100vh;
  background-color: ${({ theme }) => theme.colors.neutral.background};
  text-align: center;
  overflow: auto;
  -ms-overflow-style: none;
  &::-webkit-scrollbar {
    display: none;
  }
`;

export default Layout;
