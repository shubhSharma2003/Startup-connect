package com.startupconnect.service;

import org.springframework.web.multipart.MultipartFile;

public interface FileStorageService {
    String uploadProfileImage(Long userId, MultipartFile file);
    String uploadResume(Long userId, MultipartFile file);
    String uploadProjectFile(Long projectId, MultipartFile file);
    void deleteFile(String fileUrl);
}
