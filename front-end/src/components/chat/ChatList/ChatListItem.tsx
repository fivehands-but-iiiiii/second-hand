import { ComponentPropsWithRef } from 'react';

import Button from '@common/Button';
import ImgBox from '@common/ImgBox';
import UserProfile from '@components/login/UserProfile';
import getElapsedTime from '@utils/getElapsedTime';

import { styled } from 'styled-components';

interface ChatListItem {
  chatroomId: string;
  chatLogs: ChatSummary;
  opponent: ChatOpponent;
  item: SalesItemSummary;
}

interface ChatSummary {
  lastMessage: string;
  updateAt: string;
  unReadCount: number;
}

interface ChatOpponent {
  memberId: string;
  profileImgUrl: string;
}

interface SalesItemSummary {
  itemId: number;
  title: string;
  thumbnailImgUrl: string;
}

interface ChatListProps extends ComponentPropsWithRef<'button'> {
  chatListItem: ChatListItem;
  onItemClick: (itemId: string) => void;
}

const ChatListItem = ({ chatListItem, onItemClick }: ChatListProps) => {
  const { chatroomId: id, chatLogs, opponent, item } = chatListItem;
  const lastMassageDate =
    chatLogs.updateAt && getElapsedTime(chatLogs.updateAt);
  const hasUnreadMessage = chatLogs.unReadCount > 0;

  return (
    <MyChatListItem onClick={() => onItemClick(id)}>
      <UserProfile size="s" profileImgUrl={opponent.profileImgUrl} />
      <MyChatInfo>
        <MyChatUserName>
          {/* TODO: Semantic Tag로 수정 */}
          <div>{opponent.memberId}</div>
          <div>{lastMassageDate}</div>
        </MyChatUserName>
        <MyChatLastMessage>{chatLogs.lastMessage}</MyChatLastMessage>
      </MyChatInfo>
      <MyChatItem>
        {hasUnreadMessage && (
          <Button active circle="sm">
            {chatLogs.unReadCount}
          </Button>
        )}
        <ImgBox src={item.thumbnailImgUrl} alt={item.title} size="sm" />
      </MyChatItem>
    </MyChatListItem>
  );
};

const MyChatListItem = styled.button`
  width: 100%;
  display: flex;
  align-items: center;
  padding: 16px;
  gap: 8px;
  border-bottom: 1px solid ${({ theme }) => theme.colors.neutral.border};
  > div {
    display: flex;
  }
`;

const MyChatInfo = styled.div`
  min-width: 180px;
  flex-direction: column;
  flex-grow: 1;
  align-items: flex-start;
  gap: 4px;
`;

const MyChatUserName = styled.div`
  display: flex;
  gap: 4px;
  color: ${({ theme }) => theme.colors.neutral.textStrong};
  ${({ theme }) => theme.fonts.subhead};
  > div:nth-child(2) {
    color: ${({ theme }) => theme.colors.neutral.textWeak};
    ${({ theme }) => theme.fonts.footnote};
  }
`;

const MyChatLastMessage = styled.div`
  width: 100%;
  color: ${({ theme }) => theme.colors.neutral.text};
  ${({ theme }) => theme.fonts.footnote};
  text-align: start;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
`;

const MyChatItem = styled.div`
  display: flex;
  gap: 8px;
`;

export default ChatListItem;
