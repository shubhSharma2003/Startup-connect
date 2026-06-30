package com.startupconnect.service;

import com.startupconnect.dto.TaskAssignmentRequest;
import com.startupconnect.dto.TaskRequest;
import com.startupconnect.dto.TaskResponse;
import com.startupconnect.entity.TaskPriority;
import com.startupconnect.entity.TaskStatus;

import java.util.List;

public interface TaskService {
    TaskResponse createTask(Long projectId, TaskRequest request, String currentUserEmail);
    TaskResponse updateTask(Long taskId, TaskRequest request, String currentUserEmail);
    TaskResponse assignTask(Long taskId, TaskAssignmentRequest request, String currentUserEmail);
    void deleteTask(Long taskId, String currentUserEmail);
    List<TaskResponse> getTasks(Long projectId, TaskStatus status, TaskPriority priority, Long assigneeId, String currentUserEmail);
}
