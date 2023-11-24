import { ReactNode } from 'react';

import Button from '@common/Button';
import useMediaQuery from '@hooks/useMediaQuery';

import { styled } from 'styled-components';

interface ResponsiveLayoutProps {
  children: ReactNode;
}

const desktopMediaQuery = '(min-width: 1025px)';

const ResponsiveLayout = ({ children }: ResponsiveLayoutProps) => {
  const isDesktop = useMediaQuery({
    mediaQuery: desktopMediaQuery,
  });

  return (
    <>
      {isDesktop && (
        <MyLeftArea>
          <div>
            <MyDescription>
              <h2>
                <b>Fivehands - </b>
                <span>중고거래를 더 편리하게</span>
              </h2>
              <p>
                Fivehands는 간단하고 직관적인 인터페이스로 중고 상품을
                <br />
                손쉽게 등록하고 실시간 채팅을 통해 거래할 수 있는 기능을
                제공합니다.
              </p>
              <p>
                지금 Fivehands를 방문하고, 간단한 회원가입을 통해 지역 기반으로
                <br />
                동네 주민들과 가깝고 따뜻한 거래를 경험해보세요!
              </p>
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
            </MyDescription>
            <MyTitle>
              <img src="/images/second-hand-icon.png" alt="leftArea" />
              <span>fivehands-but-iiiiii</span>
            </MyTitle>
          </div>
        </MyLeftArea>
      )}
      <main>{children}</main>
    </>
  );
};

const MyLeftArea = styled.div`
  position: fixed;
  height: 100%;
  left: calc(50vw - 30rem);
  width: 32rem;
  > div {
    width: 100%;
    height: 100%;
    max-width: 30rem;
    padding: 7rem 0 3.2rem;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }
`;

const MyDescription = styled.div`
  width: 380px;
  height: 500px;
  color: ${({ theme }) => theme.colors.neutral.text};
  line-height: 2;
  ${({ theme }) => theme.fonts.footnote};
  span {
    color: ${({ theme }) => theme.colors.accent.backgroundPrimary};
  }
`;

const MyButton = styled.div`
  margin-top: 1rem;
  > button {
    background-color: ${({ theme }) => theme.colors.neutral.background};
    color: ${({ theme }) => theme.colors.neutral.text};
    border: none;
  }
`;

const MyTitle = styled.div`
  color: ${({ theme }) => theme.colors.accent.backgroundPrimary};
  ${({ theme }) => theme.fonts.callout};
  img {
    width: 36px;
    padding-right: 10px;
  }
`;
export default ResponsiveLayout;
