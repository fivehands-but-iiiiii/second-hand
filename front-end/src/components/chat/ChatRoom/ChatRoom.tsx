import { SetStateAction, useEffect, useRef, useState } from 'react';

import Icon from '@assets/Icon';
import ImgBox from '@common/ImgBox';
import NavBar from '@common/NavBar';
import PopupSheet from '@common/PopupSheet';
import { CHAT_VIEWMORE_MENU } from '@common/PopupSheet/constants';
import ChatTabBar from '@common/TabBar/ChatTabBar';
import PortalLayout from '@components/layout/PortalLayout';
import * as StompJs from '@stomp/stompjs';
import { getFormattedPrice } from '@utils/formatPrice';
import { getStoredValue } from '@utils/sessionStorage';

import { styled } from 'styled-components';

import api from '../../../api';

import ChatBubbles from './ChatBubbles';

export interface ChatBubble {
  roomId: string;
  sender: string;
  receiver: string;
  message: string;
  isMine: boolean;
}

interface SalesItemSummary {
  id: number;
  title: string;
  price: number;
  thumbnailUrl: string;
  status: number;
  isDelete: boolean;
}

interface ChatRoomProps {
  chatId: { roomId?: string; itemId?: number };
  onRoomClose: () => void;
}

const ChatRoom = ({ chatId, onRoomClose }: ChatRoomProps) => {
  const { memberId: userId } = getStoredValue({ key: 'userInfo' });

  const [itemInfo, setItemInfo] = useState<SalesItemSummary>(
    {} as SalesItemSummary,
  );
  const [roomId, setRoomId] = useState('');
  const [page, setPage] = useState(0);
  const [opponentId, setOpponentId] = useState('');
  const [chatBubbles, setChatBubbles] = useState<ChatBubble[]>([]);
  const [chat, setChat] = useState('');
  const [isMoreViewPopupOpen, setIsMoreViewPopupOpen] = useState(false);

  const endRef = useRef<HTMLDivElement | null>(null);
  const client = useRef<StompJs.Client | null>(null);

  const setItemAndOpponentInfo = (
    item: SalesItemSummary,
    opponentId: string,
  ) => {
    setItemInfo(item);
    setOpponentId(opponentId);
  };

  const getChatData = async (roomId?: string, itemId?: number) => {
    try {
      let endpoint;
      if (roomId) {
        endpoint = `chats/${roomId}`;
      } else if (itemId !== undefined) {
        endpoint = `chats/items/${itemId}`;
      } else {
        return;
      }

      const { data } = await api.get(endpoint);
      const { item, chatroomId, opponentId } = data.data;

      setItemAndOpponentInfo(
        {
          ...item,
          id: item.itemId,
          price: getFormattedPrice(item.price),
          status: parseInt(item.status),
          thumbnailUrl: item.thumbnailImgUrl,
        },
        opponentId,
      );

      if (chatroomId) {
        setRoomId(chatroomId);
        getChatBubbles(chatroomId, page);
      }
    } catch (error) {
      console.error(error);
    }
  };

  useEffect(() => {
    const { roomId, itemId } = chatId;
    getChatData(roomId, itemId);
  }, [chatId]);

  const createRoomId = async () => {
    try {
      const { itemId } = chatId;
      const { data } = await api.post('/chats', {
        itemId,
      });
      return data.data;
    } catch (error) {
      console.error(error);
    }
  };

  const getChatBubbles = async (roomId: number, page: number) => {
    const { data } = await api.get(`chats/${roomId}/logs?page=${page}`);
    console.log(data.data.chatBubbles);
    setChatBubbles(data.data.chatBubbles);
  };

  const connect = () => {
    const token = getStoredValue({ key: 'token' }).replace(/['"]+/g, '');

    client.current = new StompJs.Client({
      brokerURL: 'ws://43.202.132.236/api/chat',
      connectHeaders: {
        Authorization: token,
      },
      onConnect: () => {
        subscribe();
        chat && publish(chat);
      },
    });

    client.current.activate();
  };

  const handleMessage = (messageBody: { body: string }) => {
    const parsedMessage = JSON.parse(messageBody.body);
    setChatBubbles((prevChatList) => [...prevChatList, parsedMessage]);
  };

  const subscribe = () => {
    client.current?.subscribe(`/sub/${roomId}`, handleMessage);
  };

  const publish = (chat: string) => {
    if (!client.current?.connected) return;

    client.current.publish({
      destination: '/pub/message',
      body: JSON.stringify({
        roomId,
        sender: userId,
        receiver: opponentId,
        message: chat,
      }),
    });

    setChat('');
  };

  const disconnect = () => {
    client.current?.deactivate();
  };

  const handleChange = (event: {
    target: { value: SetStateAction<string> };
  }) => {
    setChat(event.target.value);
  };

  const handleSubmit = async (chat: string) => {
    if (!roomId) {
      const newRoomId = await createRoomId();
      setRoomId(newRoomId);
    }

    publish(chat);
  };

  const handleViewMorePopup = () => {
    setIsMoreViewPopupOpen(!isMoreViewPopupOpen);
  };

  const viewMorePopupSheetMenu = CHAT_VIEWMORE_MENU.map((menu) => ({
    ...menu,
    onClick: () => {
      // TODO: popup sheet 메뉴 클릭 시 동작
      console.log('');
      setIsMoreViewPopupOpen(false);
    },
  }));

  useEffect(() => {
    chatId.roomId && setRoomId(chatId.roomId);
    connect();

    return () => disconnect();
  }, [roomId]);

  useEffect(() => {
    endRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [chatBubbles]);

  return (
    <PortalLayout>
      <NavBar
        left={
          <MyNavBarBtn onClick={onRoomClose}>
            <Icon name={'chevronLeft'} />
            <span>뒤로</span>
          </MyNavBarBtn>
        }
        center={opponentId}
        right={
          <button onClick={handleViewMorePopup}>
            <Icon name={'ellipsis'} />
          </button>
        }
      />
      <MyChatRoomItem>
        <ImgBox src={itemInfo.thumbnailUrl} alt={itemInfo.title} size={'sm'} />
        <MyChatRoomItemInfo>
          <span>{itemInfo.title}</span>
          <span>{itemInfo.price}</span>
        </MyChatRoomItemInfo>
      </MyChatRoomItem>
      {/* TODO: MyChatBubbles component 분리 */}
      {!!chatBubbles.length && <ChatBubbles bubbles={chatBubbles} />}
      {isMoreViewPopupOpen && (
        <PopupSheet
          menu={viewMorePopupSheetMenu}
          onClick={handleViewMorePopup}
        ></PopupSheet>
      )}
      <div ref={endRef}></div>
      <ChatTabBar
        chatInput={chat}
        onInputChange={handleChange}
        onChatSubmit={handleSubmit}
      />
    </PortalLayout>
  );
};

const MyNavBarBtn = styled.button`
  display: flex;
  gap: 5px;
`;

const MyChatRoomItem = styled.section`
  display: flex;
  align-items: center;
  padding: 16px;
  gap: 8px;
  border-bottom: 1px solid ${({ theme }) => theme.colors.neutral.border};
`;

const MyChatRoomItemInfo = styled.div`
  display: flex;
  flex-direction: column;
  gap: 4px;
  & > span {
    text-align: left;
    ${({ theme }) => theme.fonts.subhead};
    color: ${({ theme }) => theme.colors.neutral.textStrong};
  }
  & > span:nth-child(2) {
    font-weight: 510;
  }
`;

export default ChatRoom;
