package com.startupconnect.service.impl;

import com.startupconnect.dto.NotificationCountResponse;
import com.startupconnect.dto.NotificationResponse;
import com.startupconnect.entity.Notification;
import com.startupconnect.entity.User;
import com.startupconnect.exception.ResourceNotFoundException;
import com.startupconnect.exception.UnauthorizedException;
import com.startupconnect.mapper.NotificationMapper;
import com.startupconnect.repository.NotificationRepository;
import com.startupconnect.repository.UserRepository;
import com.startupconnect.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService {
    
    private final NotificationRepository notificationRepository;
    private final UserRepository userRepository;
    private final NotificationMapper notificationMapper;

    @Override
    public Page<NotificationResponse> getUserNotifications(String currentUserEmail, int page, int size) {
        User user = userRepository.findByEmailIgnoreCase(currentUserEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        PageRequest pageRequest = PageRequest.of(page, size, Sort.by("createdAt").descending());
        return notificationRepository.findByUserId(user.getId(), pageRequest)
                .map(notificationMapper::notificationToNotificationResponse);
    }

    @Override
    public NotificationCountResponse getUnreadCount(String currentUserEmail) {
        User user = userRepository.findByEmailIgnoreCase(currentUserEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        int count = notificationRepository.countByUserIdAndIsReadFalse(user.getId());
        return new NotificationCountResponse(count);
    }

    @Override
    @Transactional
    public void markAsRead(Long notificationId, String currentUserEmail) {
        Notification notification = notificationRepository.findById(notificationId)
                .orElseThrow(() -> new ResourceNotFoundException("Notification not found"));
        User user = userRepository.findByEmailIgnoreCase(currentUserEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
                
        if (!notification.getUser().getId().equals(user.getId())) {
            throw new UnauthorizedException("Not authorized to modify this notification");
        }
        
        notification.setRead(true);
        notificationRepository.save(notification);
    }

    @Override
    @Transactional
    public void markAllAsRead(String currentUserEmail) {
        User user = userRepository.findByEmailIgnoreCase(currentUserEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        List<Notification> unread = notificationRepository.findByUserIdAndIsReadFalse(user.getId());
        unread.forEach(n -> n.setRead(true));
        notificationRepository.saveAll(unread);
    }

    @Override
    @Transactional
    public void deleteNotification(Long notificationId, String currentUserEmail) {
        Notification notification = notificationRepository.findById(notificationId)
                .orElseThrow(() -> new ResourceNotFoundException("Notification not found"));
        User user = userRepository.findByEmailIgnoreCase(currentUserEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
                
        if (!notification.getUser().getId().equals(user.getId())) {
            throw new UnauthorizedException("Not authorized to modify this notification");
        }
        
        notificationRepository.delete(notification);
    }
}
