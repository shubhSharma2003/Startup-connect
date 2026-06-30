package com.startupconnect.service.impl;

import com.startupconnect.dto.ApplicationRequest;
import com.startupconnect.dto.ApplicationResponse;
import com.startupconnect.entity.Application;
import com.startupconnect.entity.ApplicationStatus;
import com.startupconnect.entity.Project;
import com.startupconnect.entity.ProjectStatus;
import com.startupconnect.entity.User;
import com.startupconnect.exception.BadRequestException;
import com.startupconnect.mapper.ApplicationMapper;
import com.startupconnect.repository.ApplicationRepository;
import com.startupconnect.repository.ProjectRepository;
import com.startupconnect.repository.UserRepository;
import com.startupconnect.service.TeamService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.context.ApplicationEventPublisher;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ApplicationServiceImplTest {

    @Mock
    private ApplicationRepository applicationRepository;
    @Mock
    private ProjectRepository projectRepository;
    @Mock
    private UserRepository userRepository;
    @Mock
    private ApplicationMapper applicationMapper;
    @Mock
    private TeamService teamService;
    @Mock
    private ApplicationEventPublisher eventPublisher;

    @InjectMocks
    private ApplicationServiceImpl applicationService;

    private User owner;
    private User applicant;
    private Project project;
    private ApplicationRequest request;
    private ApplicationResponse response;

    @BeforeEach
    void setUp() {
        owner = User.builder().id(1L).email("owner@example.com").build();
        applicant = User.builder().id(2L).email("applicant@example.com").build();
        project = Project.builder().id(1L).owner(owner).status(ProjectStatus.OPEN).build();
        request = ApplicationRequest.builder().message("Hire me").build();
        response = ApplicationResponse.builder().id(1L).message("Hire me").status(ApplicationStatus.PENDING).build();
    }

    @Test
    void testApplyToProjectSuccess() {
        when(projectRepository.findById(1L)).thenReturn(Optional.of(project));
        when(userRepository.findByEmailIgnoreCase("applicant@example.com")).thenReturn(Optional.of(applicant));
        when(applicationRepository.findByProjectIdAndApplicantId(1L, 2L)).thenReturn(Optional.empty());
        when(applicationRepository.save(any(Application.class))).thenReturn(new Application());
        when(applicationMapper.applicationToApplicationResponse(any(Application.class))).thenReturn(response);

        ApplicationResponse result = applicationService.applyToProject(1L, request, "applicant@example.com");

        assertNotNull(result);
        assertEquals(ApplicationStatus.PENDING, result.getStatus());
        verify(applicationRepository).save(any(Application.class));
    }

    @Test
    void testApplyToProjectOwnerCannotApply() {
        when(projectRepository.findById(1L)).thenReturn(Optional.of(project));
        when(userRepository.findByEmailIgnoreCase("owner@example.com")).thenReturn(Optional.of(owner));

        assertThrows(BadRequestException.class, () -> {
            applicationService.applyToProject(1L, request, "owner@example.com");
        });
    }

    @Test
    void testApplyToProjectNotOpen() {
        project.setStatus(ProjectStatus.COMPLETED);
        when(projectRepository.findById(1L)).thenReturn(Optional.of(project));

        assertThrows(BadRequestException.class, () -> {
            applicationService.applyToProject(1L, request, "applicant@example.com");
        });
    }
}
