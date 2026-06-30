package com.startupconnect.service.event;

import com.startupconnect.entity.Notification;
import com.startupconnect.entity.User;
import com.startupconnect.repository.NotificationRepository;
import com.startupconnect.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Component
@RequiredArgsConstructor
public class NotificationEventListener {

    private final NotificationRepository notificationRepository;
    private final UserRepository userRepository;

    @Async
    @EventListener
    @Transactional
    public void handleNotificationEvent(NotificationEvent event) {
        log.debug("Received notification event: {}", event);

        try {
            User recipient = userRepository.findById(event.getRecipientUserId())
                    .orElseThrow(() -> new IllegalArgumentException("User not found: " + event.getRecipientUserId()));

            Notification notification = Notification.builder()
                    .user(recipient)
                    .type(event.getType())
                    .title(event.getTitle())
                    .message(event.getMessage())
                    .referenceId(event.getReferenceId())
                    .isRead(false)
                    .build();

            notificationRepository.save(notification);
            log.info("Saved notification for user: {}", event.getRecipientUserId());
        } catch (Exception e) {
            log.error("Failed to process notification event for user {}: {}", event.getRecipientUserId(), e.getMessage());
        }
    }
}
