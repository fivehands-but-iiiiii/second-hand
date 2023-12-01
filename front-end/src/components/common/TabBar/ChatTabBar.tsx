import { ChangeEvent } from 'react';

import Icon from '@assets/Icon';
import Button from '@common/Button';
import TabBar from '@common/TabBar';
import Textarea from '@common/Textarea';

import { styled } from 'styled-components';

interface ChatTabBarProps {
  chatInput: string;
  onInputChange: (event: ChangeEvent<HTMLTextAreaElement>) => void;
  onChatSubmit: (chat: string) => void;
}

const ChatTabBar = ({
  chatInput,
  onInputChange,
  onChatSubmit,
}: ChatTabBarProps) => {
  const handleChatSubmit = () => onChatSubmit(chatInput);

  return (
    <TabBar>
      <Textarea
        type="chat"
        rows={1}
        value={chatInput}
        autoFocus
        singleLine
        onChange={onInputChange}
      ></Textarea>
      <MyChatTabBarButton icon active circle="md" onClick={handleChatSubmit}>
        <Icon name="arrowUp" size="xs" fill="#fff" />
      </MyChatTabBarButton>
    </TabBar>
  );
};

const MyChatTabBarButton = styled(Button)`
  padding: 0;
  margin-left: 8px;
`;

export default ChatTabBar;
