package com.team5.secondhand.chat.notification.service;

import com.team5.secondhand.application.chatroom.dto.response.ChatroomDetails;
import com.team5.secondhand.chat.chatroom.domain.Chatroom;
import com.team5.secondhand.chat.notification.dto.ChatNotification;

public interface SendChatNotificationUsecase {
    void sendChatNotificationToMember(String id, Chatroom chatroom, ChatNotification chatNotification);

    void sendChatRoomNotificationToMember(String member, Chatroom chatroom, ChatroomDetails of);
}
