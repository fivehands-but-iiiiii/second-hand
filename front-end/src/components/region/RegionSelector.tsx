import { MouseEvent } from 'react';

import Icon from '@assets/Icon';
import Button from '@common/Button/Button';
import { RegionInfo } from '@components/login/Join';
import palette from '@styles/colors';

import { styled } from 'styled-components';

interface RegionSelectorProps {
  selectedRegions: RegionInfo[];
  onClickRegionButton: (id: number) => void;
  onClickDeleteButton: (id: number) => void;
  onClickAddButton: () => void;
}

const RegionSelector = ({
  selectedRegions,
  onClickRegionButton,
  onClickDeleteButton,
  onClickAddButton,
}: RegionSelectorProps) => {
  const handleRegionClick = (id: number) => onClickRegionButton(id);

  const handleRemoveClick = (id: number, event: MouseEvent) => {
    event.stopPropagation();
    onClickDeleteButton(id);
  };

  const regionButtons = selectedRegions.map(({ id, district, onFocus }) => (
    <Button
      key={id}
      fullWidth
      active={onFocus}
      onClick={() => handleRegionClick(id)}
    >
      {district}
      <MyRemoveIcon
        name={'x'}
        size={'xs'}
        fill={palette.neutral.background}
        onClick={(event) => handleRemoveClick(id, event)}
      />
    </Button>
  ));

  const addButton = (
    <Button fullWidth onClick={onClickAddButton}>
      <Icon name={'plus'} size={'xs'} />
      위치추가
    </Button>
  );

  const canAddMoreRegions = selectedRegions.length < 2;

  const regionMessage = canAddMoreRegions
    ? '최소 1개 이상 최대 2개까지 선택 가능해요'
    : '';

  return (
    <>
      <MyRegionButton>
        {regionButtons}
        {canAddMoreRegions && addButton}
      </MyRegionButton>
      <MyRegionMessage>{regionMessage}</MyRegionMessage>
    </>
  );
};

const MyRegionButton = styled.div`
  display: flex;
  gap: 7px;
`;

const MyRemoveIcon = styled(Icon)`
  margin-left: 10px;
  &:hover {
    stroke-width: 2;
    stroke: ${({ theme }) => theme.colors.neutral.background};
  }
`;

const MyRegionMessage = styled.p`
  color: ${({ theme }) => theme.colors.neutral.textWeak};
  ${({ theme }) => theme.fonts.caption2};
  text-align: end;
`;

export default RegionSelector;
