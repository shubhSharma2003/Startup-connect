package com.startupconnect.service.event;

import com.startupconnect.entity.NotificationType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NotificationEvent {
    private Long recipientUserId;
    private NotificationType type;
    private String title;
    private String message;
    private Long referenceId;
}
