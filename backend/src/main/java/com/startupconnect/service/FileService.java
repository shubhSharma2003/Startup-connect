package com.startupconnect.service;

import com.startupconnect.dto.FileResponse;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface FileService {
    FileResponse uploadFile(Long projectId, MultipartFile file, String currentUserEmail);
    List<FileResponse> getProjectFiles(Long projectId, String currentUserEmail);
    void deleteFile(Long fileId, String currentUserEmail);
    String getFileDownloadUrl(Long fileId, String currentUserEmail);
}
