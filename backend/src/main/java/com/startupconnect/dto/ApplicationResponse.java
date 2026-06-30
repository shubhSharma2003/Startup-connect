package com.startupconnect.dto;
import lombok.Builder;
import com.startupconnect.dto.user.UserProfileResponse;

@Builder
public record ApplicationResponse(
    Long id,
    String message,
    String status,
    UserProfileResponse applicant,
    Long projectId,
    java.time.LocalDateTime createdAt
) {}
