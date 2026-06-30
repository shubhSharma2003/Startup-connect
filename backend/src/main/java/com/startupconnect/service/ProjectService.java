package com.startupconnect.service;

import com.startupconnect.dto.PageResponse;
import com.startupconnect.dto.ProjectRequest;
import com.startupconnect.dto.ProjectResponse;
import com.startupconnect.dto.ProjectSearchCriteria;

public interface ProjectService {
    ProjectResponse createProject(ProjectRequest request, String currentUserEmail);
    ProjectResponse updateProject(Long id, ProjectRequest request, String currentUserEmail);
    void deleteProject(Long id, String currentUserEmail);
    ProjectResponse getProjectById(Long id);
    PageResponse<ProjectResponse> searchProjects(ProjectSearchCriteria criteria, int page, int size, String sortBy, String sortDir);
}
