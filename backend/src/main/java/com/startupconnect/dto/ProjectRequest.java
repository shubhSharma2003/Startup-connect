package com.startupconnect.dto;
import java.util.Set;
import lombok.Builder;

@Builder
public record ProjectRequest(
    String title,
    String description,
    Integer maxTeamSize,
    Set<String> requiredSkills
) {}
