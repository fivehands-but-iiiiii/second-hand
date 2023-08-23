import { styled, css } from 'styled-components';

interface MenuItem {
  id: string | number;
  title: string;
  style?: string;
  onClick: () => void;
}

interface PopupSheetProps {
  type: 'slideDown' | 'slideUp';
  menu: MenuItem[];
  onSheetClose?: () => void;
}

interface PopupSheetStyleProps {
  option?: string;
  isSlideDown?: boolean;
}

interface PopupSheetBackgroundProps {
  isSlideDown?: boolean;
}

// TODO: type을 받는 대신 component composition로 구현하는 게 어떨지 고민해보기
const PopupSheet = ({ type, menu, onSheetClose }: PopupSheetProps) => {
  const isSlideDown = type === 'slideDown';

  const menuOptions = (menuItems: MenuItem[]) => {
    return menuItems.map(({ id, title, style, onClick }) => (
      <MyPopupOption
        key={id}
        option={style}
        isSlideDown={isSlideDown}
        onClick={onClick}
      >
        {title}
      </MyPopupOption>
    ));
  };

  return (
    <>
      <MyPopupBackground isSlideDown={isSlideDown} onClick={onSheetClose} />
      {isSlideDown ? (
        <MyMenuPopdown onClick={(e) => e.stopPropagation()}>
          {menuOptions(menu)}
        </MyMenuPopdown>
      ) : (
        <MyPopupSheet>
          <MyMenuPopUp onClick={(e) => e.stopPropagation()}>
            {menuOptions(menu)}
          </MyMenuPopUp>
          <button onClick={onSheetClose}>취소</button>
        </MyPopupSheet>
      )}
    </>
  );
};

const MyPopupBackground = styled.div<PopupSheetBackgroundProps>`
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

const MyMenuPopdown = styled.div`
  position: absolute;
  z-index: 10;
  width: 180px;
  border: 1px solid ${({ theme }) => theme.colors.neutral.borderStrong};
  border-radius: 12px;
  background-color: ${({ theme }) => theme.colors.system.background};
`;

const MyMenuPopUp = styled.div`
  background-color: ${({ theme }) => theme.colors.system.backgroundWeak};
`;

const MyPopupSheet = styled.div`
  position: absolute;
  z-index: 10;
  width: 100%;
  padding: 0 8px;
  bottom: 0;
  color: ${({ theme }) => theme.colors.system.default};
  ${({ theme }) => theme.fonts.title3};
  font-weight: 600;
  > div {
    margin: 8px 0;
    border-radius: 12px;
  }
  > button {
    width: 100%;
    height: 60px;
    line-height: 60px;
    margin: 0 0 8px;
    border-radius: 12px;
    background-color: ${({ theme }) => theme.colors.neutral.background};
    color: ${({ theme }) => theme.colors.system.default};
    text-align: center;
    cursor: pointer;
  }
`;

const MyPopupOption = styled.div<PopupSheetStyleProps>`
  cursor: pointer;
  ${({ isSlideDown }) =>
    isSlideDown
      ? css`
          height: 45px;
          line-height: 45px;
          ${({ theme }) => theme.fonts.subhead};
          padding: 0 16px;
          ${({ theme }) => theme.colors.neutral.textStrong};
        `
      : css`
          height: 60px;
          line-height: 60px;
          ${({ theme }) => theme.fonts.title3};
          text-align: center;
        `}
  ${({ option }) => option};
  &:not(:last-child) {
    border-bottom: 0.5px solid
      ${({ theme }) => theme.colors.neutral.borderStrong};
  }
`;

export default PopupSheet;
