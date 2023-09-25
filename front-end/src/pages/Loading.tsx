import Icon from '@assets/Icon';

import styled from 'styled-components';

const Loading = () => {
  return (
    <MyLoadingPage>
      <MyLoading>
        <Icon name={'carrot'} size={'md'} className="dot1" />
        <Icon name={'carrot'} size={'md'} className="dot2" />
        <Icon name={'carrot'} size={'md'} className="dot3" />
        <Icon name={'carrot'} size={'md'} className="dot4" />
      </MyLoading>
    </MyLoadingPage>
  );
};

const MyLoadingPage = styled.div`
  width: 100%;
  height: 100vh;
`;

const MyLoading = styled.div`
  width: 50%;
  height: 50%;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  > svg {
    display: block;
  }

  .dot1 {
    -webkit-animation: jump 0.5s cubic-bezier(0.77, 0.47, 0.64, 0.28) alternate
      infinite;
    animation: jump 0.5s cubic-bezier(0.77, 0.47, 0.64, 0.28) alternate infinite;
  }

  .dot2 {
    -webkit-animation: jump 0.5s 0.2s cubic-bezier(0.77, 0.47, 0.64, 0.28)
      alternate infinite;
    animation: jump 0.5s 0.2s cubic-bezier(0.77, 0.47, 0.64, 0.28) alternate
      infinite;
  }

  .dot3 {
    -webkit-animation: jump 0.5s 0.4s cubic-bezier(0.77, 0.47, 0.64, 0.28)
      alternate infinite;
    animation: jump 0.5s 0.4s cubic-bezier(0.77, 0.47, 0.64, 0.28) alternate
      infinite;
  }

  .dot4 {
    -webkit-animation: jump 0.5s 0.6s cubic-bezier(0.77, 0.47, 0.64, 0.28)
      alternate infinite;
    animation: jump 0.5s 0.6s cubic-bezier(0.77, 0.47, 0.64, 0.28) alternate
      infinite;
  }

  @-webkit-keyframes jump {
    0% {
      -webkit-transform: translateY(0);
      transform: translateY(0);
    }
    100% {
      -webkit-transform: translateY(-15px);
      transform: translateY(-15px);
    }
  }

  @keyframes jump {
    0% {
      -webkit-transform: translateY(0);
      transform: translateY(0);
    }
    100% {
      -webkit-transform: translateY(-15px);
      transform: translateY(-15px);
    }
  }
`;

export default Loading;
