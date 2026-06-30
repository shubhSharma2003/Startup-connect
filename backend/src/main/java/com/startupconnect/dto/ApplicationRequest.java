package com.startupconnect.dto;
import lombok.Builder;
@Builder
public record ApplicationRequest(
    String message
) {}
