import { useEffect, useState } from 'react';

import Button from '@common/Button';
import { SaleItem } from '@common/Item';
import NavBar from '@common/NavBar';
import Spinner from '@common/Spinner/Spinner';
import { CategoryInfo } from '@components/home/category';
import ItemList from '@components/home/ItemList';
import { useCategories } from '@components/layout/Layout';
import useAllAPI from '@hooks/useAllAPI';
import useIntersectionObserver from '@hooks/useIntersectionObserver';

import { styled } from 'styled-components';

import { HomePageInfo } from '../pages/Home';

import BlankPage from './BlankPage';
import ItemDetail from './ItemDetail';

type WishCategory = Omit<CategoryInfo, 'iconUrl'>;

interface WishPage extends HomePageInfo {
  wishItems: SaleItem[];
  categories?: WishCategory[];
}

const WishList = () => {
  const title = '관심 목록';
  const categories = useCategories();
  const [selectedItem, setSelectedItem] = useState(0);
  const [selectedCategoryId, setSelectedCategoryId] = useState(0);
  const [onRefresh, setOnRefresh] = useState(false);
  const [pageInfo, setPageInfo] = useState<WishPage>({
    page: 0,
    hasPrevious: false,
    hasNext: true,
    wishItems: [],
    categories: [],
  });
  const { requestAll, loading } = useAllAPI();
  let ignore = false;

  const onIntersect: IntersectionObserverCallback = ([{ isIntersecting }]) => {
    if (isIntersecting && !loading) getWishListData();
  };

  const { setTarget } = useIntersectionObserver({ onIntersect });

  const getWishListData = async () => {
    if (!pageInfo.hasNext) return;
    try {
      const [{ data: itemData }, { data: categoriesData }] = await requestAll([
        {
          url: `wishlist?page=${pageInfo.page}${
            selectedCategoryId > 0 ? `&&category=${selectedCategoryId}` : ''
          }`,
        },
        {
          url: '/wishlist/categories',
        },
      ]);

      if (!itemData.items.length && !!categoriesData.categories.length) {
        setSelectedCategoryId(0);
        initData();
        return;
      }

      setPageInfo({
        page: itemData.page + 1,
        hasPrevious: itemData.hasPrevious,
        hasNext: itemData.hasNext,
        wishItems: [...itemData.items],
        categories: matchCategories(categoriesData.categories),
      });
    } catch (error) {
      console.error(error);
    }
  };

  const matchCategories = (categoriesData: number[]) => {
    const initCategory = [{ id: 0, title: '전체' }];
    if (!categoriesData.length) return initCategory;

    const matchedCategories = categoriesData.map((categoryId: number) => {
      const targetCategory = categories.find(({ id }) => id === categoryId);
      return (
        targetCategory && {
          id: targetCategory.id,
          title: targetCategory.title,
        }
      );
    });
    return [
      ...initCategory,
      ...(matchedCategories.filter((item) => !!item?.id) as WishCategory[]),
    ];
  };

  const initData = () => {
    setPageInfo({
      page: 0,
      hasPrevious: false,
      hasNext: true,
      wishItems: [],
      categories: [],
    });
    setOnRefresh(true);
  };

  const handleFilterCategories = (categoryId: number) => {
    if (categoryId === selectedCategoryId) return;
    setSelectedCategoryId(categoryId);
    initData();
  };

  const handleItemDetail = (itemId: number) => {
    setSelectedItem(itemId);
    if (itemId) return;
    initData();
  };

  useEffect(() => {
    if (!onRefresh) return;
    getWishListData();
    setOnRefresh(false);
  }, [onRefresh]);

  useEffect(() => {
    if (ignore) return;
    getWishListData();
    return () => {
      ignore = true;
    };
  }, []);

  return (
    <>
      <NavBar center={title} />
      <MyWishList>
        {!!pageInfo.categories?.length && (
          <MyCategories>
            {pageInfo.categories.map(({ id, title }) => {
              const isActive = id === selectedCategoryId;
              return (
                <Button
                  key={id}
                  active={isActive}
                  category
                  onClick={() => handleFilterCategories(id)}
                >
                  {title}
                </Button>
              );
            })}
          </MyCategories>
        )}
        {!!pageInfo.wishItems.length ? (
          <>
            <ItemList
              saleItems={pageInfo.wishItems}
              onItemClick={handleItemDetail}
            />
            <MyOnFetchItems ref={setTarget}></MyOnFetchItems>
            {loading && <Spinner />}
            {!!selectedItem && (
              <ItemDetail
                id={selectedItem}
                categoryInfo={categories}
                handleBackBtnClick={handleItemDetail}
              />
            )}
          </>
        ) : (
          <BlankPage title={title} />
        )}
      </MyWishList>
    </>
  );
};

const MyWishList = styled.div`
  height: calc(90vh-83px);
  overflow: auto;
  -ms-overflow-style: none;
  &::-webkit-scrollbar {
    display: none;
  }
`;

const MyCategories = styled.div`
  padding: 2vh 15px 0;
  display: flex;
  gap: 4px;
  overflow: auto;
  -ms-overflow-style: none;
  &::-webkit-scrollbar {
    display: none;
  }
  > button {
    min-width: max-content;
  }
`;

const MyOnFetchItems = styled.div`
  margin-bottom: 75px;
`;

export default WishList;
