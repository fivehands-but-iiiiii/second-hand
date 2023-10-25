import { useNavigate } from 'react-router-dom';

import Button from '@common/Button';

import styled from 'styled-components';

const NotFound = () => {
  const navigate = useNavigate();

  return (
    <MyNotFoundPage>
      <div>
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

export default NotFound;
