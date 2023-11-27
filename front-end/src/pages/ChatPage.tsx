import { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';

import NavBar from '@common/NavBar';
import ChatList from '@components/chat/ChatList';
import { ChatListItemInfo } from '@components/chat/ChatList/ChatListItem';
import ChatRoom from '@components/chat/ChatRoom';
import BlankPage from '@pages/BlankPage';

import api from '../api';

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

const isEventData = (data: any): data is EventData => {
  return (
    data &&
    typeof data === 'object' &&
    'roomId' in data &&
    'message' in data &&
    'unread' in data
  );
};

const ChatPage = () => {
  const { itemId } = useParams();
  const title = TITLE.CHATS;
  const [page, setPage] = useState(0);
  const [chatList, setChatList] = useState<ChatListItemInfo[]>([]);
  const [selectedChatRoomId, setSelectedChatRoomId] = useState('');
  const [freshCount, setFreshCount] = useState(0);
  const isChatListExist = !!chatList.length;

  const buildChatListApiUrl = (page: number, itemId?: string) => {
    return `/chats?page=${page}${itemId ? `&itemId=${itemId}` : ''}`;
  };

  const getChatList = async () => {
    const apiUrl = buildChatListApiUrl(page, itemId);
    try {
      const {
        data: { data },
      } = await api.get(apiUrl);
      setPage(data.page);
      setChatList(data.chatRooms);
    } catch (error) {
      console.error(error);
    }
  };

  const handleChatRoomClick = (chatId: string) => setSelectedChatRoomId(chatId);

  const handleChatRoom = () => {
    setSelectedChatRoomId('');
    setFreshCount((prev) => prev + 1);
  };

  useEffect(() => {
    getChatList();
  }, [freshCount]);

  const [messages, setMessages] = useState<EventMessage[]>([]);

  useEffect(() => {
    const token = sessionStorage.getItem('token');
    if (!token) return;

    const xhr = new XMLHttpRequest();
    xhr.open('GET', 'http://43.202.132.236/api/chats/subscribe', true);
    xhr.setRequestHeader('Authorization', token.replace(/["']/g, ''));
    // xhr.setRequestHeader('Content-Type', 'text/event-stream');
    // xhr.setRequestHeader('Cache-Control', 'no-store');

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
    messages?.forEach((message) => {
      if (
        message.event === 'chatNotification' &&
        message.data &&
        typeof message.data === 'object'
      ) {
        const { roomId, message: newMessage, unread } = message.data;
        console.log(messages);

        setChatList((prevChatList) => {
          return prevChatList.map((chatItem) => {
            if (chatItem.chatroomId === roomId) {
              return {
                ...chatItem,
                chatLogs: {
                  ...chatItem.chatLogs,
                  lastMessage: newMessage,
                  unReadCount: unread,
                  updateAt: new Date().toISOString(),
                },
                lastUpdate: new Date().toISOString(),
              };
            }
            return chatItem;
          });
        });
      }
    });
  }, [messages]);

  const parseSSEMessage = (rawMessage: string): EventMessage[] => {
    const messages = rawMessage
      .trim()
      .split('\n\n')
      .map((chunk) => {
        const result: Partial<EventMessage> = {};
        const lines = chunk.split('\n');

        lines.forEach((line) => {
          const [key, ...values] = line.split(':');
          const value = values.join(':').trim();

          switch (key) {
            case 'id':
              result.id = value;
              break;
            case 'event':
              result.event = value;
              break;
            case 'data':
              try {
                result.data = JSON.parse(value);
              } catch (error) {
                result.data = value;
              }
              break;
            default:
              break;
          }
        });

        return result as EventMessage;
      });

    return messages;
  };

  useEffect(() => {
    const latestMessage = messages[messages.length - 1];
    // messages :
    // {
    //   "id": "12345",
    //   "event": "chatNotification",
    //   "data": {
    //     "roomId": "b2e55401-4005-11ee-869c-0242ac110002",
    //     "message": "새로운 메시지가 도착했습니다",
    //     "unread": 3
    //   }
    // }

    if (
      latestMessage &&
      latestMessage.event === 'chatNotification' &&
      isEventData(latestMessage.data)
    ) {
      const { roomId, message: newMessage, unread } = latestMessage.data;

      setChatList((prevChatList) =>
        prevChatList.map((chatItem) => {
          if (chatItem.chatroomId === roomId) {
            return {
              ...chatItem,
              chatLogs: {
                ...chatItem.chatLogs,
                lastMessage: newMessage,
                unReadCount: unread,
                updateAt: new Date().toISOString(),
              },
              lastUpdate: new Date().toISOString(),
            };
          }
          return chatItem;
        }),
      );
    }
  }, [messages]);

  if (!isChatListExist) return <BlankPage title={title} />;
  return (
    <>
      <NavBar center={title} />
      <ChatList chatListItems={chatList} onRoomClick={handleChatRoomClick} />
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
