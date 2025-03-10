import Icon from '@assets/Icon';
import Button from '@common/Button';
import ImgBox from '@common/ImgBox';
import NavBar from '@common/NavBar/NavBar';
import PortalLayout from '@components/layout/PortalLayout';

import { styled } from 'styled-components';

export interface CategoryInfo {
  id: number;
  title: string;
  iconUrl: string;
}

interface CategoryProps {
  categoryInfo: CategoryInfo[];
  handleCategoryModal: () => void;
  onCategoryClick?: (categoryId: number) => void;
}
// TODO: Event Handler Prop prefix 'on'
const Category = ({
  categoryInfo,
  handleCategoryModal,
  onCategoryClick,
}: CategoryProps) => {
  const handleCategoryClick = (categoryId: number) => {
    handleCategoryModal();
    onCategoryClick && onCategoryClick(categoryId);
  };

  return (
    <PortalLayout>
      <NavBar
        left={
          <MyCategoryCloseBtn onClick={handleCategoryModal}>
            <Icon name={'chevronLeft'} />
            닫기
          </MyCategoryCloseBtn>
        }
        center={'카테고리'}
      />
      <MyCategoryContainer>
        {categoryInfo?.map((icon) => (
          <Button
            key={icon.id}
            icon
            onClick={() => handleCategoryClick(icon.id)}
          >
            <ImgBox
              src={icon.iconUrl}
              size="sm"
              alt={icon.title}
              loading="lazy"
            />
            <MyCategoryTitle>{icon.title}</MyCategoryTitle>
          </Button>
        ))}
      </MyCategoryContainer>
    </PortalLayout>
  );
};

const MyCategoryCloseBtn = styled.button`
  display: flex;
  gap: 5px;
`;

const MyCategoryContainer = styled.div`
  height: 87vh;
  width: 100%;
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  background-color: ${({ theme }) => theme.colors.neutral.background};
`;

const MyCategoryTitle = styled.span`
  font-size: 0.95em;
`;

export default Category;
