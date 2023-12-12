import { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';

import NavBar from '@common/NavBar';
import ChatList from '@components/chat/ChatList';
import { ChatListItemInfo } from '@components/chat/ChatList/ChatListItem';
import ChatRoom from '@components/chat/ChatRoom';
import BlankPage from '@pages/BlankPage';
import { getCurrentISODate, parseJSONSafely } from '@utils/formatText';

import { getChatList } from '../api/chat';

import { TITLE } from './constants';

interface EventData {
  roomId: string;
  message: string;
  unread: number;
}

interface EventMessage {
  data: EventData | string;
  id?: string;
  event?: string;
}

const isEventData = (data: unknown): data is EventData => {
  if (typeof data !== 'object' || data === null) return false;
  return 'roomId' in data && 'message' in data && 'unread' in data;
};

const ChatPage = () => {
  const title = TITLE.CHATS;
  const token = sessionStorage.getItem('token');
  const { itemId } = useParams();
  const [page, setPage] = useState(0);
  const [chatList, setChatList] = useState<ChatListItemInfo[]>([]);
  const [messages, setMessages] = useState<EventMessage[]>([]);
  const [selectedChatRoomId, setSelectedChatRoomId] = useState('');
  const [freshCount, setFreshCount] = useState(0);
  const isChatListExist = !!chatList.length;

  const fetchChatList = async () => {
    const data = await getChatList(page, itemId);
    setPage(data.page);
    setChatList(data.chatRooms);
  };

  const handleChatRoomClick = (chatId: string) => setSelectedChatRoomId(chatId);

  const handleChatRoom = () => {
    setSelectedChatRoomId('');
    setFreshCount((prev) => prev + 1);
  };

  const parseSSEMessage = (rawMessage: string): EventMessage[] => {
    return rawMessage
      .trim()
      .split('\n\n')
      .map((chunk) => {
        return chunk.split('\n').reduce((result, line) => {
          const [key, ...values] = line.split(':');
          const value = values.join(':').trim();
          return {
            ...result,
            [key]: key === 'data' ? parseJSONSafely(value) : value,
          };
        }, {}) as EventMessage;
      });
  };

  useEffect(() => {
    token && fetchChatList();
  }, [freshCount]);

  useEffect(() => {
    if (!token) return;

    const baseURL = import.meta.env.VITE_APP_BASE_URL;
    const xhr = new XMLHttpRequest();
    xhr.open('GET', `${baseURL}/chats/subscribe`, true);
    xhr.setRequestHeader('Authorization', token.replace(/["']/g, ''));

    xhr.onprogress = () => {
      const rawMessages = xhr.responseText.split('\n\n');
      rawMessages.forEach((rawMessage) => {
        try {
          const parsedMessages = parseSSEMessage(rawMessage);
          parsedMessages.forEach((message) => {
            // data 필드가 객체인 경우에만 messages 상태 업데이트
            if (typeof message.data === 'object' && message.data !== null) {
              setMessages((prevMessages) => [...prevMessages, message]);
            }
          });
        } catch (error) {
          console.error('Failed to parse SSE message:', error);
        }
      });
    };

    xhr.onerror = () => {
      console.error('An error occurred during the transaction');
    };

    xhr.send();

    return () => {
      xhr.abort();
    };
  }, []);

  useEffect(() => {
    if (messages.length === 0) return;

    const { event, data } = messages[messages.length - 1];

    if (event === 'chatNotification' && isEventData(data)) {
      const { roomId, message: newMessage, unread } = data;

      setChatList((prevChatList) =>
        prevChatList.map((chatItem) => {
          if (chatItem.chatroomId === roomId) {
            const currentISODate = getCurrentISODate();
            return {
              ...chatItem,
              chatLogs: {
                ...chatItem.chatLogs,
                lastMessage: newMessage,
                unReadCount: unread,
                updateAt: currentISODate,
              },
              lastUpdate: currentISODate,
            };
          }
          return chatItem;
        }),
      );
    }
  }, [messages]);

  return (
    <>
      <NavBar center={title} />
      {isChatListExist ? (
        <ChatList chatListItems={chatList} onRoomClick={handleChatRoomClick} />
      ) : (
        <BlankPage title={title} />
      )}
      {!!selectedChatRoomId && (
        <ChatRoom
          chatId={{ roomId: selectedChatRoomId }}
          onRoomClose={handleChatRoom}
        />
      )}
    </>
  );
};

export default ChatPage;
