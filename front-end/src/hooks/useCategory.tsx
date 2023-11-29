import { useEffect, useState } from 'react';

import { CategoryInfo } from '@components/home/category';

import useAPI from './useAPI';

const useCategory = () => {
  const [categories, setCategories] = useState<CategoryInfo[]>([]);
  const { request } = useAPI();

  useEffect(() => {
    let ignore = false;
    if (categories.length) return;

    request({
      url: '/resources/categories',
    })
      .then(({ data }) => {
        if (!ignore) setCategories(data.categories);
      })
      .catch((error) => {
        console.error(error);
      });

    return () => {
      ignore = true;
    };
  }, []);

  return categories;
};

export default useCategory;
