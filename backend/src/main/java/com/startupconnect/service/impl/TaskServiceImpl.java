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
import com.startupconnect.exception.ResourceNotFoundException;
import com.startupconnect.exception.UnauthorizedException;
import com.startupconnect.mapper.TaskMapper;
import com.startupconnect.repository.ProjectRepository;
import com.startupconnect.repository.TaskRepository;
import com.startupconnect.repository.TeamMemberRepository;
import com.startupconnect.repository.UserRepository;
import com.startupconnect.service.TaskService;
import jakarta.persistence.criteria.Predicate;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class TaskServiceImpl implements TaskService {

    private final TaskRepository taskRepository;
    private final ProjectRepository projectRepository;
    private final UserRepository userRepository;
    private final TeamMemberRepository teamMemberRepository;
    private final TaskMapper taskMapper;
    private final ApplicationEventPublisher eventPublisher;

    @Override
    @Transactional
    public TaskResponse createTask(Long projectId, TaskRequest request, String currentUserEmail) {
        Project project = getProjectEntityById(projectId);
        checkTeamMemberPermission(project, currentUserEmail);

        Task task = Task.builder()
                .title(request.getTitle())
                .description(request.getDescription())
                .project(project)
                .status(request.getStatus() != null ? request.getStatus() : TaskStatus.TODO)
                .priority(request.getPriority() != null ? request.getPriority() : TaskPriority.MEDIUM)
                .dueDate(request.getDueDate())
                .build();

        return taskMapper.taskToTaskResponse(taskRepository.save(task));
    }

    @Override
    @Transactional
    public TaskResponse updateTask(Long taskId, TaskRequest request, String currentUserEmail) {
        Task task = getTaskById(taskId);
        checkTeamMemberPermission(task.getProject(), currentUserEmail);

        task.setTitle(request.getTitle());
        task.setDescription(request.getDescription());
        if (request.getStatus() != null) {
            task.setStatus(request.getStatus());
        }
        if (request.getPriority() != null) {
            task.setPriority(request.getPriority());
        }
        task.setDueDate(request.getDueDate());

        return taskMapper.taskToTaskResponse(taskRepository.save(task));
    }

    @Override
    @Transactional
    public TaskResponse assignTask(Long taskId, TaskAssignmentRequest request, String currentUserEmail) {
        Task task = getTaskById(taskId);
        checkTeamMemberPermission(task.getProject(), currentUserEmail);

        if (request.getAssigneeId() == null) {
            task.setAssignee(null);
        } else {
            User assignee = userRepository.findById(request.getAssigneeId())
                    .orElseThrow(() -> new ResourceNotFoundException("Assignee user not found"));
            
            // Ensure assignee is part of the project
            if (!task.getProject().getOwner().getId().equals(assignee.getId())) {
                boolean isMember = teamMemberRepository.findByProjectIdAndUserId(task.getProject().getId(), assignee.getId()).isPresent();
                if (!isMember) {
                    throw new BadRequestException("Assignee must be a member of the project team");
                }
            }
            task.setAssignee(assignee);
            
            // Publish notification event
            com.startupconnect.service.event.NotificationEvent event = com.startupconnect.service.event.NotificationEvent.builder()
                    .recipientUserId(assignee.getId())
                    .type(com.startupconnect.entity.NotificationType.TASK_ASSIGNED)
                    .title("Task Assigned")
                    .message("You have been assigned to task: " + task.getTitle())
                    .referenceId(task.getId())
                    .build();
            eventPublisher.publishEvent(event);
        }

        return taskMapper.taskToTaskResponse(taskRepository.save(task));
    }

    @Override
    @Transactional
    public void deleteTask(Long taskId, String currentUserEmail) {
        Task task = getTaskById(taskId);
        checkAdminPermission(task.getProject(), currentUserEmail);
        taskRepository.delete(task);
    }

    @Override
    @Transactional(readOnly = true)
    public List<TaskResponse> getTasks(Long projectId, TaskStatus status, TaskPriority priority, Long assigneeId, String currentUserEmail) {
        Project project = getProjectEntityById(projectId);
        checkTeamMemberPermission(project, currentUserEmail);

        Specification<Task> spec = (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();
            predicates.add(cb.equal(root.get("project").get("id"), projectId));

            if (status != null) {
                predicates.add(cb.equal(root.get("status"), status));
            }
            if (priority != null) {
                predicates.add(cb.equal(root.get("priority"), priority));
            }
            if (assigneeId != null) {
                predicates.add(cb.equal(root.get("assignee").get("id"), assigneeId));
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };

        return taskRepository.findAll(spec).stream()
                .map(taskMapper::taskToTaskResponse)
                .collect(Collectors.toList());
    }

    private void checkTeamMemberPermission(Project project, String currentUserEmail) {
        if (project.getOwner().getEmail().equalsIgnoreCase(currentUserEmail)) {
            return;
        }

        User currentUser = userRepository.findByEmailIgnoreCase(currentUserEmail)
                .orElseThrow(() -> new UnauthorizedException("User not found"));

        Optional<TeamMember> member = teamMemberRepository.findByProjectIdAndUserId(project.getId(), currentUser.getId());
        if (member.isEmpty()) {
            throw new UnauthorizedException("You must be a member of the project to perform this action");
        }
    }

    private void checkAdminPermission(Project project, String currentUserEmail) {
        if (project.getOwner().getEmail().equalsIgnoreCase(currentUserEmail)) {
            return;
        }

        User currentUser = userRepository.findByEmailIgnoreCase(currentUserEmail)
                .orElseThrow(() -> new UnauthorizedException("User not found"));

        TeamMember member = teamMemberRepository.findByProjectIdAndUserId(project.getId(), currentUser.getId())
                .orElseThrow(() -> new UnauthorizedException("You must be a project owner or team ADMIN to perform this action"));

        if (member.getRole() != TeamRole.ADMIN) {
            throw new UnauthorizedException("You must be a project owner or team ADMIN to perform this action");
        }
    }

    private Task getTaskById(Long id) {
        return taskRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Task not found with id: " + id));
    }

    private Project getProjectEntityById(Long id) {
        return projectRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Project not found with id: " + id));
    }
}
