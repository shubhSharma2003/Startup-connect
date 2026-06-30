package com.startupconnect.service.impl;

import com.startupconnect.dto.ProjectRequest;
import com.startupconnect.dto.ProjectResponse;
import com.startupconnect.entity.Project;
import com.startupconnect.entity.ProjectStatus;
import com.startupconnect.entity.User;
import com.startupconnect.mapper.ProjectMapper;
import com.startupconnect.repository.ProjectRepository;
import com.startupconnect.repository.SkillRepository;
import com.startupconnect.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ProjectServiceImplTest {

    @Mock
    private ProjectRepository projectRepository;
    @Mock
    private UserRepository userRepository;
    @Mock
    private SkillRepository skillRepository;
    @Mock
    private ProjectMapper projectMapper;

    @InjectMocks
    private ProjectServiceImpl projectService;

    private User testUser;
    private Project testProject;
    private ProjectRequest projectRequest;
    private ProjectResponse projectResponse;

    @BeforeEach
    void setUp() {
        testUser = User.builder()
                .id(1L)
                .email("test@example.com")
                .build();

        testProject = Project.builder()
                .id(1L)
                .title("Test Project")
                .status(ProjectStatus.OPEN)
                .owner(testUser)
                .build();

        projectRequest = ProjectRequest.builder()
                .title("Test Project")
                .description("Test Description")
                .status(ProjectStatus.OPEN)
                .build();

        projectResponse = ProjectResponse.builder()
                .id(1L)
                .title("Test Project")
                .status(ProjectStatus.OPEN)
                .build();
    }

    @Test
    void testCreateProject() {
        when(userRepository.findByEmailIgnoreCase("test@example.com")).thenReturn(Optional.of(testUser));
        when(projectRepository.save(any(Project.class))).thenReturn(testProject);
        when(projectMapper.projectToProjectResponse(any(Project.class))).thenReturn(projectResponse);

        ProjectResponse response = projectService.createProject(projectRequest, "test@example.com");

        assertNotNull(response);
        assertEquals("Test Project", response.getTitle());
        verify(userRepository).findByEmailIgnoreCase("test@example.com");
        verify(projectRepository).save(any(Project.class));
    }
}
