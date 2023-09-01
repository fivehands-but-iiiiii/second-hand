import { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';

import NavBar from '@common/NavBar';
import ChatList from '@components/chat/ChatList';
import ChatRoom from '@components/chat/ChatRoom';
import PortalLayout from '@components/layout/PortalLayout';
import BlankPage from '@pages/BlankPage';

import api from '../api';

const ChatPage = () => {
  const { itemId } = useParams();
  const title = '채팅';

  // 1
  const [page, setPage] = useState(0);
  const [chatList, setChatList] = useState([]);
  const isChatListExist = !!chatList.length;

  const buildChatListApiUrl = (page: number, itemId?: string) => {
    return `/chats?page=${page}${itemId ? `&itemId=${itemId}` : ''}`;
  };

  const getChatList = async () => {
    const apiUrl = buildChatListApiUrl(page, itemId);

    try {
      const { data: chatList } = await api.get(apiUrl);
      setPage(chatList.page);
      setChatList(chatList);
    } catch (error) {
      console.error(error);
    }
  };

  useEffect(() => {
    getChatList();
  }, []);

  // 2
  const [selectedItemId, setSelectedItemId] = useState(0);

  const handleChatRoomClick = (itemId: number) => {
    setSelectedItemId(itemId);
  };

  const handleChatRoom = () => setSelectedItemId(0);

  if (!isChatListExist) return <BlankPage title={title} />;
  return (
    <>
      <NavBar center={title} />
      <ChatList chatItems={chatList} onRoomClick={handleChatRoomClick} />
      {!!selectedItemId && (
        <PortalLayout>
          <ChatRoom itemId={selectedItemId} onRoomClose={handleChatRoom} />
        </PortalLayout>
      )}
    </>
  );
};

export default ChatPage;
