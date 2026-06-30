package com.startupconnect.dto;
import lombok.Builder;
@Builder
public record NotificationCountResponse(
    int unreadCount
) {}
