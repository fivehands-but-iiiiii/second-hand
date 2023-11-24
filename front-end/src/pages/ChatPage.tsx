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
  data: EventData;
  id?: string;
  event?: string;
}

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

    let lastEventId: string | null | undefined = null;

    // xhr.onprogress = () => {
    //   console.log(xhr.responseText);
    //   const rawMessages = xhr.responseText.split('\n\n');
    //   for (const rawMessage of rawMessages) {
    //     const message = parseSSEMessage(rawMessage);
    //     // message.data.roomId
    //     if (message.id !== lastEventId) {
    //       setMessages((prevMessages) => [...prevMessages, message]);
    //       lastEventId = message.id;
    //     }
    //   }
    // };

    xhr.onprogress = () => {
      const rawMessages = xhr.responseText.split('\n\n');
      console.log(rawMessages);
      // ['id:ahnlook\nevent:chatNotification\ndata:connected successfully member key : ahnlook', '']
      for (const rawMessage of rawMessages) {
        console.log(rawMessage);
        try {
          const message = parseSSEMessage(rawMessage);

          if (message.id !== lastEventId) {
            setMessages((prevMessages) => [...prevMessages, message]);
            lastEventId = message.id;
          }
        } catch (error) {
          console.error('Failed to parse SSE message:', error);
        }
      }
    };

    xhr.onerror = () => {
      console.error('An error occurred during the transaction');
    };

    xhr.send();

    return () => {
      xhr.abort();
    };
  }, []);

  const parseSSEMessage = (data: string): EventMessage => {
    const result: Partial<EventMessage> = {};
    const lines = data.split('\n');

    lines.forEach((line) => {
      if (line.startsWith('data: ')) {
        result.data = JSON.parse(line.replace('data: ', ''));
      } else if (line.startsWith('id: ')) {
        result.id = line.replace('id: ', '');
      } else if (line.startsWith('event: ')) {
        result.event = line.replace('event: ', '');
      }
    });

    if (!result.id || !result.event || !result.data) {
      throw new Error('SSE message is missing required fields');
    }

    return result as EventMessage;
  };

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
