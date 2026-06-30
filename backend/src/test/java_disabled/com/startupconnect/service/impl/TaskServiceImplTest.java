package com.startupconnect.service.impl;

import com.startupconnect.dto.TaskAssignmentRequest;
import com.startupconnect.dto.TaskRequest;
import com.startupconnect.dto.TaskResponse;
import com.startupconnect.entity.Project;
import com.startupconnect.entity.Task;
import com.startupconnect.entity.TaskPriority;
import com.startupconnect.entity.TaskStatus;
import com.startupconnect.entity.TeamMember;
import com.startupconnect.entity.TeamRole;
import com.startupconnect.entity.User;
import com.startupconnect.exception.BadRequestException;
import com.startupconnect.exception.UnauthorizedException;
import com.startupconnect.mapper.TaskMapper;
import com.startupconnect.repository.ProjectRepository;
import com.startupconnect.repository.TaskRepository;
import com.startupconnect.repository.TeamMemberRepository;
import com.startupconnect.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.jpa.domain.Specification;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class TaskServiceImplTest {

    @Mock
    private TaskRepository taskRepository;
    @Mock
    private ProjectRepository projectRepository;
    @Mock
    private UserRepository userRepository;
    @Mock
    private TeamMemberRepository teamMemberRepository;
    @Mock
    private TaskMapper taskMapper;
    @Mock
    private ApplicationEventPublisher eventPublisher;

    @InjectMocks
    private TaskServiceImpl taskService;

    private User owner;
    private User regularUser;
    private User outsider;
    private Project project;
    private TeamMember teamMember;
    private Task task;

    @BeforeEach
    void setUp() {
        owner = User.builder().id(1L).email("owner@example.com").build();
        regularUser = User.builder().id(2L).email("user@example.com").build();
        outsider = User.builder().id(3L).email("outsider@example.com").build();

        project = Project.builder().id(1L).owner(owner).build();
        teamMember = TeamMember.builder().id(1L).project(project).user(regularUser).role(TeamRole.MEMBER).build();

        task = Task.builder().id(1L).project(project).title("Fix bug").build();
    }

    @Test
    void testCreateTaskSuccessAsMember() {
        when(projectRepository.findById(1L)).thenReturn(Optional.of(project));
        when(userRepository.findByEmailIgnoreCase("user@example.com")).thenReturn(Optional.of(regularUser));
        when(teamMemberRepository.findByProjectIdAndUserId(1L, 2L)).thenReturn(Optional.of(teamMember));
        when(taskRepository.save(any(Task.class))).thenReturn(task);
        when(taskMapper.taskToTaskResponse(any(Task.class))).thenReturn(new TaskResponse());

        TaskRequest request = TaskRequest.builder().title("New Task").build();
        TaskResponse response = taskService.createTask(1L, request, "user@example.com");

        assertNotNull(response);
        verify(taskRepository).save(any(Task.class));
    }

    @Test
    void testCreateTaskUnauthorized() {
        when(projectRepository.findById(1L)).thenReturn(Optional.of(project));
        when(userRepository.findByEmailIgnoreCase("outsider@example.com")).thenReturn(Optional.of(outsider));
        when(teamMemberRepository.findByProjectIdAndUserId(1L, 3L)).thenReturn(Optional.empty());

        TaskRequest request = TaskRequest.builder().title("New Task").build();
        
        assertThrows(UnauthorizedException.class, () -> {
            taskService.createTask(1L, request, "outsider@example.com");
        });
    }

    @Test
    void testDeleteTaskUnauthorized() {
        when(taskRepository.findById(1L)).thenReturn(Optional.of(task));
        when(userRepository.findByEmailIgnoreCase("user@example.com")).thenReturn(Optional.of(regularUser));
        when(teamMemberRepository.findByProjectIdAndUserId(1L, 2L)).thenReturn(Optional.of(teamMember)); // Member, not Admin

        assertThrows(UnauthorizedException.class, () -> {
            taskService.deleteTask(1L, "user@example.com");
        });
    }

    @Test
    void testAssignTaskOutsiderFails() {
        when(taskRepository.findById(1L)).thenReturn(Optional.of(task));
        when(userRepository.findById(3L)).thenReturn(Optional.of(outsider));
        when(teamMemberRepository.findByProjectIdAndUserId(1L, 3L)).thenReturn(Optional.empty());

        TaskAssignmentRequest request = TaskAssignmentRequest.builder().assigneeId(3L).build();

        assertThrows(BadRequestException.class, () -> {
            taskService.assignTask(1L, request, "owner@example.com");
        });
    }
}
