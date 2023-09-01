import { useEffect, useState } from 'react';
import { createPortal } from 'react-dom';

import ChatRoom from '../ChatRoom/ChatRoom';

import ChatListItem from './ChatListItem';

interface ChatRoomListProps {
  chatItems: ChatListItem[];
}

interface SSEMessage {
  roomId: string;
  message: string;
  unread: number;
}

const ChatList = ({ chatItems }: ChatRoomListProps) => {
  // TODO: 비지니스 로직 분리
  const [selectedItemId, setSelectedItemId] = useState(0);
  const [sse, setSse] = useState<EventSource | null>(null);

  useEffect(() => {
    const sse = new EventSource('/api/chats/stream');
    sse.onmessage = ({ data }) => {
      const { roomId, message, unread } = JSON.parse(data) as SSEMessage;
      const chatItem = chatItems.find((chat) => chat.id === roomId);

      if (chatItem) {
        chatItem.lastMessage = message;
        chatItem.unreadCount = unread;
      }
    };

    // interface ChatListItem {
    //   id: string;
    //   userImage: string;
    //   userName: string;
    //   lastMessageTime: string;
    //   lastMessage: string;
    //   unreadCount: number;
    //   itemInfo: Pick<SaleItem, 'id' | 'title' | 'thumbnailUrl'>;
    // }
    setSse(sse);

    return () => {
      sse.close();
    };
  }, []);

  const handleChatRoomClick = (itemId: number) => {
    setSelectedItemId(itemId);
  };

  const handleChatRoom = () => setSelectedItemId(0);

  return (
    <>
      {chatItems.map((chat) => (
        <ChatListItem
          key={chat.id}
          chatItem={chat}
          onClick={() => handleChatRoomClick(chat.itemInfo.id)}
        />
      ))}
      {!!selectedItemId &&
        createPortal(
          <ChatRoom itemId={selectedItemId} onRoomClose={handleChatRoom} />,
          document.body,
        )}
    </>
  );
};

export default ChatList;
