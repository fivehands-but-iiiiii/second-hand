import { useNavigate } from 'react-router-dom';

import Icon from '@assets/Icon';
import Button from '@common/Button';

import { styled } from 'styled-components';

const NotFound = () => {
  const navigate = useNavigate();

  return (
    <MyNotFoundPage>
      <div>
        <MyIcon>
          <Icon name={'carrot'} size={'sm'} />
          <Icon name={'carrot'} size={'sm'} />
          <Icon name={'carrot'} size={'sm'} />
        </MyIcon>
        <h2>404 Not Found</h2>
        <p>페이지를 찾을 수 없습니다</p>
      </div>
      <Button onClick={() => navigate(-1)}>이전 페이지로 이동</Button>
    </MyNotFoundPage>
  );
};

const MyNotFoundPage = styled.div`
  width: 100%;
  height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
`;

const MyIcon = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;

  & > svg {
    margin: 0 0.5rem;
  }
`;

export default NotFound;
