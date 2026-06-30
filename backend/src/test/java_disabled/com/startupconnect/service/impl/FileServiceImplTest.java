package com.startupconnect.service.impl;

import com.startupconnect.dto.FileResponse;
import com.startupconnect.entity.Project;
import com.startupconnect.entity.ProjectFile;
import com.startupconnect.entity.TeamMember;
import com.startupconnect.entity.TeamRole;
import com.startupconnect.entity.User;
import com.startupconnect.exception.UnauthorizedException;
import com.startupconnect.mapper.FileMapper;
import com.startupconnect.repository.ProjectFileRepository;
import com.startupconnect.repository.ProjectRepository;
import com.startupconnect.repository.TeamMemberRepository;
import com.startupconnect.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class FileServiceImplTest {

    @Mock
    private ProjectFileRepository projectFileRepository;
    @Mock
    private ProjectRepository projectRepository;
    @Mock
    private UserRepository userRepository;
    @Mock
    private TeamMemberRepository teamMemberRepository;
    @Mock
    private FileMapper fileMapper;
    @Mock
    private S3Client s3Client;

    @InjectMocks
    private FileServiceImpl fileService;

    private User owner;
    private User regularUser;
    private User outsider;
    private Project project;
    private TeamMember teamMember;
    private ProjectFile projectFile;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(fileService, "bucketName", "test-bucket");
        ReflectionTestUtils.setField(fileService, "region", "us-east-1");

        owner = User.builder().id(1L).email("owner@example.com").build();
        regularUser = User.builder().id(2L).email("user@example.com").build();
        outsider = User.builder().id(3L).email("outsider@example.com").build();

        project = Project.builder().id(1L).owner(owner).build();
        teamMember = TeamMember.builder().id(1L).project(project).user(regularUser).role(TeamRole.MEMBER).build();

        projectFile = ProjectFile.builder().id(1L).project(project).uploader(regularUser).s3Key("test-key").build();
    }

    @Test
    void testUploadFileSuccessAsMember() {
        when(projectRepository.findById(1L)).thenReturn(Optional.of(project));
        when(userRepository.findByEmailIgnoreCase("user@example.com")).thenReturn(Optional.of(regularUser));
        when(teamMemberRepository.findByProjectIdAndUserId(1L, 2L)).thenReturn(Optional.of(teamMember));
        when(projectFileRepository.save(any(ProjectFile.class))).thenReturn(projectFile);
        when(fileMapper.projectFileToFileResponse(any(ProjectFile.class))).thenReturn(new FileResponse());

        MultipartFile file = new MockMultipartFile("file", "test.txt", "text/plain", "content".getBytes());

        FileResponse response = fileService.uploadFile(1L, file, "user@example.com");

        assertNotNull(response);
        verify(s3Client).putObject(any(PutObjectRequest.class), any(RequestBody.class));
        verify(projectFileRepository).save(any(ProjectFile.class));
    }

    @Test
    void testUploadFileUnauthorized() {
        when(projectRepository.findById(1L)).thenReturn(Optional.of(project));
        when(userRepository.findByEmailIgnoreCase("outsider@example.com")).thenReturn(Optional.of(outsider));
        when(teamMemberRepository.findByProjectIdAndUserId(1L, 3L)).thenReturn(Optional.empty());

        MultipartFile file = new MockMultipartFile("file", "test.txt", "text/plain", "content".getBytes());

        assertThrows(UnauthorizedException.class, () -> {
            fileService.uploadFile(1L, file, "outsider@example.com");
        });
    }

    @Test
    void testDeleteFileSuccessAsUploader() {
        when(projectFileRepository.findById(1L)).thenReturn(Optional.of(projectFile));

        fileService.deleteFile(1L, "user@example.com");

        verify(s3Client).deleteObject(any(DeleteObjectRequest.class));
        verify(projectFileRepository).delete(any(ProjectFile.class));
    }

    @Test
    void testDeleteFileUnauthorized() {
        when(projectFileRepository.findById(1L)).thenReturn(Optional.of(projectFile));
        when(userRepository.findByEmailIgnoreCase("outsider@example.com")).thenReturn(Optional.of(outsider));
        when(teamMemberRepository.findByProjectIdAndUserId(1L, 3L)).thenReturn(Optional.empty());

        assertThrows(UnauthorizedException.class, () -> {
            fileService.deleteFile(1L, "outsider@example.com");
        });
    }
}
