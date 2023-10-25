import { useEffect, useState } from 'react';

import Button from '@common/Button';
import { SaleItem } from '@common/Item';
import NavBar from '@common/NavBar';
import Spinner from '@common/Spinner/Spinner';
import { CategoryInfo } from '@components/home/category';
import ItemList from '@components/home/ItemList';
import { getOutletContext } from '@components/layout';
import useAllAPI from '@hooks/useAllAPI';
import useIntersectionObserver from '@hooks/useIntersectionObserver';

import { styled } from 'styled-components';

import { HomeInfo, HomePageInfo } from '../pages/Home';

import BlankPage from './BlankPage';
import ItemDetail from './ItemDetail';

type WishCategory = Omit<CategoryInfo, 'iconUrl'>;
type WishCategoryInfo = {
  categories: number[];
};

interface WishPage extends HomePageInfo {
  wishItems: SaleItem[];
  categories?: WishCategory[];
}

const WishList = () => {
  const title = '관심 목록';
  const { categories } = getOutletContext();
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

  const onIntersect: IntersectionObserverCallback = ([{ isIntersecting }]) => {
    if (isIntersecting && !loading) getWishList();
  };

  const { setTarget } = useIntersectionObserver({ onIntersect });

  const getWishList = async () => {
    if (!pageInfo.hasNext) return;

    const [itemData, categoriesData] = await fetchWishList();
    if (!itemData.items.length && !!categoriesData.categories.length) {
      setSelectedCategoryId(0);
      initData();
      return;
    }
    updateWishList(itemData, categoriesData);
  };

  const fetchWishList = async () => {
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
      return [itemData, categoriesData];
    } catch (error) {
      console.error(error);
      throw error;
    }
  };

  const updateWishList = (item: HomeInfo, category: WishCategoryInfo) => {
    setPageInfo({
      page: item.page + 1,
      hasPrevious: item.hasPrevious,
      hasNext: item.hasNext,
      wishItems: [...item.items],
      categories: matchCategories(category.categories),
    });
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
    getWishList();
    setOnRefresh(false);
  }, [onRefresh]);

  useEffect(() => {
    let ignore = false;

    fetchWishList().then(([itemData, categoriesData]) => {
      if (!ignore) updateWishList(itemData, categoriesData);
    });

    return () => {
      ignore = true;
    };
  }, []);

  return (
    <>
      <NavBar center={title} />
      <MyWishList>
        {wishCategories.length > 1 && (
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
