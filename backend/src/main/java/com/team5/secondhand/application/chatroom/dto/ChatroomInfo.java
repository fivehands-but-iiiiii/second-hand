package com.team5.secondhand.application.chatroom.dto;

import com.team5.secondhand.application.chatroom.domian.Chatroom;
import java.util.List;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class ChatroomInfo {

    private final String roomId;
    private final List<String> members;

    public static ChatroomInfo from(Chatroom chatroom) {
        return new ChatroomInfo(chatroom.getChatroomId().toString(),
                chatroom.getChatroomMemberIds());
    }
}
