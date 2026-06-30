package com.startupconnect.dto;
import lombok.Builder;
@Builder
public record FileResponse(
    Long id,
    String fileName,
    String fileUrl,
    String contentType,
    Long size,
    java.time.LocalDateTime uploadedAt
) {}
