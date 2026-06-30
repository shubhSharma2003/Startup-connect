package com.startupconnect.dto.user;
public record UpdateProfileRequest(
    String name,
    String bio,
    String college,
    String course,
    Integer graduationYear,
    String githubUrl,
    String linkedinUrl
) {}
