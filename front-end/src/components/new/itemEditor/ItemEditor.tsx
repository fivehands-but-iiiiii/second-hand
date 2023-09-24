import { useEffect, useState, ChangeEvent, MouseEvent } from 'react';

import Icon from '@assets/Icon';
import LabelInput from '@common/LabelInput';
import NavBar from '@common/NavBar';
import SubTabBar from '@common/TabBar/SubTabBar';
import Textarea from '@common/Textarea';
import { InputFile, RegionInfo } from '@components/login/Join';
import useAPI from '@hooks/useAPI';
import { getFormattedPrice, getNumericPrice } from '@utils/formatText';
import { getPreviewFile } from '@utils/getPreviewFile';
import { getStoredValue } from '@utils/sessionStorage';

import { styled } from 'styled-components';

import ImageEditor from '../itemEditor/ImageEditor';
import TitleEditor from '../itemEditor/TitleEditor';
export interface Category {
  id: number;
  title: string;
}

export interface CategoryInfo {
  total: Category[];
  recommendedCategory: Category[];
  selectedId: number;
}

export interface ItemInfo {
  id: number;
  title: string;
  contents: string;
  region: number;
  category: number;
  price: string;
  images: string[];
}

export interface OriginItem {
  id: number;
  title: string;
  contents: string;
  category: number;
  price: string;
  images: { url: string }[];
}

interface ItemEditorProps {
  categoryInfo: Category[];
  origin?: OriginItem;
  onPortal: () => void;
}

const ItemEditor = ({ categoryInfo, origin, onPortal }: ItemEditorProps) => {
  const pageTitle = origin ? '상품 수정' : '새 상품 등록';
  const userInfo = getStoredValue({ key: 'userInfo' });
  const currentRegion = userInfo?.regions.find(
    ({ onFocus }: RegionInfo) => onFocus,
  );
  const [files, setFiles] = useState<InputFile[]>([]);
  const [title, setTitle] = useState('');
  const [price, setPrice] = useState('');
  const [contents, setContents] = useState('');
  const [category, setCategory] = useState<CategoryInfo>({
    total: [...categoryInfo],
    recommendedCategory: [],
    selectedId: 0,
  });
  const [firstClickTitle, setFirstClickTitle] = useState(false);
  const { request } = useAPI();

  const isFormValid =
    files.length > 0 &&
    title.length > 0 &&
    contents.length > 0 &&
    category.selectedId > 0 &&
    currentRegion.id > 0;

  const handleInputFiles = async (newFiles: FileList) => {
    if (!newFiles || files.length >= 10) return;

    const updatedFiles = [...newFiles]
      .map(async (file) => {
        const newPreview = await getPreviewFile(file);
        return {
          preview: newPreview,
          file: file,
        };
      })
      .slice(0, 10 - files.length);

    const newFilesList = await Promise.all(updatedFiles);
    setFiles((prev) => [...prev, ...newFilesList]);
  };

  const handleSubmit = async () => {
    try {
      if (origin) {
        await editItem();
        onPortal();
        return;
      }
      const isPosted = await postNewItem();
      if (!isPosted) return;

      onPortal();
    } catch (error) {
      console.error('error');
    }
  };

  const editItem = async () => {
    const newFiles = await editImageFiles();
    if (!newFiles) return;

    const newImageFiles = [
      ...files
        .filter(({ preview, file }) => (!file ? preview : null))
        .map(({ preview }) => ({ url: preview })),
      ...newFiles.map((image) => ({ url: image })),
    ];
    const editedData = {
      title: title,
      contents: contents,
      category: category.selectedId,
      region: currentRegion.id,
      price: getNumericPrice(price),
      images: newImageFiles,
      firstImageUrl: newImageFiles && newImageFiles[0],
    };

    try {
      await request({
        url: `/items/${origin?.id}`,
        method: 'put',
        config: {
          data: editedData,
        },
      });
    } catch (error) {
      console.log(error);
    }
  };

  const editImageFiles = async () => {
    try {
      const newImages = await Promise.all(
        files
          .filter(({ file }) => file)
          .map(async ({ file }) => {
            const formData = new FormData();
            formData.append('itemImages', file as Blob, file?.name);
            const { data } = await request({
              url: '/items/image',
              method: 'post',
              config: {
                data: formData,
                headers: {
                  'Content-Type': 'multipart/form-data',
                },
              },
            });
            return data.imageUrl;
          }),
      );
      return newImages;
    } catch (error) {
      console.log(error);
    }
  };

  const postNewItem = async () => {
    const formData = new FormData();
    files.forEach(({ file }) => {
      formData.append('images', file as Blob, file?.name);
    });
    formData.append('title', title);
    formData.append('contents', contents);
    formData.append('category', category.selectedId.toString());
    formData.append('price', getNumericPrice(price).toString());
    formData.append('region', currentRegion.id.toString());

    try {
      const response = await request({
        url: '/items',
        method: 'post',
        config: {
          data: formData,
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        },
      });
      return response.data ? true : false;
    } catch (error) {
      return false;
    }
  };

  const handleDeleteFile = ({
    currentTarget,
  }: MouseEvent<HTMLButtonElement>) => {
    const { value } = currentTarget;
    setFiles((prev) => prev.filter((_, index) => index !== Number(value)));
  };

  const handleTitle = ({ target }: ChangeEvent<HTMLTextAreaElement>) => {
    const { value } = target;
    setTitle(value);
  };

  const randomCategories = (): Category[] => {
    const RANDOM_COUNT = 3;
    const randomCategories: Category[] = [];
    const usedId = [];

    if (origin) {
      const originCategoryId = origin.category;
      const categoryTitle = categoryInfo.find(
        (item) => item.id === originCategoryId,
      )?.title;
      if (categoryTitle) {
        randomCategories.push({
          id: originCategoryId,
          title: categoryTitle,
        });
        usedId.push(originCategoryId);
      }
    }

    while (randomCategories.length < RANDOM_COUNT) {
      const randomId = Math.floor(Math.random() * categoryInfo.length);
      if (!usedId.includes(randomId)) {
        usedId.push(randomId);
        const randomCategory = categoryInfo.find(({ id }) => id === randomId);
        if (randomCategory) randomCategories.push(randomCategory);
      }
    }
    return randomCategories;
  };

  const handleRecommendationCategory = () => {
    if (firstClickTitle || origin) return;

    const timeOutId = setTimeout(() => {
      const recommendedCategories = randomCategories();
      setCategory((prev) => ({
        ...prev,
        recommendedCategory: recommendedCategories,
      }));
      setFirstClickTitle(true);
    }, 1500);

    return () => {
      clearTimeout(timeOutId);
    };
  };

  const handleCategory = (updatedCategory: Category) => {
    const isSameCategory = category.selectedId === updatedCategory.id;
    const isExistingCategory = category.recommendedCategory.some(
      ({ id }) => id === updatedCategory.id,
    );

    if (isSameCategory) return resetSelectedCategory();
    if (isExistingCategory) return updateSelectedCategory(updatedCategory.id);
    return updateRecommendedCategory(updatedCategory);
  };

  const resetSelectedCategory = () => {
    setCategory((prev) => ({ ...prev, selectedId: 0 }));
  };

  const updateSelectedCategory = (categoryId: number) => {
    setCategory((prev) => ({ ...prev, selectedId: categoryId }));
  };

  const updateRecommendedCategory = (updatedCategory: Category) => {
    const recommendedCategory = [
      updatedCategory,
      ...category.recommendedCategory.filter(
        (category) => category.id !== updatedCategory.id,
      ),
    ].slice(0, 3);

    setCategory((prev) => ({
      ...prev,
      recommendedCategory: recommendedCategory,
      selectedId: updatedCategory.id,
    }));
  };

  const handlePrice = ({ target }: ChangeEvent<HTMLInputElement>) => {
    const { value } = target;
    const formattedPrice = getFormattedPrice(value);
    setPrice(formattedPrice);
  };

  const handleContents = ({ target }: ChangeEvent<HTMLTextAreaElement>) => {
    const { value } = target;
    setContents(value);
  };

  const getMappedOrigin = (origin: OriginItem) => {
    if (!origin) return;

    const originCategory = categoryInfo.find(
      (item) => item.id === origin.category,
    );
    setTitle(origin.title);
    setContents(origin.contents);
    setPrice(origin.price);
    setCategory((prev) => ({
      ...prev,
      selectedId: originCategory?.id as number,
    }));
    setFiles(
      origin.images.map((image) => ({
        preview: image.url,
      })),
    );
  };

  useEffect(() => {
    if (!origin) return;

    const recommendedCategory = randomCategories();
    setCategory((prev) => ({
      ...prev,
      recommendedCategory: recommendedCategory,
    }));
    getMappedOrigin(origin);
  }, [origin]);

  return (
    <>
      <NavBar
        left={<button onClick={onPortal}>닫기</button>}
        center={pageTitle}
        right={
          <button disabled={!isFormValid} onClick={handleSubmit}>
            완료
          </button>
        }
      />
      <MyNew>
        <ImageEditor
          files={files}
          onChange={handleInputFiles}
          onClick={handleDeleteFile}
        />
        <TitleEditor
          title={title}
          category={category}
          onChangeTitle={handleTitle}
          onClickTitle={handleRecommendationCategory}
          onClickCategory={handleCategory}
        />
        <MyPrice
          label={'₩'}
          name={'price'}
          value={price}
          maxLength={20}
          placeholder={'가격(선택사항)'}
          onChange={handlePrice}
        />
        <Textarea
          name={'contents'}
          value={contents}
          placeholder={`${currentRegion.district}에 올릴 게시물 내용을 작성해주세요.`}
          onChange={handleContents}
        />
      </MyNew>
      <SubTabBar icon={'location'} content={`${currentRegion.district}`}>
        <Icon name="keyboard" />
      </SubTabBar>
    </>
  );
};

const MyNew = styled.div`
  width: 100vw;
  height: calc(90vh - 85px);
  padding: 0 2.7vw;
  > div:nth-child(1) {
    padding: 15px 0;
  }
  > div:last-child {
    padding-top: 10px;
    max-height: 45vh;
    > textarea {
      max-height: 45vh;
      overflow: auto;
    }
  }
`;

const MyPrice = styled(LabelInput)`
  padding: 15px 15px 15px 0;
  line-height: 1.5;
  label {
    padding-left: 15px;
    ${({ theme }) => theme.colors.neutral.border};
  }
`;

export default ItemEditor;
