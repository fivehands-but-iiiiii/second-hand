package com.team5.secondhand.application.chatroom.dto.response;

import com.team5.secondhand.application.chatroom.domian.Chatroom;
import com.team5.secondhand.application.chatroom.exception.NotChatroomMemberException;
import com.team5.secondhand.application.item.domain.Item;
import com.team5.secondhand.application.member.domain.Member;
import java.io.Serializable;
import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ChatroomDetails implements Serializable {
    private final String chatroomId;
    private final String opponentId;
    private final Boolean isOpponentIn;
    private final ChatItemDetails item;

    @Builder
    public ChatroomDetails(String chatroomId, String opponentId, Boolean isOpponentIn, ChatItemDetails item) {
        this.chatroomId = chatroomId;
        this.opponentId = opponentId;
        this.isOpponentIn = isOpponentIn;
        this.item = item;
    }


    public static ChatroomDetails of(Chatroom chatRoom, Member member) throws NotChatroomMemberException {
        Member opponent = chatRoom.findOpponent(member);

        return ChatroomDetails.builder()
                .opponentId(opponent.getMemberId())
                .isOpponentIn(chatRoom.isChatroomMember(opponent))
                .item(ChatItemDetails.from(chatRoom.getItem()))
                .chatroomId(chatRoom.getChatroomId().toString())
                .build();
    }

    public static ChatroomDetails from(Item item) {
        return ChatroomDetails.builder()
                .opponentId(item.getSeller().getMemberId())
                .isOpponentIn(false)
                .item(ChatItemDetails.from(item))
                .chatroomId(null)
                .build();
    }

    public static ChatroomDetails from(Chatroom chatroom) {
        return ChatroomDetails.builder()
                .opponentId(chatroom.getBuyer().getMemberId())
                .isOpponentIn(chatroom.isChatroomMember(chatroom.getBuyer())) // 무조건 buyer 정보로 반환
                .item(ChatItemDetails.from(chatroom.getItem()))
                .chatroomId(chatroom.getChatroomId().toString())
                .build();
    }
}
