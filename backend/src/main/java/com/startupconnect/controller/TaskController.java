package com.startupconnect.controller;

import com.startupconnect.dto.ApiResponse;
import com.startupconnect.dto.TaskAssignmentRequest;
import com.startupconnect.dto.TaskRequest;
import com.startupconnect.dto.TaskResponse;
import com.startupconnect.entity.TaskPriority;
import com.startupconnect.entity.TaskStatus;
import com.startupconnect.service.TaskService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
@Tag(name = "Task Management", description = "APIs for managing project tasks")
public class TaskController {

    private final TaskService taskService;

    @Operation(summary = "Create a task in a project")
    @PostMapping("/projects/{projectId}/tasks")
    public ResponseEntity<ApiResponse<TaskResponse>> createTask(
            @PathVariable Long projectId,
            @Valid @RequestBody TaskRequest request,
            Authentication authentication) {
        TaskResponse response = taskService.createTask(projectId, request, authentication.getName());
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success("Task created successfully", response));
    }

    @Operation(summary = "Update a task")
    @PutMapping("/tasks/{taskId}")
    public ResponseEntity<ApiResponse<TaskResponse>> updateTask(
            @PathVariable Long taskId,
            @Valid @RequestBody TaskRequest request,
            Authentication authentication) {
        TaskResponse response = taskService.updateTask(taskId, request, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Task updated successfully", response));
    }

    @Operation(summary = "Assign a task")
    @PutMapping("/tasks/{taskId}/assignee")
    public ResponseEntity<ApiResponse<TaskResponse>> assignTask(
            @PathVariable Long taskId,
            @Valid @RequestBody TaskAssignmentRequest request,
            Authentication authentication) {
        TaskResponse response = taskService.assignTask(taskId, request, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Task assigned successfully", response));
    }

    @Operation(summary = "Delete a task")
    @DeleteMapping("/tasks/{taskId}")
    public ResponseEntity<ApiResponse<Void>> deleteTask(
            @PathVariable Long taskId,
            Authentication authentication) {
        taskService.deleteTask(taskId, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Task deleted successfully", null));
    }

    @Operation(summary = "Get tasks for a project with optional filters")
    @GetMapping("/projects/{projectId}/tasks")
    public ResponseEntity<ApiResponse<List<TaskResponse>>> getTasks(
            @PathVariable Long projectId,
            @RequestParam(required = false) TaskStatus status,
            @RequestParam(required = false) TaskPriority priority,
            @RequestParam(required = false) Long assigneeId,
            Authentication authentication) {
        List<TaskResponse> response = taskService.getTasks(projectId, status, priority, assigneeId, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Tasks retrieved successfully", response));
    }
}
