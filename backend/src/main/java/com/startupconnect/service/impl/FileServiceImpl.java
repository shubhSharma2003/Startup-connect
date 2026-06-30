package com.startupconnect.service.impl;

import com.startupconnect.dto.FileResponse;
import com.startupconnect.entity.Project;
import com.startupconnect.entity.ProjectFile;
import com.startupconnect.entity.User;
import com.startupconnect.exception.ResourceNotFoundException;
import com.startupconnect.exception.UnauthorizedException;
import com.startupconnect.mapper.FileMapper;
import com.startupconnect.repository.ProjectFileRepository;
import com.startupconnect.repository.ProjectRepository;
import com.startupconnect.repository.TeamMemberRepository;
import com.startupconnect.repository.UserRepository;
import com.startupconnect.service.FileService;
import com.startupconnect.service.FileStorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class FileServiceImpl implements FileService {
    
    private final ProjectFileRepository projectFileRepository;
    private final ProjectRepository projectRepository;
    private final UserRepository userRepository;
    private final TeamMemberRepository teamMemberRepository;
    private final FileStorageService fileStorageService;
    private final FileMapper fileMapper;

    @Override
    @Transactional
    public FileResponse uploadFile(Long projectId, MultipartFile file, String currentUserEmail) {
        Project project = projectRepository.findById(projectId)
                .orElseThrow(() -> new ResourceNotFoundException("Project not found"));
        User user = userRepository.findByEmailIgnoreCase(currentUserEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
                
        checkProjectAccess(project, user);
        
        String fileUrl = fileStorageService.uploadProjectFile(projectId, file);
        
        ProjectFile projectFile = ProjectFile.builder()
                .project(project)
                .uploader(user)
                .fileName(file.getOriginalFilename())
                .fileUrl(fileUrl)
                .contentType(file.getContentType())
                .size(file.getSize())
                .uploadedAt(LocalDateTime.now())
                .build();
                
        ProjectFile saved = projectFileRepository.save(projectFile);
        return fileMapper.projectFileToFileResponse(saved);
    }

    @Override
    public List<FileResponse> getProjectFiles(Long projectId, String currentUserEmail) {
        Project project = projectRepository.findById(projectId)
                .orElseThrow(() -> new ResourceNotFoundException("Project not found"));
        User user = userRepository.findByEmailIgnoreCase(currentUserEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
                
        checkProjectAccess(project, user);
        
        return projectFileRepository.findByProjectId(projectId).stream()
                .map(fileMapper::projectFileToFileResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void deleteFile(Long fileId, String currentUserEmail) {
        ProjectFile file = projectFileRepository.findById(fileId)
                .orElseThrow(() -> new ResourceNotFoundException("File not found"));
        User user = userRepository.findByEmailIgnoreCase(currentUserEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
                
        if (!file.getProject().getOwner().getId().equals(user.getId()) && !file.getUploader().getId().equals(user.getId())) {
            throw new UnauthorizedException("You do not have permission to delete this file");
        }
        
        fileStorageService.deleteFile(file.getFileUrl());
        projectFileRepository.delete(file);
    }

    @Override
    public String getFileDownloadUrl(Long fileId, String currentUserEmail) {
        ProjectFile file = projectFileRepository.findById(fileId)
                .orElseThrow(() -> new ResourceNotFoundException("File not found"));
        User user = userRepository.findByEmailIgnoreCase(currentUserEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
                
        checkProjectAccess(file.getProject(), user);
        return file.getFileUrl();
    }
    
    private void checkProjectAccess(Project project, User user) {
        if (!project.getOwner().getId().equals(user.getId()) && 
            teamMemberRepository.findByProjectIdAndUserId(project.getId(), user.getId()).isEmpty()) {
            throw new UnauthorizedException("You do not have access to this project's files");
        }
    }
}
