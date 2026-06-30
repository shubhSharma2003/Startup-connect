package com.startupconnect.dto.user;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Set;

public record UserProfileResponse(
    Long id,
    String name,
    String email,
    String bio,
    String college,
    String course,
    Integer graduationYear,
    String profileImage,
    String githubUrl,
    String linkedinUrl,
    String resumeUrl,
    BigDecimal rating,
    boolean emailVerified,
    Set<SkillResponse> skills,
    LocalDateTime createdAt,
    LocalDateTime updatedAt
) {}
