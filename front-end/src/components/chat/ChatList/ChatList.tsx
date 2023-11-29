import ChatListItem, { ChatListItemInfo } from './ChatListItem';

interface ChatListProps {
  chatListItems: ChatListItemInfo[];
  onRoomClick: (itemId: string) => void;
}

const ChatList = ({ chatListItems, onRoomClick }: ChatListProps) => {
  return (
    <>
      {chatListItems.map((chat) => (
        <ChatListItem
          key={chat.chatroomId}
          chatListItem={chat}
          onItemClick={onRoomClick}
        />
      ))}
    </>
  );
};

export default ChatList;
