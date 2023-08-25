import { ChangeEvent, useState } from 'react';

import Icon from '@assets/Icon';
import Button from '@common/Button';
import Textarea from '@common/Textarea';

import { styled } from 'styled-components';

import CategoryList from '../CategoryList';
import { CategoryInfo, Category } from '../itemEditor/ItemEditor';

interface TitleEditorProps {
  title: string;
  category: CategoryInfo;
  onChangeTitle: (e: ChangeEvent<HTMLTextAreaElement>) => void;
  onClickTitle: () => void;
  onClickCategory: (category: Category) => void;
}

const TitleEditor = ({
  title,
  category,
  onChangeTitle,
  onClickTitle,
  onClickCategory,
}: TitleEditorProps) => {
  const [isCategoryModalOpen, setIsCategoryModalOpen] = useState(false);

  const handleSelectCategory = (selectedCategory: Category) => {
    onClickCategory(selectedCategory);
    if (category.selectedId !== selectedCategory.id) handleCategoryModal();
  };

  const handleCategoryModal = () => setIsCategoryModalOpen((prev) => !prev);

  return (
    <MyTitleBox>
      <Textarea
        name={'title'}
        value={title}
        placeholder="글 제목"
        rows={title.length > 30 ? 2 : 1}
        maxLength={64}
        onChange={onChangeTitle}
        onClick={onClickTitle}
      />
      {!!category.recommendedCategory.length && (
        <MyTitleCategories>
          <MyCategories>
            {category.recommendedCategory.map(({ id, title }: Category) => {
              const isActive = id === category.selectedId;
              return (
                <Button
                  key={id}
                  active={isActive}
                  category
                  onClick={() => onClickCategory({ id, title })}
                >
                  {title}
                </Button>
              );
            })}
          </MyCategories>
          <Icon
            name={'chevronRight'}
            size={'xs'}
            onClick={handleCategoryModal}
          />
        </MyTitleCategories>
      )}
      {isCategoryModalOpen && (
        <CategoryList
          categories={category.total}
          selectedId={category.selectedId}
          onClickCategory={handleSelectCategory}
          onPortal={handleCategoryModal}
        />
      )}
    </MyTitleBox>
  );
};

const MyTitleBox = styled.div`
  border-bottom: 1px solid ${({ theme }) => theme.colors.neutral.border};
`;

const MyTitleCategories = styled.div`
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-bottom: 15px;
`;

const MyCategories = styled.div`
  display: flex;
  gap: 4px;
`;

export default TitleEditor;
