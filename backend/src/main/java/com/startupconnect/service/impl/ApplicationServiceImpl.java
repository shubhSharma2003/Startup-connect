package com.startupconnect.service.impl;

import com.startupconnect.dto.ApplicationRequest;
import com.startupconnect.dto.ApplicationResponse;
import com.startupconnect.entity.Application;
import com.startupconnect.entity.ApplicationStatus;
import com.startupconnect.entity.Project;
import com.startupconnect.entity.User;
import com.startupconnect.exception.BadRequestException;
import com.startupconnect.exception.ResourceNotFoundException;
import com.startupconnect.exception.UnauthorizedException;
import com.startupconnect.mapper.ApplicationMapper;
import com.startupconnect.repository.ApplicationRepository;
import com.startupconnect.repository.ProjectRepository;
import com.startupconnect.repository.UserRepository;
import com.startupconnect.service.ApplicationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ApplicationServiceImpl implements ApplicationService {
    
    private final ApplicationRepository applicationRepository;
    private final ProjectRepository projectRepository;
    private final UserRepository userRepository;
    private final ApplicationMapper applicationMapper;

    @Override
    @Transactional
    public ApplicationResponse applyToProject(Long projectId, ApplicationRequest request, String applicantEmail) {
        Project project = projectRepository.findById(projectId)
                .orElseThrow(() -> new ResourceNotFoundException("Project not found"));
        User applicant = userRepository.findByEmailIgnoreCase(applicantEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
                
        if (project.getOwner().getId().equals(applicant.getId())) {
            throw new BadRequestException("Owner cannot apply to their own project");
        }
        
        if (applicationRepository.findByProjectIdAndApplicantId(projectId, applicant.getId()).isPresent()) {
            throw new BadRequestException("You have already applied to this project");
        }
        
        Application application = Application.builder()
                .project(project)
                .applicant(applicant)
                .message(request.message())
                .status(ApplicationStatus.PENDING)
                .build();
                
        Application saved = applicationRepository.save(application);
        return applicationMapper.applicationToApplicationResponse(saved);
    }

    @Override
    @Transactional
    public ApplicationResponse withdrawApplication(Long applicationId, String applicantEmail) {
        Application application = applicationRepository.findById(applicationId)
                .orElseThrow(() -> new ResourceNotFoundException("Application not found"));
                
        if (!application.getApplicant().getEmail().equalsIgnoreCase(applicantEmail)) {
            throw new UnauthorizedException("Only the applicant can withdraw this application");
        }
        
        application.setStatus(ApplicationStatus.WITHDRAWN);
        return applicationMapper.applicationToApplicationResponse(applicationRepository.save(application));
    }

    @Override
    @Transactional
    public ApplicationResponse acceptApplication(Long applicationId, String ownerEmail) {
        Application application = applicationRepository.findById(applicationId)
                .orElseThrow(() -> new ResourceNotFoundException("Application not found"));
                
        if (!application.getProject().getOwner().getEmail().equalsIgnoreCase(ownerEmail)) {
            throw new UnauthorizedException("Only the project owner can accept applications");
        }
        
        application.setStatus(ApplicationStatus.ACCEPTED);
        return applicationMapper.applicationToApplicationResponse(applicationRepository.save(application));
    }

    @Override
    @Transactional
    public ApplicationResponse rejectApplication(Long applicationId, String ownerEmail) {
        Application application = applicationRepository.findById(applicationId)
                .orElseThrow(() -> new ResourceNotFoundException("Application not found"));
                
        if (!application.getProject().getOwner().getEmail().equalsIgnoreCase(ownerEmail)) {
            throw new UnauthorizedException("Only the project owner can reject applications");
        }
        
        application.setStatus(ApplicationStatus.REJECTED);
        return applicationMapper.applicationToApplicationResponse(applicationRepository.save(application));
    }

    @Override
    public List<ApplicationResponse> getApplicationsByProject(Long projectId, String ownerEmail) {
        Project project = projectRepository.findById(projectId)
                .orElseThrow(() -> new ResourceNotFoundException("Project not found"));
                
        if (!project.getOwner().getEmail().equalsIgnoreCase(ownerEmail)) {
            throw new UnauthorizedException("Only the project owner can view applications");
        }
        
        return applicationRepository.findByProjectId(projectId).stream()
                .map(applicationMapper::applicationToApplicationResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<ApplicationResponse> getMyApplications(String applicantEmail) {
        User applicant = userRepository.findByEmailIgnoreCase(applicantEmail)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
                
        return applicationRepository.findByApplicantId(applicant.getId()).stream()
                .map(applicationMapper::applicationToApplicationResponse)
                .collect(Collectors.toList());
    }
}
