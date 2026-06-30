package com.startupconnect.controller;

import com.startupconnect.dto.ApiResponse;
import com.startupconnect.dto.FileResponse;
import com.startupconnect.service.FileService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
@Tag(name = "File Management", description = "APIs for managing project files")
public class FileController {

    private final FileService fileService;

    @Operation(summary = "Upload a file to a project")
    @PostMapping(value = "/projects/{projectId}/files", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<ApiResponse<FileResponse>> uploadFile(
            @PathVariable Long projectId,
            @RequestParam("file") MultipartFile file,
            Authentication authentication) {
        FileResponse response = fileService.uploadFile(projectId, file, authentication.getName());
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success("File uploaded successfully", response));
    }

    @Operation(summary = "Get all files for a project")
    @GetMapping("/projects/{projectId}/files")
    public ResponseEntity<ApiResponse<List<FileResponse>>> getProjectFiles(
            @PathVariable Long projectId,
            Authentication authentication) {
        List<FileResponse> response = fileService.getProjectFiles(projectId, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Files retrieved successfully", response));
    }

    @Operation(summary = "Delete a file")
    @DeleteMapping("/files/{fileId}")
    public ResponseEntity<ApiResponse<Void>> deleteFile(
            @PathVariable Long fileId,
            Authentication authentication) {
        fileService.deleteFile(fileId, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("File deleted successfully", null));
    }

    @Operation(summary = "Get download URL for a file")
    @GetMapping("/files/{fileId}/download-url")
    public ResponseEntity<ApiResponse<String>> getFileDownloadUrl(
            @PathVariable Long fileId,
            Authentication authentication) {
        String url = fileService.getFileDownloadUrl(fileId, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("File download URL retrieved successfully", url));
    }
}
