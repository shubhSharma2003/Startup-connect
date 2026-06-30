package com.startupconnect.dto;
import java.util.Set;
import lombok.Builder;
import com.startupconnect.dto.user.UserProfileResponse;

@Builder
public record ProjectResponse(
    Long id,
    String title,
    String description,
    String status,
    Integer maxTeamSize,
    UserProfileResponse owner,
    Set<String> requiredSkills,
    java.time.LocalDateTime createdAt,
    java.time.LocalDateTime updatedAt
) {}
