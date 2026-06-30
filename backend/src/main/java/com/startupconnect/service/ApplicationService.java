package com.startupconnect.service;

import com.startupconnect.dto.ApplicationRequest;
import com.startupconnect.dto.ApplicationResponse;

import java.util.List;

public interface ApplicationService {
    ApplicationResponse applyToProject(Long projectId, ApplicationRequest request, String applicantEmail);
    ApplicationResponse withdrawApplication(Long applicationId, String applicantEmail);
    ApplicationResponse acceptApplication(Long applicationId, String ownerEmail);
    ApplicationResponse rejectApplication(Long applicationId, String ownerEmail);
    List<ApplicationResponse> getApplicationsByProject(Long projectId, String ownerEmail);
    List<ApplicationResponse> getMyApplications(String applicantEmail);
}
