package com.startupconnect.service.impl;

import com.startupconnect.dto.TeamMemberRequest;
import com.startupconnect.dto.TeamMemberResponse;
import com.startupconnect.dto.TeamMemberRoleUpdateRequest;
import com.startupconnect.entity.Project;
import com.startupconnect.entity.TeamMember;
import com.startupconnect.entity.TeamRole;
import com.startupconnect.entity.User;
import com.startupconnect.exception.BadRequestException;
import com.startupconnect.exception.ResourceNotFoundException;
import com.startupconnect.exception.UnauthorizedException;
import com.startupconnect.mapper.TeamMemberMapper;
import com.startupconnect.repository.ProjectRepository;
import com.startupconnect.repository.TeamMemberRepository;
import com.startupconnect.repository.UserRepository;
import com.startupconnect.service.TeamService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class TeamServiceImpl implements TeamService {

    private final TeamMemberRepository teamMemberRepository;
    private final ProjectRepository projectRepository;
    private final UserRepository userRepository;
    private final TeamMemberMapper teamMemberMapper;

    @Override
    @Transactional
    public TeamMemberResponse addMember(Long projectId, TeamMemberRequest request, String currentUserEmail) {
        Project project = getProjectEntityById(projectId);
        checkAdminPermission(project, currentUserEmail);

        if (project.getOwner().getId().equals(request.getUserId())) {
            throw new BadRequestException("Cannot add the project owner as a regular team member");
        }

        User userToAdd = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        Optional<TeamMember> existingMember = teamMemberRepository.findByProjectIdAndUserId(projectId, request.getUserId());
        if (existingMember.isPresent()) {
            throw new BadRequestException("User is already a member of this team");
        }

        TeamMember teamMember = TeamMember.builder()
                .project(project)
                .user(userToAdd)
                .role(request.getRole())
                .build();

        TeamMember savedMember = teamMemberRepository.save(teamMember);
        return teamMemberMapper.teamMemberToTeamMemberResponse(savedMember);
    }

    @Override
    @Transactional
    public void removeMember(Long projectId, Long userId, String currentUserEmail) {
        Project project = getProjectEntityById(projectId);
        checkAdminPermission(project, currentUserEmail);

        if (project.getOwner().getId().equals(userId)) {
            throw new BadRequestException("Cannot remove the project owner from the team");
        }

        TeamMember teamMember = teamMemberRepository.findByProjectIdAndUserId(projectId, userId)
                .orElseThrow(() -> new ResourceNotFoundException("User is not a member of this team"));

        teamMemberRepository.delete(teamMember);
    }

    @Override
    @Transactional
    public TeamMemberResponse changeRole(Long projectId, Long userId, TeamMemberRoleUpdateRequest request, String currentUserEmail) {
        Project project = getProjectEntityById(projectId);
        checkAdminPermission(project, currentUserEmail);

        if (project.getOwner().getId().equals(userId)) {
            throw new BadRequestException("Cannot change the role of the project owner");
        }

        TeamMember teamMember = teamMemberRepository.findByProjectIdAndUserId(projectId, userId)
                .orElseThrow(() -> new ResourceNotFoundException("User is not a member of this team"));

        teamMember.setRole(request.getRole());
        return teamMemberMapper.teamMemberToTeamMemberResponse(teamMemberRepository.save(teamMember));
    }

    @Override
    @Transactional(readOnly = true)
    public List<TeamMemberResponse> getTeamMembers(Long projectId) {
        Project project = getProjectEntityById(projectId);

        return teamMemberRepository.findByProjectId(project.getId()).stream()
                .map(teamMemberMapper::teamMemberToTeamMemberResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void internalAddMember(Long projectId, Long userId) {
        Project project = getProjectEntityById(projectId);
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        if (!project.getOwner().getId().equals(userId) && 
            teamMemberRepository.findByProjectIdAndUserId(projectId, userId).isEmpty()) {
            
            TeamMember teamMember = TeamMember.builder()
                    .project(project)
                    .user(user)
                    .role(TeamRole.MEMBER)
                    .build();
            teamMemberRepository.save(teamMember);
        }
    }

    private void checkAdminPermission(Project project, String currentUserEmail) {
        if (project.getOwner().getEmail().equalsIgnoreCase(currentUserEmail)) {
            return; // Owner always has permission
        }

        User currentUser = userRepository.findByEmailIgnoreCase(currentUserEmail)
                .orElseThrow(() -> new UnauthorizedException("User not found"));

        TeamMember currentMember = teamMemberRepository.findByProjectIdAndUserId(project.getId(), currentUser.getId())
                .orElseThrow(() -> new UnauthorizedException("You are not a member of this team"));

        if (currentMember.getRole() != TeamRole.ADMIN) {
            throw new UnauthorizedException("You must be a project owner or team ADMIN to perform this action");
        }
    }

    private Project getProjectEntityById(Long id) {
        return projectRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Project not found with id: " + id));
    }
}
