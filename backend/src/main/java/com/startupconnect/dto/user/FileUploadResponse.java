package com.startupconnect.dto.user;
public record FileUploadResponse(
    String originalFilename,
    String fileUrl,
    String contentType,
    long size
) {}
