import { useEffect, useState } from 'react';
import { createPortal } from 'react-dom';

import Icon from '@assets/Icon';
import { SaleItem } from '@common/Item';
import NavBar from '@common/NavBar';
import Spinner from '@common/Spinner/Spinner';
import Category from '@components/home/category';
import ItemList from '@components/home/ItemList';
import useIntersectionObserver from '@hooks/useIntersectionObserver';

import { styled } from 'styled-components';

import api from '../api';

interface HomeInfo {
  page: number;
  hasPrevious: boolean;
  hasNext: boolean;
  items: SaleItem[];
}

interface HomeFilterInfo {
  sellerId: number | null;
  regionId: number;
  isSales: boolean | null;
  categoryId: number | null;
}

type HomePageInfo = Omit<HomeInfo, 'items'>;

const Home = () => {
  // TODO: filterInfo가 변하면 -> saleItems를 한 번 비워야한다.
  const [saleItems, setSaleItems] = useState<SaleItem[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isCategoryModalOpen, setIsCategoryModalOpen] = useState(false);
  const [filterInfo, setFilterInfo] = useState<HomeFilterInfo>({
    sellerId: null,
    regionId: 1,
    isSales: null,
    categoryId: null,
  });
  const [homePageInfo, setHomePageInfo] = useState<HomePageInfo>({
    page: 0,
    hasPrevious: false,
    hasNext: true,
  });

  const onIntersect: IntersectionObserverCallback = ([{ isIntersecting }]) => {
    if (isIntersecting) fetchItems();
  };

  const { setTarget } = useIntersectionObserver({ onIntersect });

  const createFilterQuery = () => {
    const { sellerId, regionId, isSales, categoryId } = filterInfo;
    const sellerQuery = sellerId ? `&sellerId=${sellerId}` : '';
    const salesQuery = isSales ? `&isSales=${isSales}` : '';
    const categoryQuery = categoryId ? `&categoryId=${categoryId}` : '';
    const filterQuery = `?page=${homePageInfo.page}${sellerQuery}&regionId=${regionId}${salesQuery}${categoryQuery}`;

    return filterQuery;
  };

  const handleCategoryModal = () => {
    setIsCategoryModalOpen((prev) => !prev);
  };

  // 필터가 한 번 밖에 안 돼...
  const handleFilterCategory = (categoryId: number) => {
    setFilterInfo((prevFilterInfo) => ({
      ...prevFilterInfo,
      categoryId: categoryId,
    }));
    console.log('-------', filterInfo);
    setSaleItems([]);
  };

  const fetchItems = async () => {
    if (!homePageInfo.hasNext) return;
    const filterQuery = createFilterQuery();

    try {
      setIsLoading(true);

      const { data } = await api.get(`items/${filterQuery}`);
      setSaleItems((prevItems) => {
        const newSet = new Set(prevItems);
        data.items.forEach((item: SaleItem) => newSet.add(item));
        return [...newSet];
      });

      setHomePageInfo({
        page: data.number + 1,
        hasPrevious: data.hasPrevious,
        hasNext: data.hasNext,
      });
    } catch (error) {
      console.error(`Failed to fetch items: ${error}`);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchItems();
  }, [filterInfo]);

  return (
    <>
      <NavBar
        left={
          <MyNavBarBtn onClick={() => 'open region popup'}>
            역삼동
            <Icon name={'chevronDown'} />
          </MyNavBarBtn>
        }
        right={
          <button onClick={handleCategoryModal}>
            <Icon name={'hamburger'} />
          </button>
        }
      />
      <ItemList saleItems={saleItems} />
      {!!saleItems.length && <MyOnFetchItems ref={setTarget}></MyOnFetchItems>}
      {isLoading && <Spinner />}
      {isCategoryModalOpen &&
        createPortal(
          <Category
            handleCategoryModal={handleCategoryModal}
            onCategoryClick={handleFilterCategory}
          />,
          document.body,
        )}
    </>
  );
};

const MyNavBarBtn = styled.button`
  display: flex;
  gap: 5px;
`;

const MyOnFetchItems = styled.div`
  margin-bottom: 75px;
`;

export default Home;
