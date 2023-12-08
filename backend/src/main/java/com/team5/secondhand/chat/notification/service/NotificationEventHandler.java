package com.team5.secondhand.chat.notification.service;

import com.team5.secondhand.application.chatroom.dto.ChatroomInfo;
import com.team5.secondhand.application.chatroom.dto.response.ChatroomDetails;
import com.team5.secondhand.application.chatroom.exception.ExistChatRoomException;
import com.team5.secondhand.application.chatroom.service.ChatroomFacade;
import com.team5.secondhand.chat.chatroom.domain.Chatroom;
import com.team5.secondhand.chat.notification.dto.ChatNotification;
import com.team5.secondhand.global.event.chatbubble.ChatNotificationEvent;
import com.team5.secondhand.global.event.chatroom.ChatroomCreatedEvent;
import lombok.RequiredArgsConstructor;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class NotificationEventHandler {

    private final NotificationService notificationService;
    private final ChatroomFacade chatroomFacade;

    @Async
    @EventListener
    public void getChatBubble(ChatNotificationEvent event) {
        String receiverId = event.getChatBubble().getReceiver();
        notificationService.sendChatNotificationToMember(receiverId, event.getChatroom(),
                ChatNotification.of(event.getChatBubble(), event.getChatroom()));
    }

    @EventListener
    public void getNewChatroom(ChatroomCreatedEvent event) throws ExistChatRoomException {
        ChatroomInfo info = event.getInfo();
        ChatroomDetails chatroomInfo = chatroomFacade.findChatroomInfo(info.getRoomId());
        info.getMembers().forEach(e -> notificationService.sendChatRoomNotificationToMember(
                e, Chatroom.init(info), chatroomInfo));
    }

}
