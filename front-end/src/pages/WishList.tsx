import { useEffect, useState } from 'react';

import Button from '@common/Button';
import { SaleItem } from '@common/Item';
import NavBar from '@common/NavBar';
import ItemList from '@components/home/ItemList/ItemList';

import { styled } from 'styled-components';

import api from '../api';
// TODO: wishList api 연결
const WishList = () => {
  const title = '관심 목록';
  const [wishItems, setWishItems] = useState<SaleItem[]>([]);
  const [categories, setCategories] = useState([{ id: 0, title: '전체' }]);
  const [currentCategoryId, setCurrentCategoryId] = useState(0);

  // const getWishList = async () => {
  //   try {
  // const { data } = await api.get('/wishlist');
  // TODO: 위시목록 데이터 나오면 path 수정
  // setWishItems(data.items);
  // data.categories && setCategories([...categories, data.categories]);
  //   } catch (error) {
  //     console.error(`Failed to get wishList: ${error}`);
  //   }
  // };

  const handleFilterCategories = (categoryId: number) => {
    setCurrentCategoryId(categoryId);
    // getFilteredItems();
  };

  // const getFilteredItems = async () => {
  //   try {
  //     const { data } = await api.get(`/wishlist?category=${currentCategoryId}`);
  //     setWishItems(data?.items);
  //   } catch (error) {
  //     console.error(`Failed to filter categories: ${error}`);
  //   }
  // };

  useEffect(() => {
    // getWishList();
  }, []);

  return (
    <>
      <NavBar center={title} />
      <MyWishList>
        <MyCategories>
          {categories.map(({ id, title }) => {
            const isActive = id === currentCategoryId;
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
        <ItemList saleItems={wishItems} />
      </MyWishList>
    </>
  );
};

const MyWishList = styled.div`
  padding: 0 2.7vw;
  height: calc(100%-83px);
`;

const MyCategories = styled.div`
  padding: 2vh 0;
  display: flex;
  gap: 4px;
`;

export default WishList;
