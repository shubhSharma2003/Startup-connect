package com.startupconnect.dto.auth;
public record RegisterRequest(
    String name,
    String email,
    String password,
    String college,
    String course,
    Integer graduationYear
) {}
