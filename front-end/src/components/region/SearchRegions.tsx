import { useEffect, useState, ChangeEvent, useCallback } from 'react';

import Button from '@common/Button/Button';
import NavBar from '@common/NavBar/NavBar';
import Textarea from '@common/Textarea/Textarea';
import PortalLayout from '@components/layout/PortalLayout';
import useAPI from '@hooks/useAPI';
import useGeoLocation from '@hooks/useGeoLocation';
import { debounce } from '@utils/debounce';

import { styled } from 'styled-components';
export interface Region {
  id: number;
  city?: string;
  county?: string;
  district: string;
}

interface SearchRegionsProps {
  onPortal: () => void;
  onSelectRegion: (id: number, district: string) => void;
}

const DEBOUNCE_DELAY = 3000;

const SearchRegions = ({ onPortal, onSelectRegion }: SearchRegionsProps) => {
  const [searchKeyword, setSearchKeyword] = useState('');
  const [regionList, setRegionList] = useState<Region[]>([]);
  const { request } = useAPI();
  const { location: currentLocation } = useGeoLocation();

  const fetchRegionList = async (keyword: string) => {
    try {
      const { data } = await request({
        url: `/regions?keyword=${keyword}`,
      });
      return data;
    } catch (error) {
      console.error(error);
    }
  };

  const updateRegionList = async (region: Region[]) => {
    setRegionList(region);
  };

  const getRegionList = async (keyword: string) => {
    const regionList = await fetchRegionList(keyword);
    updateRegionList(regionList);
  };

  const getCurrentRegionList = async () => {
    if (!currentLocation.address) return;
    getRegionList(currentLocation.address);
  };

  const handleSearchChange = ({ target }: ChangeEvent<HTMLTextAreaElement>) => {
    const { value } = target;
    setSearchKeyword(value);

    if (searchKeyword.length >= 2) {
      delayedSearch(searchKeyword);
    }
  };

  const delayedSearch = useCallback(
    debounce((value) => {
      getRegionList(value);
    }, DEBOUNCE_DELAY),
    [],
  );

  useEffect(() => {
    let ignore = false;

    fetchRegionList('강남구').then((regionList) => {
      if (!ignore) updateRegionList(regionList);
    });

    return () => {
      ignore = true;
    };
  }, []);

  return (
    <PortalLayout>
      <NavBar left={<button onClick={onPortal}>닫기</button>}>
        <Textarea
          type={'icon'}
          icon={'search'}
          placeholder={'동명(읍, 면)으로 검색(ex. 역삼1동)'}
          single
          rows={1}
          value={searchKeyword}
          onChange={handleSearchChange}
        />
      </NavBar>
      <MySearchRegions>
        <Button active stretch onClick={getCurrentRegionList}>
          현재 위치로 찾기
        </Button>
      </MySearchRegions>
      <MyRegionList>
        {regionList.length > 0 ? (
          <ul>
            {regionList.map(({ id, city, county, district }: Region) => (
              <MyRegion key={id}>
                <button onClick={() => onSelectRegion(id, district)}>
                  {city} {county} {district}
                </button>
              </MyRegion>
            ))}
          </ul>
        ) : (
          <p>
            검색 결과가 없어요. <br />
            동네 이름을 다시 확인해주세요.
          </p>
        )}
      </MyRegionList>
    </PortalLayout>
  );
};

const MySearchRegions = styled.div`
  padding: 10px 15px;
`;

const MyRegionList = styled.div`
  height: calc(100vh - 194px);
  padding: 0 15px 10px;
  text-align: center;
  color: ${({ theme }) => theme.colors.neutral.textWeak};
  ul {
    height: 100%;
    ${({ theme }) => theme.fonts.subhead}
    overflow: auto;
    > li:not(:last-child) {
      border-bottom: 1px solid ${({ theme }) => theme.colors.neutral.border};
    }
  }
`;

const MyRegion = styled.li`
  display: flex;
  align-items: center;
  height: 5vh;
  min-height: 35px;
  min-width: 200px;
  padding-left: 5px;
  > button {
    height: 100%;
  }
`;

export default SearchRegions;
