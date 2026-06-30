package com.startupconnect.controller;

import com.startupconnect.dto.ApiResponse;
import com.startupconnect.dto.ApplicationRequest;
import com.startupconnect.dto.ApplicationResponse;
import com.startupconnect.service.ApplicationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
@Tag(name = "Application System", description = "APIs for managing project applications")
public class ApplicationController {

    private final ApplicationService applicationService;

    @Operation(summary = "Apply to a project")
    @PostMapping("/projects/{projectId}/applications")
    public ResponseEntity<ApiResponse<ApplicationResponse>> applyToProject(
            @PathVariable Long projectId,
            @Valid @RequestBody ApplicationRequest request,
            Authentication authentication) {
        ApplicationResponse response = applicationService.applyToProject(projectId, request, authentication.getName());
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success("Application submitted successfully", response));
    }

    @Operation(summary = "Withdraw an application")
    @PutMapping("/applications/{id}/withdraw")
    public ResponseEntity<ApiResponse<ApplicationResponse>> withdrawApplication(
            @PathVariable Long id,
            Authentication authentication) {
        ApplicationResponse response = applicationService.withdrawApplication(id, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Application withdrawn successfully", response));
    }

    @Operation(summary = "Accept an application")
    @PutMapping("/applications/{id}/accept")
    public ResponseEntity<ApiResponse<ApplicationResponse>> acceptApplication(
            @PathVariable Long id,
            Authentication authentication) {
        ApplicationResponse response = applicationService.acceptApplication(id, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Application accepted successfully", response));
    }

    @Operation(summary = "Reject an application")
    @PutMapping("/applications/{id}/reject")
    public ResponseEntity<ApiResponse<ApplicationResponse>> rejectApplication(
            @PathVariable Long id,
            Authentication authentication) {
        ApplicationResponse response = applicationService.rejectApplication(id, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Application rejected successfully", response));
    }

    @Operation(summary = "View applications for a project (Owner only)")
    @GetMapping("/projects/{projectId}/applications")
    public ResponseEntity<ApiResponse<List<ApplicationResponse>>> getApplicationsByProject(
            @PathVariable Long projectId,
            Authentication authentication) {
        List<ApplicationResponse> response = applicationService.getApplicationsByProject(projectId, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Applications retrieved successfully", response));
    }

    @Operation(summary = "View my applications")
    @GetMapping("/applications/my-applications")
    public ResponseEntity<ApiResponse<List<ApplicationResponse>>> getMyApplications(
            Authentication authentication) {
        List<ApplicationResponse> response = applicationService.getMyApplications(authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Your applications retrieved successfully", response));
    }
}
