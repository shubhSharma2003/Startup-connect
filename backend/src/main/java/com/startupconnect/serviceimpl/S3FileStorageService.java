package com.startupconnect.serviceimpl;

import com.startupconnect.service.FileStorageService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import lombok.extern.slf4j.Slf4j;
import java.util.UUID;

@Service
@Slf4j
public class S3FileStorageService implements FileStorageService {

    @Override
    public String uploadProfileImage(Long userId, MultipartFile file) {
        log.info("Uploading profile image for user {}", userId);
        return "https://storage.example.com/profiles/" + userId + "/" + UUID.randomUUID() + "-" + file.getOriginalFilename();
    }

    @Override
    public String uploadResume(Long userId, MultipartFile file) {
        log.info("Uploading resume for user {}", userId);
        return "https://storage.example.com/resumes/" + userId + "/" + UUID.randomUUID() + "-" + file.getOriginalFilename();
    }
    
    @Override
    public String uploadProjectFile(Long projectId, MultipartFile file) {
        log.info("Uploading project file for project {}", projectId);
        return "https://storage.example.com/projects/" + projectId + "/" + UUID.randomUUID() + "-" + file.getOriginalFilename();
    }
    
    @Override
    public void deleteFile(String fileUrl) {
        log.info("Deleting file at {}", fileUrl);
    }
}
