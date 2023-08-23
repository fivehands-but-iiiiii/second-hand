import { styled, css } from 'styled-components';

interface MenuItem {
  id: string | number;
  title: string;
  style?: string;
  onClick: () => void;
}
interface PopupSheetProps {
  isSlideDown?: boolean;
  menu: MenuItem[];
  onClick?: () => void;
}

interface PopupSheetStyleProps {
  isSlideDown?: boolean;
}

interface OptionStyleProps extends PopupSheetStyleProps {
  option?: string;
}

const PopupSheet = ({
  isSlideDown = false,
  menu,
  onClick,
}: PopupSheetProps) => {
  return (
    <>
      <MyPopupSheetBackground isSlideDown={isSlideDown} onClick={onClick} />
      <SlideSheet isSlideDown={isSlideDown} menu={menu} onClick={onClick} />
    </>
  );
};

const SlideSheet = ({ isSlideDown, menu, onClick }: PopupSheetProps) => {
  return (
    <MyMenuPopupSheet isSlideDown={isSlideDown}>
      <MySlideSheet
        isSlideDown={isSlideDown}
        onClick={(e) => e.stopPropagation()}
      >
        {menu.map(({ id, title, style, onClick }) => (
          <MyPopupOption
            key={id}
            option={style}
            isSlideDown={isSlideDown}
            onClick={onClick}
          >
            {title}
          </MyPopupOption>
        ))}
      </MySlideSheet>
      {!isSlideDown && <MyCancelButton onClick={onClick}>취소</MyCancelButton>}
    </MyMenuPopupSheet>
  );
};

const MyPopupSheetBackground = styled.div<PopupSheetStyleProps>`
  position: absolute;
  z-index: 1;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  ${({ isSlideDown, theme }) =>
    isSlideDown
      ? css`
          opacity: 0;
        `
      : css`
          background-color: ${theme.colors.neutral.overlay};
        `}
`;

const MySlideSheet = styled.div<PopupSheetStyleProps>`
  display: flex;
  flex-direction: column;
  border-radius: 12px;
  ${({ isSlideDown }) =>
    isSlideDown
      ? css`
          z-index: 10;
          position: absolute;
          width: 180px;
          border: 1px solid ${({ theme }) => theme.colors.neutral.borderStrong};
          background-color: ${({ theme }) => theme.colors.system.background};
        `
      : css`
          margin: 8px 0;
          background-color: ${({ theme }) =>
            theme.colors.system.backgroundWeak};
        `}
`;

const MyMenuPopupSheet = styled.div<PopupSheetStyleProps>`
  ${({ isSlideDown }) =>
    !isSlideDown &&
    css`
      z-index: 10;
      position: absolute;
      bottom: 0;
      width: 100%;
      padding: 0 8px;
      ${({ theme }) => theme.fonts.title3};
      font-weight: 600;
    `}
`;

const MyCancelButton = styled.button`
  width: 100%;
  height: 60px;
  line-height: 60px;
  margin: 0 0 8px;
  border-radius: 12px;
  background-color: ${({ theme }) => theme.colors.neutral.background};
  color: ${({ theme }) => theme.colors.system.default};
`;

const MyPopupOption = styled.button<OptionStyleProps>`
  ${({ isSlideDown }) =>
    isSlideDown
      ? css`
          height: 45px;
          line-height: 45px;
          ${({ theme }) => theme.fonts.subhead};
          padding: 0 16px;
          text-align: left;
        `
      : css`
          height: 60px;
          line-height: 60px;
          ${({ theme }) => theme.fonts.title3};
          color: ${({ theme }) => theme.colors.system.default};
        `}
  ${({ option }) => option};
  &:not(:last-child) {
    border-bottom: 0.5px solid
      ${({ theme }) => theme.colors.neutral.borderStrong};
  }
`;

export default PopupSheet;
