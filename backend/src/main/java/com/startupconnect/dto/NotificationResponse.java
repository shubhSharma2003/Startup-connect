package com.startupconnect.dto;
import lombok.Builder;

import java.time.LocalDateTime;

@Builder
public record NotificationResponse(
    Long id,
    String title,
    String message,
    String type,
    Long referenceId,
    boolean read,
    LocalDateTime createdAt
) {}
