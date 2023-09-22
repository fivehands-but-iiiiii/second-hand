import { styled } from 'styled-components';

import { ChatBubble } from './ChatRoom';

interface ChatBubblesProps {
  bubbles: ChatBubble[];
}

const renderBubble = (bubble: ChatBubble) => {
  const BubbleComponent = bubble.isMine ? MyBubble : MyOpponentBubble;

  return (
    <BubbleComponent>
      <span>{bubble.message}</span>
    </BubbleComponent>
  );
};

const ChatBubbles = ({ bubbles }: ChatBubblesProps) => (
  <MyChatBubbles>
    {bubbles.map((bubble) =>
      bubble.isMine ? (
        <MyBubbleWrapper key={bubble.roomId}>
          {renderBubble(bubble)}
        </MyBubbleWrapper>
      ) : (
        renderBubble(bubble)
      ),
    )}
  </MyChatBubbles>
);

const MyChatBubbles = styled.section`
  display: flex;
  flex-direction: column;
  padding: 16px;
  margin-bottom: 75px;
`;

const MyChatBubble = styled.div`
  width: fit-content;
  max-width: 65%;
  display: flex;
  padding: 6px 12px;
  margin-bottom: 16px;
  border-radius: 18px;
  & > span {
    text-align: left;
    ${({ theme }) => theme.fonts.body};
    color: ${({ theme }) => theme.colors.neutral.textStrong};
  }
`;

const MyBubble = styled(MyChatBubble)`
  background-color: ${({ theme }) => theme.colors.accent.backgroundPrimary};
  & > span {
    color: ${({ theme }) => theme.colors.accent.text};
  }
`;

const MyBubbleWrapper = styled.div`
  display: flex;
  justify-content: flex-end;
`;

const MyOpponentBubble = styled(MyChatBubble)`
  background-color: ${({ theme }) => theme.colors.neutral.backgroundBold};
`;

export default ChatBubbles;
