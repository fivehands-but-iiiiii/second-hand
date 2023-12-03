package com.team5.secondhand.chat.bubble.service;

import com.team5.secondhand.chat.bubble.domain.ChatBubble;
import com.team5.secondhand.chat.bubble.repository.ChatBubbleRepository;
import com.team5.secondhand.global.event.chatbubble.ChatBubbleArrivedEvent;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.event.EventListener;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;
import org.springframework.data.domain.SliceImpl;
import org.springframework.data.domain.Sort;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ChatBubbleService {
    @Value("${const.chat.bucket}")
    private String chatBucketPrefix;
    @Value("${const.chat.page-size}")
    private int chatLoadSize;
    private final ChatBubbleRepository chatBubbleRepository;
    private final RedisTemplate<String, ChatBubble> redisChatBubbleTemplate;

    @Transactional(readOnly = true)
    public Slice<ChatBubble> getChatBubbles(int page, String roomId) {
        String key = generateChatLogKey(roomId);
        Pageable pageable = PageRequest.of(page, chatLoadSize);
        Slice<ChatBubble> list = chatBubbleRepository.findAllByRoomIdOrderByCreatedAtDesc(roomId, pageable);
        List<ChatBubble> content = list.getContent();
        content.sort(Comparator.comparing(ChatBubble::getCreatedAt));

        return new SliceImpl<>(content, pageable, list.hasNext());
    }


    @Transactional
    public void saveChatBubble(ChatBubble chatBubble) {
        String key = generateChatLogKey(chatBubble.getRoomId());
        chatBubbleRepository.save(chatBubble);
    }

    @Async
    @EventListener
    public void getChatBubble(ChatBubbleArrivedEvent chatBubbleArrivedEvent) {
        ChatBubble chatBubble = chatBubbleArrivedEvent.getChatBubble();
        saveChatBubble(chatBubble);
    }

    private String generateChatLogKey (String roomId) {
        return String.format("%s%s:logs", chatBucketPrefix, roomId);
    }
}
