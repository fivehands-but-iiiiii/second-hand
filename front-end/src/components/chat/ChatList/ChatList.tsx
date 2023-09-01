// import { useEffect, useState } from 'react';

import ChatListItem from './ChatListItem';

interface ChatListProps {
  chatItems: ChatListItem[];
  onRoomClick: (itemId: number) => void;
}

const ChatList = ({ chatItems, onRoomClick }: ChatListProps) => {
  return (
    <>
      {chatItems.map((chat) => (
        <ChatListItem
          key={chat.id}
          chatItem={chat}
          onClick={() => onRoomClick(chat.itemInfo.id)}
        />
      ))}
    </>
  );
};

export default ChatList;
