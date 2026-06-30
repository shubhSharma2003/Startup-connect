package com.startupconnect.dto;

public record ErrorDetail(
        String field,
        String message
) {
}
