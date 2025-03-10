package com.team5.secondhand.chat.chatroom.service;

import com.team5.secondhand.application.chatroom.dto.ChatroomInfo;
import com.team5.secondhand.application.chatroom.dto.response.ChatLog;
import com.team5.secondhand.application.chatroom.dto.response.ChatroomSummary;
import com.team5.secondhand.application.chatroom.exception.NotChatroomMemberException;
import com.team5.secondhand.chat.bubble.domain.ChatBubble;
import com.team5.secondhand.chat.chatroom.domain.Chatroom;
import com.team5.secondhand.chat.chatroom.repository.ChatroomMetaRepository;
import com.team5.secondhand.global.event.chatbubble.ChatBubbleArrivedEvent;
import com.team5.secondhand.global.event.chatbubble.ChatNotificationEvent;
import com.team5.secondhand.global.event.chatroom.ChatroomCreatedEvent;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class ChatroomCacheService {
    private final String MAIN_KEY = "chatroom";
    private final ChatroomMetaRepository metaInfoRepository;
    private final ApplicationEventPublisher eventPublisher;

    public void enterToChatRoom(String roomId, String memberId) throws NotChatroomMemberException {
        Chatroom chatroom = metaInfoRepository.findById(roomId).orElseThrow(() -> new NotChatroomMemberException("채팅방 멤버가 아닙니다."));
        chatroom.enter(memberId);
        metaInfoRepository.save(chatroom);
    }

    public void exitToChatRoom(String roomId, String memberId) {
        Chatroom chatroom = metaInfoRepository.findById(roomId).orElseThrow();
        chatroom.exit(memberId);
    }

    public Chatroom getChatroom(String chatroomId) {
        return metaInfoRepository.findById(chatroomId).orElseThrow();
    }

    @Transactional(readOnly = true)
    public ChatLog getMessageInfo(String roomId, String memberId) {
        Chatroom chatroom = metaInfoRepository.findById(roomId).orElseGet(() -> Chatroom.create(roomId, memberId));
        return ChatLog.of(chatroom, memberId);
    }

    @Transactional(readOnly = true)
    public List<ChatroomSummary> addLastMessage(List<ChatroomSummary> chatroomSummaries, String memberId) {

        return chatroomSummaries.stream()
                .map(s -> s.addChatLogs(getMessageInfo(s.getChatroomId(), memberId)))
                .collect(Collectors.toList());
    }

    @Async
    @EventListener
    public void chatroomCreatedEventHandler(ChatroomCreatedEvent event) {
        ChatroomInfo info = event.getInfo();
        Chatroom chatroom = Chatroom.init(info);
        metaInfoRepository.save(chatroom);
    }

    @Async
    @EventListener
    public void chatBubbleArrivedEventHandler(ChatBubbleArrivedEvent event) throws NotChatroomMemberException {
        ChatBubble chatBubble = event.getChatBubble();
        Chatroom chatroom = getChatroom(chatBubble.getRoomId());
        log.debug("🐛 chatroom : {}", chatroom.toString());
        chatroom.updateLastMessage(chatBubble);
        Chatroom saveChatroom = metaInfoRepository.save(chatroom);
        log.debug("🐛 saved chatroom : {}", saveChatroom.toString());
        eventPublisher.publishEvent(ChatNotificationEvent.of(saveChatroom, chatBubble));
    }
}
