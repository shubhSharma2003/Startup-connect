package com.startupconnect.controller;

import com.startupconnect.dto.ApiResponse;
import com.startupconnect.dto.TeamMemberRequest;
import com.startupconnect.dto.TeamMemberResponse;
import com.startupconnect.dto.TeamMemberRoleUpdateRequest;
import com.startupconnect.service.TeamService;
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
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/projects/{projectId}/team")
@RequiredArgsConstructor
@Tag(name = "Team Management", description = "APIs for managing project teams")
public class TeamController {

    private final TeamService teamService;

    @Operation(summary = "Add a member to the team (Owner/Admin only)")
    @PostMapping
    public ResponseEntity<ApiResponse<TeamMemberResponse>> addMember(
            @PathVariable Long projectId,
            @Valid @RequestBody TeamMemberRequest request,
            Authentication authentication) {
        TeamMemberResponse response = teamService.addMember(projectId, request, authentication.getName());
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success("Team member added successfully", response));
    }

    @Operation(summary = "Remove a member from the team (Owner/Admin only)")
    @DeleteMapping("/{userId}")
    public ResponseEntity<ApiResponse<Void>> removeMember(
            @PathVariable Long projectId,
            @PathVariable Long userId,
            Authentication authentication) {
        teamService.removeMember(projectId, userId, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Team member removed successfully", null));
    }

    @Operation(summary = "Change the role of a team member (Owner/Admin only)")
    @PutMapping("/{userId}/role")
    public ResponseEntity<ApiResponse<TeamMemberResponse>> changeRole(
            @PathVariable Long projectId,
            @PathVariable Long userId,
            @Valid @RequestBody TeamMemberRoleUpdateRequest request,
            Authentication authentication) {
        TeamMemberResponse response = teamService.changeRole(projectId, userId, request, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Team member role updated successfully", response));
    }

    @Operation(summary = "View all team members of a project")
    @GetMapping
    public ResponseEntity<ApiResponse<List<TeamMemberResponse>>> getTeamMembers(
            @PathVariable Long projectId) {
        List<TeamMemberResponse> response = teamService.getTeamMembers(projectId);
        return ResponseEntity.ok(ApiResponse.success("Team members retrieved successfully", response));
    }
}
