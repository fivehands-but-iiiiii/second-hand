import { useCallback, useEffect, useRef, useState } from 'react';

import Icon from '@assets/Icon';
import ImgBox from '@common/ImgBox';
import NavBar from '@common/NavBar';
import PopupSheet from '@common/PopupSheet';
import { CHAT_VIEWMORE_MENU } from '@common/PopupSheet/constants';
import PortalLayout from '@components/layout/PortalLayout';
import usePopupSheet from '@hooks/usePopupSheet';
import * as StompJs from '@stomp/stompjs';
import { getFormattedPrice } from '@utils/formatPrice';
import { getStoredValue } from '@utils/sessionStorage';

import { styled } from 'styled-components';

import {
  createRoomId,
  getChatData,
  getChatBubbles,
  deleteChatRoom,
} from '../../../api/chat';

import ChatBubbles from './ChatBubbles';
import ChatInput from './ChatInput';

export interface ChatBubble {
  roomId: string;
  sender: string;
  receiver: string;
  message: string;
  isMine?: boolean;
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
  const [page] = useState(0);
  const [opponentId, setOpponentId] = useState('');
  const [chatBubbles, setChatBubbles] = useState<ChatBubble[]>([]);
  const [chat, setChat] = useState('');

  const endRef = useRef<HTMLDivElement | null>(null);
  const client = useRef<StompJs.Client | null>(null);

  const setItemAndOpponentInfo = (
    item: SalesItemSummary,
    opponentId: string,
  ) => {
    setItemInfo(item);
    setOpponentId(opponentId);
  };

  const fetchChatData = async () => {
    const { roomId, itemId } = chatId;
    const chatData = await getChatData(roomId, itemId);

    if (chatData) {
      const { item, chatroomId, opponentId } = chatData;

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
        const bubbles = await getChatBubbles(chatroomId, page);
        setChatBubbles(bubbles);
      }
    }
  };

  useEffect(() => {
    const { roomId, itemId } = chatId;
    if (roomId || itemId) {
      fetchChatData();
    }
  }, []);

  const connect = () => {
    const token = getStoredValue({ key: 'token' }).replace(/['"]+/g, '');
    const baseUrl = import.meta.env.VITE_APP_WS_URL;

    client.current = new StompJs.Client({
      brokerURL: `${baseUrl}/chat`,
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

  const handleSubmit = useCallback(
    async (chat: string) => {
      if (!roomId && chatId.itemId) {
        const newRoomId = await createRoomId(chatId.itemId);
        setRoomId(newRoomId);
      }
      publish(chat);
    },
    [roomId, chatId, publish],
  );

  const popupSheetActions: { [key: string]: () => void } = {
    quitChat: () => deleteChatRoom(roomId),
  };

  const { isPopupOpen, handleAction, togglePopup } =
    usePopupSheet(popupSheetActions);

  const viewMorePopupSheetMenu = CHAT_VIEWMORE_MENU.map((menu) => ({
    ...menu,
    onClick: () => handleAction(menu.id),
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
      <MyChatRoom>
        <NavBar
          left={
            <MyNavBarBtn onClick={onRoomClose}>
              <Icon name={'chevronLeft'} />
              <span>뒤로</span>
            </MyNavBarBtn>
          }
          center={opponentId}
          right={
            <button onClick={togglePopup}>
              <Icon name={'ellipsis'} />
            </button>
          }
        />
        <MyChatRoomItem>
          <ImgBox
            src={itemInfo.thumbnailUrl}
            alt={itemInfo.title}
            size={'sm'}
          />
          <MyChatRoomItemInfo>
            <span>{itemInfo.title}</span>
            <span>{itemInfo.price}</span>
          </MyChatRoomItemInfo>
        </MyChatRoomItem>
        {!!chatBubbles.length && (
          <>
            <div ref={endRef} />
            <ChatBubbles bubbles={chatBubbles} />
          </>
        )}
        {isPopupOpen && (
          <PopupSheet menu={viewMorePopupSheetMenu} onClick={togglePopup} />
        )}
        <ChatInput onChatSubmit={handleSubmit} />
      </MyChatRoom>
    </PortalLayout>
  );
};

const MyChatRoom = styled.div`
  display: flex;
  flex-direction: column;
  height: 100%;
`;

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
