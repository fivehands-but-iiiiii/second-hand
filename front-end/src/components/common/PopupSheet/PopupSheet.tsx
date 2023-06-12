import { styled, css } from 'styled-components';

interface MenuItem {
  id: string;
  title: string;
  style?: string;
}

interface PopupSheetProps {
  type: 'slideDown' | 'slideUp';
  menu: MenuItem[];
  onClose?: () => void;
}

interface PopupSheetStyleProps {
  option?: string;
  slidedown?: boolean;
}

const PopupSheet = ({ type, menu, onClose }: PopupSheetProps) => {
  const isSlideDown = type === 'slideDown';

  return (
    <>
      {isSlideDown ? (
        <MyMenuPopdown>
          {menu &&
            menu.map(({ id, title, style }) => (
              <MyPopupOption key={id} option={style} slidedown>
                {title}
              </MyPopupOption>
            ))}
        </MyMenuPopdown>
      ) : (
        <>
          <MyPopupBackground />
          <MyPopupSheet>
            <MyMenuPopUp>
              {menu &&
                menu.map(({ id, title, style }) => (
                  <MyPopupOption key={id} option={style}>
                    {title}
                  </MyPopupOption>
                ))}
            </MyMenuPopUp>
            <MyCancelButton onClick={onClose}>취소</MyCancelButton>
          </MyPopupSheet>
        </>
      )}
    </>
  );
};

//  TODO: 포지션 지정 top, left 필요함
const MyMenuPopdown = styled.div`
  position: absolute;
  width: 240px;
  border: 1px solid ${({ theme }) => theme.colors.neutral.borderStrong};
  border-radius: 12px;
  background-color: ${({ theme }) => theme.colors.system.background};
`;

// TODO: width 100%으로 변경
const MyPopupBackground = styled.div`
  position: absolute;
  z-index: 1;
  top: 50%;
  left: 50%;
  width: 393px;
  height: 100%;
  background-color: ${({ theme }) => theme.colors.neutral.overlay};
  opacity: 0.5;
  transform: translate(-50%, -50%);
`;

const MyPopupSheet = styled.div`
  position: fixed;
  z-index: 2;
  width: 377px;
  height: fit-content;
  max-height: 90%;
  bottom: 0;
`;

const MyMenuPopUp = styled.div`
  border: 1px solid ${({ theme }) => theme.colors.neutral.borderStrong};
  border-radius: 1rem;
  background-color: ${({ theme }) => theme.colors.system.backgroundWeak};
`;

const MyPopupOption = styled.div<PopupSheetStyleProps>`
  height: 60px;
  line-height: 60px;
  ${({ slidedown }) =>
    slidedown &&
    css`
      height: 45px;
      line-height: 45px;
    `}
  text-align: center;
  ${({ theme }) => theme.fonts.title3};
  ${({ option }) => option};
  &:not(:last-child) {
    border-bottom: 1px solid ${({ theme }) => theme.colors.neutral.borderStrong};
  }
`;

const MyCancelButton = styled.button`
  margin: 8px 0;
  width: 100%;
  height: 60px;
  background-color: ${({ theme }) => theme.colors.neutral.background};
  border-radius: 13px;
  border: 1px solid ${({ theme }) => theme.colors.neutral.borderStrong};
  color: ${({ theme }) => theme.colors.system.default};
  ${({ theme }) => theme.fonts.title3};
  font-weight: 600;
`;

export default PopupSheet;
