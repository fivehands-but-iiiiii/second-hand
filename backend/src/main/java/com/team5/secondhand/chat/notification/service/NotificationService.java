package com.team5.secondhand.chat.notification.service;

import com.team5.secondhand.chat.chatroom.domain.Chatroom;
import com.team5.secondhand.chat.notification.domain.SseEvent;
import com.team5.secondhand.chat.notification.domain.SseKey;
import com.team5.secondhand.chat.notification.dto.ChatNotification;
import com.team5.secondhand.chat.notification.repository.NotificationRepository;
import com.team5.secondhand.global.event.chatbubble.ChatNotificationEvent;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.event.TransactionalEventListener;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import java.util.NoSuchElementException;

@Slf4j
@Service
@RequiredArgsConstructor
public class NotificationService implements SendChatNotificationUsecase {
    private final Long DEFAULT_TIMEOUT = 864000L;
    private final NotificationRepository notificationRepository;

    @Transactional
    public SseEmitter subscribe(String id, String lastEventId, HttpServletResponse response) {
        SseKey sseId = SseKey.of(id);

        log.debug("🧹 SSE subscribe : {}", sseId.getKey());

        SseEmitter emitter = notificationRepository.save(sseId, new SseEmitter(DEFAULT_TIMEOUT));
        response.setHeader("X-Accel-Buffering", "no");
        response.setHeader("Last-Event-ID", sseId.getKey());

        emitter.onCompletion(() -> {
            log.info("SSE onCompletion");
            notificationRepository.deleteById(sseId);
        });
        emitter.onTimeout(() -> {
            log.info("SSE onTimeout");
            emitter.complete();
        });
        emitter.onError(e -> {
            log.info("SSE error : {}", e.getMessage());
            emitter.complete();
        });

        log.debug("connected successfully member key : {}", id);
        sendToClient(emitter, id, String.format("connected successfully member key : %s", id));

        if (!lastEventId.isEmpty()) {
            Map<SseKey, SseEmitter> events = notificationRepository.findAllStartById(id);
            events.entrySet().stream()
                    .filter(entry -> lastEventId.compareTo(entry.getKey().getMemberId()) < 0)
                    .forEach(entry -> sendToClient(emitter, entry.getKey().getKey(), entry.getValue())); //클라이언트가 연결을 끊기 전까지 받지 못한 새로운 이벤트를 보내준다.
        }

        return emitter;
    }

    private void sendToClient(SseEmitter emitter, String id, Object data) {
        try {
            log.debug("✌️ send to client : {}", data.toString());
            emitter.send(SseEmitter.event()
                    .id(id)
                    .name(SseEvent.CHAT_NOTIFICATION.getEvent())
                    .data(data));
        } catch (IOException e) {
            log.info("상대방이 접속중이 아닙니다.");
        }
    }

    @Override
    @Transactional
    public void sendChatNotificationToMember(String id, Chatroom chatroom, ChatNotification chatNotification) {
        SseEmitter sseEmitter = notificationRepository.findStartById(id).orElseThrow(() -> new NoSuchElementException("상대방이 접속중이 아닙니다."));
        log.debug("👋 sse receiverId : {}, notification : {}", id, chatNotification.getMessage());
        if (chatroom.hasPaticipant(id)) {
            log.debug("🥹 has participant : {}");
            sendToClient(sseEmitter, id, chatNotification);
        }
    }

    @EventListener
    public void getChatBubble (ChatNotificationEvent event) {
        String receiverId = event.getChatBubble().getReceiver();
        //TODO 유효성 검증이 필요
            //TODO 현재 채팅방에 존재하는 멤버(1인 이상)에게 알람을 보내야 한다.
            //TODO 현재 채팅방을 구독중(websocket 통신중인) 멤버에게는 보내지 않아야 한다.
        log.debug("👋 sse receiverId : {}", receiverId);
        sendChatNotificationToMember(receiverId, event.getChatroom(), ChatNotification.of(event.getChatBubble(), event.getChatroom()));
    }

}
