import { ChangeEvent, memo, useCallback, useState } from 'react';

import ChatTabBar from '@common/TabBar/ChatTabBar';

interface ChatInputProps {
  onChatSubmit: (chat: string) => void;
}

const ChatInput = memo(({ onChatSubmit }: ChatInputProps) => {
  const [chat, setChat] = useState('');

  const handleChange = useCallback(
    ({ target }: ChangeEvent<HTMLTextAreaElement>) => {
      setChat(target.value);
    },
    [],
  );

  const handleSubmit = useCallback(() => {
    onChatSubmit(chat);
    setChat('');
  }, [chat, onChatSubmit]);

  return (
    <ChatTabBar
      chatInput={chat}
      onInputChange={handleChange}
      onChatSubmit={handleSubmit}
    />
  );
});

export default ChatInput;
