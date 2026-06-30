package com.startupconnect.controller;

import com.startupconnect.dto.ApiResponse;
import com.startupconnect.dto.PageResponse;
import com.startupconnect.dto.ProjectRequest;
import com.startupconnect.dto.ProjectResponse;
import com.startupconnect.dto.ProjectSearchCriteria;
import com.startupconnect.entity.ProjectStatus;
import com.startupconnect.service.ProjectService;
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

import java.util.Set;

@RestController
@RequestMapping("/api/v1/projects")
@RequiredArgsConstructor
@Tag(name = "Project Management", description = "APIs for managing projects")
public class ProjectController {

    private final ProjectService projectService;

    @Operation(summary = "Create a new project")
    @PostMapping
    public ResponseEntity<ApiResponse<ProjectResponse>> createProject(
            @Valid @RequestBody ProjectRequest request,
            Authentication authentication) {
        ProjectResponse response = projectService.createProject(request, authentication.getName());
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success("Project created successfully", response));
    }

    @Operation(summary = "Update an existing project")
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<ProjectResponse>> updateProject(
            @PathVariable Long id,
            @Valid @RequestBody ProjectRequest request,
            Authentication authentication) {
        ProjectResponse response = projectService.updateProject(id, request, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Project updated successfully", response));
    }

    @Operation(summary = "Delete a project")
    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteProject(
            @PathVariable Long id,
            Authentication authentication) {
        projectService.deleteProject(id, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Project deleted successfully", null));
    }

    @Operation(summary = "Get project details by ID")
    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<ProjectResponse>> getProjectById(
            @PathVariable Long id) {
        ProjectResponse response = projectService.getProjectById(id);
        return ResponseEntity.ok(ApiResponse.success("Project retrieved successfully", response));
    }

    @Operation(summary = "Search and filter projects with pagination")
    @GetMapping
    public ResponseEntity<ApiResponse<PageResponse<ProjectResponse>>> searchProjects(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) ProjectStatus status,
            @RequestParam(required = false) Set<Long> skillIds,
            @RequestParam(required = false) Long ownerId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "createdAt") String sortBy,
            @RequestParam(defaultValue = "desc") String sortDir) {

        ProjectSearchCriteria criteria = ProjectSearchCriteria.builder()
                .keyword(keyword)
                .status(status)
                .skillIds(skillIds)
                .ownerId(ownerId)
                .build();

        PageResponse<ProjectResponse> response = projectService.searchProjects(criteria, page, size, sortBy, sortDir);
        return ResponseEntity.ok(ApiResponse.success("Projects retrieved successfully", response));
    }
}
