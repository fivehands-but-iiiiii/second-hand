import Button from '@common/Button';
import { ReactNode } from 'react';
import { styled } from 'styled-components';

interface DesktopLayoutProps {
  children: ReactNode;
}

const DesktopLayout = ({ children }: DesktopLayoutProps) => {
  return (
    <MyDesktopBackground>
      <MyLeftArea>
        <div>
          <MyButton>
            <Button
              onClick={() =>
                window.open(
                  'https://github.com/masters2023-2nd-project-05/second-hand/wiki',
                  '_blank',
                )
              }
            >
              Second-hand 프로젝트 팀5 Wiki로 이동
            </Button>
          </MyButton>
          <MyTitle>
            <img src="/images/second-hand-icon.png" alt="leftArea" />
            <span>fivehands-but-iiiiii</span>
          </MyTitle>
        </div>
      </MyLeftArea>
      <MyDesktop>{children}</MyDesktop>
    </MyDesktopBackground>
  );
};

const MyDesktopBackground = styled.div`
  background-image: url(/images/second-hand-background.png);
  background-repeat: no-repeat;
  background-size: cover;
  background-position: center;
`;

const MyLeftArea = styled.div`
  position: fixed;
  height: 100%;
  left: calc(50vw - 32rem);
  width: 32rem;
  > div {
    width: 100%;
    height: 100%;
    max-width: 30rem;
    padding: 2.7rem 0px 3.2rem;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }
`;

const MyTitle = styled.div`
  color: ${({ theme }) => theme.colors.accent.backgroundPrimary};
  ${({ theme }) => theme.fonts.headline};
  img {
    width: 40px;
  }
`;

const MyDesktop = styled.main`
  left: 50vw;
  position: relative;
  max-width: 420px;
  height: 100vh;
  background-color: ${({ theme }) => theme.colors.neutral.background};
`;

const MyButton = styled.div`
  > button {
    background-color: ${({ theme }) => theme.colors.neutral.background};
    color: ${({ theme }) => theme.colors.neutral.text};
    border: none;
  }
`;

export default DesktopLayout;
