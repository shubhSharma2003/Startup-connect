package com.startupconnect.service.impl;

import com.startupconnect.dto.PageResponse;
import com.startupconnect.dto.ProjectRequest;
import com.startupconnect.dto.ProjectResponse;
import com.startupconnect.dto.ProjectSearchCriteria;
import com.startupconnect.entity.Project;
import com.startupconnect.entity.ProjectStatus;
import com.startupconnect.entity.User;
import com.startupconnect.exception.ResourceNotFoundException;
import com.startupconnect.exception.UnauthorizedException;
import com.startupconnect.mapper.ProjectMapper;
import com.startupconnect.repository.ProjectRepository;
import com.startupconnect.repository.UserRepository;
import com.startupconnect.service.ProjectService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ProjectServiceImpl implements ProjectService {
    
    private final ProjectRepository projectRepository;
    private final UserRepository userRepository;
    private final ProjectMapper projectMapper;

    @Override
    @Transactional
    public ProjectResponse createProject(ProjectRequest request, String currentUserEmail) {
        User user = userRepository.findByEmailIgnoreCase(currentUserEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        
        Project project = Project.builder()
                .title(request.title())
                .description(request.description())
                .maxTeamSize(request.maxTeamSize())
                .owner(user)
                .status(ProjectStatus.OPEN)
                .build();
                
        Project saved = projectRepository.save(project);
        return projectMapper.projectToProjectResponse(saved);
    }

    @Override
    @Transactional
    public ProjectResponse updateProject(Long id, ProjectRequest request, String currentUserEmail) {
        Project project = projectRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Project not found"));
                
        if (!project.getOwner().getEmail().equalsIgnoreCase(currentUserEmail)) {
            throw new UnauthorizedException("Only the project owner can update this project");
        }
        
        project.setTitle(request.title());
        project.setDescription(request.description());
        project.setMaxTeamSize(request.maxTeamSize());
        
        Project saved = projectRepository.save(project);
        return projectMapper.projectToProjectResponse(saved);
    }

    @Override
    @Transactional
    public void deleteProject(Long id, String currentUserEmail) {
        Project project = projectRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Project not found"));
                
        if (!project.getOwner().getEmail().equalsIgnoreCase(currentUserEmail)) {
            throw new UnauthorizedException("Only the project owner can delete this project");
        }
        
        projectRepository.delete(project);
    }

    @Override
    public ProjectResponse getProjectById(Long id) {
        Project project = projectRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Project not found"));
        return projectMapper.projectToProjectResponse(project);
    }

    @Override
    public PageResponse<ProjectResponse> searchProjects(ProjectSearchCriteria criteria, int page, int size, String sortBy, String sortDir) {
        Sort sort = sortDir.equalsIgnoreCase(Sort.Direction.ASC.name()) ? Sort.by(sortBy).ascending() : Sort.by(sortBy).descending();
        PageRequest pageRequest = PageRequest.of(page, size, sort);
        Page<ProjectResponse> projectPage = projectRepository.findAll(pageRequest).map(projectMapper::projectToProjectResponse);
        return PageResponse.from(projectPage);
    }
}
