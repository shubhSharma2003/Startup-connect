package com.startupconnect.service;

import com.startupconnect.dto.NotificationCountResponse;
import com.startupconnect.dto.NotificationResponse;
import org.springframework.data.domain.Page;

public interface NotificationService {
    Page<NotificationResponse> getUserNotifications(String currentUserEmail, int page, int size);
    NotificationCountResponse getUnreadCount(String currentUserEmail);
    void markAsRead(Long notificationId, String currentUserEmail);
    void markAllAsRead(String currentUserEmail);
    void deleteNotification(Long notificationId, String currentUserEmail);
}
