import { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';

import NavBar from '@common/NavBar';
import ChatList from '@components/chat/ChatList';
import ChatRoom from '@components/chat/ChatRoom';
import BlankPage from '@pages/BlankPage';

import api from '../api';

const ChatPage = () => {
  const { itemId } = useParams();
  const title = '채팅';
  const [page, setPage] = useState(0);
  const [chatList, setChatList] = useState([]);
  const [selectedChatRoomId, setSelectedChatRoomId] = useState('');
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

  const handleChatRoom = () => setSelectedChatRoomId('');

  useEffect(() => {
    getChatList();
  }, []);

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

// data: {
//   page : {number},
//   hasPrevious: {boolean},
//   hasNext: {boolean},
//   chatRooms:[{
//     chatroomId: string
//     opponent: {
//       memberId: string,
//       profileImgUrl: string
//     },
//     item:{
//       itemId: number,
//       title: string,
//       thumbnailImgUrl: string,
//     },
//     chatLogs:{
//       lastMessage: string,
//       updatedAt: date
//       unReadCount: number
//     }
//   }]
// }
