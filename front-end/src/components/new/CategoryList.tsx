import NavBar from '@common/NavBar';
import PortalLayout from '@components/layout/PortalLayout';

import { styled } from 'styled-components';

import { Category } from './itemEditor/ItemEditor';
interface CategoryListProps {
  categories: Category[];
  selectedId: number;
  onClickCategory: (category: Category) => void;
  onPortal: () => void;
}

interface CategoryStyleProps {
  active: boolean;
}

const CategoryList = ({
  categories,
  selectedId,
  onClickCategory,
  onPortal,
}: CategoryListProps) => {
  return (
    <PortalLayout>
      <NavBar
        left={<button onClick={onPortal}>닫기</button>}
        center={'카테고리'}
      ></NavBar>
      <MyCategoryList>
        <ul>
          {categories?.map(({ id, title }) => (
            <MyCategory active={id === selectedId} key={id}>
              <button onClick={() => onClickCategory({ id, title })}>
                {title}
              </button>
            </MyCategory>
          ))}
        </ul>
      </MyCategoryList>
    </PortalLayout>
  );
};

const MyCategoryList = styled.div`
  height: 90vh;
  padding-bottom: 0.5rem;
  ul {
    height: 100%;
    ${({ theme }) => theme.fonts.subhead}
    color: ${({ theme }) => theme.colors.neutral.text};
    overflow: auto;
    > li:not(:last-child) {
      border-bottom: 1px solid ${({ theme }) => theme.colors.neutral.border};
    }
  }
`;

const MyCategory = styled.li<CategoryStyleProps>`
  height: 6vh;
  min-height: 40px;
  margin: 0 1rem;
  text-align: start;
  cursor: pointer;
  > button {
    width: 100%;
    height: 100%;
    text-align: left;
    color: ${({ theme, active }) =>
      active
        ? theme.colors.accent.backgroundPrimary
        : theme.colors.neutral.text};
  }
`;

export default CategoryList;
