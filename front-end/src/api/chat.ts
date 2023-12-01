import api from './index';

export const createRoomId = async (itemId: number) => {
  const { data } = await api.post('/chats', {
    itemId,
  });
  return data.data;
};

export const getChatData = async (roomId?: string, itemId?: number) => {
  const endpoint = roomId ? `chats/${roomId}` : `chats/items/${itemId}`;
  const { data } = await api.get(endpoint);
  return data.data;
};

export const getChatBubbles = async (roomId: number, page: number) => {
  const { data } = await api.get(`chats/${roomId}/logs?page=${page}`);
  return data.data.chatBubbles;
};

export const deleteChatRoom = async (chatId: string) => {
  const { data } = await api.delete(`chats/${chatId}`);
  return data;
};
