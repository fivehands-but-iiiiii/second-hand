import { useState, useEffect, useRef } from 'react';

import Alert from '@common/Alert';
import {
  ALERT_ACTIONS,
  ALERT_TITLE,
  AlertActionsProps,
} from '@common/Alert/constants';
import { SaleItem } from '@common/Item';
import NavBar from '@common/NavBar';
import { SALESHISTORY_VIEWMORE_MENU } from '@common/PopupSheet/constants';
import PopupSheet from '@common/PopupSheet/PopupSheet';
import SegmentedControl from '@common/SegmentedControl';
import Spinner from '@common/Spinner/Spinner';
import ItemList from '@components/home/ItemList';
import { ItemStatus } from '@components/ItemStatus';
import { getOutletContext } from '@components/layout';
import New from '@components/new/New';
import useAPI from '@hooks/useAPI';
import useIntersectionObserver from '@hooks/useIntersectionObserver';
import ItemDetail from '@pages/ItemDetail';
import { getStoredValue } from '@utils/sessionStorage';

import { styled } from 'styled-components';

import api from '../api';

import BlankPage from './BlankPage';
import { HomePageInfo } from './Home';

const SALES_STATUS = [
  {
    status: ItemStatus.ON_SALE,
    label: '판매중',
  },
  {
    status: ItemStatus.SOLD_OUT,
    label: '판매완료',
  },
];

interface SalesHistoryPage {
  number: number;
  hasPrevious: boolean;
  hasNext: boolean;
  items: SaleItem[];
}

const SalesHistory = () => {
  const { categories } = getOutletContext();
  const [saleItems, setSaleItems] = useState<SaleItem[]>([]);
  const [selectedItemId, setSelectedItemId] = useState(0);
  const [selectedStatusIndex, setSelectedStatusIndex] = useState(
    ItemStatus.ON_SALE,
  );
  const itemInfoRef = useRef(undefined);
  const [isDetailModalOpen, setIsDetailModalOpen] = useState(false);
  const [isViewMorePopupOpen, setIsViewMorePopupOpen] = useState(false);
  const [isNewModalOpen, setIsNewModalOpen] = useState(false);
  const [isDeleteAlertOpen, setIsDeleteAlertOpen] = useState(false);
  const [onRefresh, setOnRefresh] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [pageInfo, setPageInfo] = useState<HomePageInfo>({
    page: 0,
    hasPrevious: false,
    hasNext: true,
  });
  const { request } = useAPI();
  const isLogin = !!getStoredValue({ key: 'userInfo' });

  const onIntersect: IntersectionObserverCallback = ([{ isIntersecting }]) => {
    if (isIntersecting && !isLoading) getSalesHistory();
  };

  const { setTarget } = useIntersectionObserver({ onIntersect });

  const getSalesHistory = async () => {
    if (!pageInfo.hasNext || !isLogin) return;

    const salesList = await fetchSalesHistory();
    updateSalesHistory(salesList);
  };

  const fetchSalesHistory = async () => {
    try {
      setIsLoading(true);
      const { data } = await request({
        url: `items/mine?page=${pageInfo.page}&isSales=${!selectedStatusIndex}`,
      });
      return data;
    } catch (error) {
      console.error(error);
    } finally {
      setIsLoading(false);
    }
  };

  const updateSalesHistory = async (salesList: SalesHistoryPage) => {
    setSaleItems((pre) => [...pre, ...salesList.items]);
    setPageInfo({
      page: salesList.number + 1,
      hasPrevious: salesList.hasPrevious,
      hasNext: salesList.hasNext,
    });
  };

  const initData = () => {
    setPageInfo({
      page: 0,
      hasPrevious: false,
      hasNext: true,
    });
    setSaleItems([]);
  };

  const handleSelectedStatusIndex = (index: number) => {
    if (index === selectedStatusIndex) return;
    setSelectedStatusIndex(index);
    initData();
    setOnRefresh(true);
  };

  const handleItemDetail = (id: number) => {
    setSelectedItemId(id);
    setIsDetailModalOpen((pre) => !pre);
    if (!id) {
      initData();
      setOnRefresh(true);
    }
  };

  const handleViewMoreButton = (id: number) => {
    setSelectedItemId(id);
    setIsViewMorePopupOpen(true);
  };

  const viewMorePopupSheetMenu = SALESHISTORY_VIEWMORE_MENU.filter(
    (menu) => menu.id !== SALES_STATUS[selectedStatusIndex].status,
  ).map((menu) => ({
    ...menu,
    onClick: () => {
      getViewMorePopupSheet(menu.id);
      setIsViewMorePopupOpen(false);
    },
  }));

  const handleViewMorePopup = () => setIsViewMorePopupOpen((pre) => !pre);

  const handleNewModal = () => {
    setIsNewModalOpen((pre) => !pre);
    if (isNewModalOpen) setOnRefresh(true);
  };

  const getViewMorePopupSheet = async (typeId: string | number) => {
    const handleEdit = async () => {
      const itemInfo = await getItemInfo(selectedItemId);
      itemInfoRef.current = { ...itemInfo };
      if (itemInfo) setIsNewModalOpen(true);
    };
    const handleStatusSwitch = async (typeId: number) => {
      const response = await switchStatus(typeId);
      if (response) {
        initData();
        setOnRefresh(true);
      }
    };
    switch (typeId) {
      case 'edit':
        await handleEdit();
        break;
      case 'delete':
        setIsDeleteAlertOpen(true);
        break;
      case ItemStatus.ON_SALE:
      case ItemStatus.SOLD_OUT:
        await handleStatusSwitch(typeId);
        break;
      default:
        return;
    }
  };

  const getItemInfo = async (id: number) => {
    try {
      const { data } = await api.get(`/items/${id}`);
      return data.data;
    } catch (error) {
      console.error(`Failed to request: ${error}`);
    }
  };

  const switchStatus = async (status: ItemStatus) => {
    try {
      const { data } = await api.patch(`/items/${selectedItemId}/status`, {
        status: status,
      });
      return data;
    } catch (error) {
      console.error(`Failed to request: ${error}`);
    }
  };

  const alertButtons = (actions: AlertActionsProps[]) =>
    actions.map(({ id, action }) => (
      <button key={id} onClick={() => handleAlert(id)}>
        {action}
      </button>
    ));

  const handleAlert = (type: AlertActionsProps['id']) => {
    if (type !== 'delete' && type !== 'cancel') return;

    const actions = {
      delete: () => deleteAlertConfirm(type),
      cancel: () => setIsDeleteAlertOpen(false),
    };
    return actions[type]();
  };

  const deleteAlertConfirm = async (type: AlertActionsProps['id']) => {
    if (type !== 'delete') return;
    const response = await deleteItem(selectedItemId);
    if (response) {
      setIsDeleteAlertOpen(false);
      initData();
      setOnRefresh(true);
    }
  };

  const deleteItem = async (id: number) => {
    try {
      const { data } = await api.delete(`/items/${id}`);
      return { data };
    } catch (error) {
      console.error(`Failed to request: ${error}`);
    }
  };

  useEffect(() => {
    if (!onRefresh) return;
    getSalesHistory();
    setOnRefresh(false);
  }, [onRefresh]);

  useEffect(() => {
    if (!isLogin) return;
    let ignore = false;

    fetchSalesHistory().then((salesList) => {
      if (!ignore) updateSalesHistory(salesList);
    });

    return () => {
      ignore = true;
    };
  }, []);

  return (
    <>
      <NavBar center={'판매 내역'}>
        <SegmentedControl
          options={SALES_STATUS}
          value={selectedStatusIndex}
          onClick={handleSelectedStatusIndex}
        />
      </NavBar>
      {!!saleItems.length ? (
        <>
          <ItemList
            saleItems={saleItems}
            onItemClick={handleItemDetail}
            {...{
              onHistoryPage: 'true',
              onViewMoreButton: handleViewMoreButton,
            }}
          />
          <MyOnFetchItems ref={setTarget}></MyOnFetchItems>
          {isLoading && <Spinner />}
          {isDetailModalOpen && (
            <ItemDetail
              id={selectedItemId}
              categoryInfo={categories}
              handleBackBtnClick={handleItemDetail}
            />
          )}
          {isViewMorePopupOpen && (
            <PopupSheet
              menu={viewMorePopupSheetMenu}
              onClick={handleViewMorePopup}
            />
          )}
          {isNewModalOpen && (
            <New
              origin={itemInfoRef?.current}
              categoryInfo={categories}
              onClick={handleNewModal}
            />
          )}
          <Alert isOpen={isDeleteAlertOpen}>
            <Alert.Title>{ALERT_TITLE.DELETE('삭제')}</Alert.Title>
            <Alert.Button>{alertButtons(ALERT_ACTIONS.DELETE)}</Alert.Button>
          </Alert>
        </>
      ) : (
        <BlankPage title={`${SALES_STATUS[selectedStatusIndex].label} 내역`} />
      )}
    </>
  );
};

const MyOnFetchItems = styled.div`
  margin-bottom: 75px;
`;

export default SalesHistory;
