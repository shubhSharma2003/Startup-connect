package com.startupconnect.service;
import com.startupconnect.dto.TeamMemberRequest;
import com.startupconnect.dto.TeamMemberResponse;
import com.startupconnect.dto.TeamMemberRoleUpdateRequest;
import java.util.List;

public interface TeamService {
    TeamMemberResponse addMember(Long projectId, TeamMemberRequest request, String authenticatedUserEmail);
    void removeMember(Long projectId, Long userId, String authenticatedUserEmail);
    TeamMemberResponse changeRole(Long projectId, Long userId, TeamMemberRoleUpdateRequest request, String authenticatedUserEmail);
    List<TeamMemberResponse> getTeamMembers(Long projectId);
    void internalAddMember(Long projectId, Long userId);
}
