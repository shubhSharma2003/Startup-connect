package com.startupconnect.service.impl;

import com.startupconnect.dto.NotificationCountResponse;
import com.startupconnect.entity.Notification;
import com.startupconnect.entity.NotificationType;
import com.startupconnect.entity.User;
import com.startupconnect.exception.UnauthorizedException;
import com.startupconnect.mapper.NotificationMapper;
import com.startupconnect.repository.NotificationRepository;
import com.startupconnect.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class NotificationServiceImplTest {

    @Mock
    private NotificationRepository notificationRepository;
    @Mock
    private UserRepository userRepository;
    @Mock
    private NotificationMapper notificationMapper;

    @InjectMocks
    private NotificationServiceImpl notificationService;

    private User owner;
    private User outsider;
    private Notification notification;

    @BeforeEach
    void setUp() {
        owner = User.builder().id(1L).email("owner@example.com").build();
        outsider = User.builder().id(2L).email("outsider@example.com").build();

        notification = Notification.builder()
                .id(1L)
                .user(owner)
                .type(NotificationType.SYSTEM_ALERT)
                .title("Alert")
                .message("Test msg")
                .isRead(false)
                .build();
    }

    @Test
    void testGetUnreadCount() {
        when(userRepository.findByEmailIgnoreCase("owner@example.com")).thenReturn(Optional.of(owner));
        when(notificationRepository.countByUserIdAndIsReadFalse(1L)).thenReturn(5L);

        NotificationCountResponse response = notificationService.getUnreadCount("owner@example.com");
        assertEquals(5L, response.getUnreadCount());
    }

    @Test
    void testMarkAsReadSuccess() {
        when(notificationRepository.findById(1L)).thenReturn(Optional.of(notification));
        
        notificationService.markAsRead(1L, "owner@example.com");

        assertTrue(notification.isRead());
        verify(notificationRepository).save(any(Notification.class));
    }

    @Test
    void testMarkAsReadUnauthorized() {
        when(notificationRepository.findById(1L)).thenReturn(Optional.of(notification));

        assertThrows(UnauthorizedException.class, () -> {
            notificationService.markAsRead(1L, "outsider@example.com");
        });
    }

    @Test
    void testDeleteNotificationUnauthorized() {
        when(notificationRepository.findById(1L)).thenReturn(Optional.of(notification));

        assertThrows(UnauthorizedException.class, () -> {
            notificationService.deleteNotification(1L, "outsider@example.com");
        });
    }
}
