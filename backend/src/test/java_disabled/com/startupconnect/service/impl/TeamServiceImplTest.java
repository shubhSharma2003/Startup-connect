package com.startupconnect.service.impl;

import com.startupconnect.dto.TeamMemberRequest;
import com.startupconnect.dto.TeamMemberResponse;
import com.startupconnect.dto.TeamMemberRoleUpdateRequest;
import com.startupconnect.entity.Project;
import com.startupconnect.entity.TeamMember;
import com.startupconnect.entity.TeamRole;
import com.startupconnect.entity.User;
import com.startupconnect.exception.BadRequestException;
import com.startupconnect.exception.UnauthorizedException;
import com.startupconnect.mapper.TeamMemberMapper;
import com.startupconnect.repository.ProjectRepository;
import com.startupconnect.repository.TeamMemberRepository;
import com.startupconnect.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class TeamServiceImplTest {

    @Mock
    private TeamMemberRepository teamMemberRepository;
    @Mock
    private ProjectRepository projectRepository;
    @Mock
    private UserRepository userRepository;
    @Mock
    private TeamMemberMapper teamMemberMapper;

    @InjectMocks
    private TeamServiceImpl teamService;

    private User owner;
    private User adminUser;
    private User regularUser;
    private Project project;
    private TeamMember adminMember;

    @BeforeEach
    void setUp() {
        owner = User.builder().id(1L).email("owner@example.com").build();
        adminUser = User.builder().id(2L).email("admin@example.com").build();
        regularUser = User.builder().id(3L).email("user@example.com").build();

        project = Project.builder().id(1L).owner(owner).build();

        adminMember = TeamMember.builder().id(1L).project(project).user(adminUser).role(TeamRole.ADMIN).build();
    }

    @Test
    void testAddMemberAsOwnerSuccess() {
        when(projectRepository.findById(1L)).thenReturn(Optional.of(project));
        when(userRepository.findById(3L)).thenReturn(Optional.of(regularUser));
        when(teamMemberRepository.findByProjectIdAndUserId(1L, 3L)).thenReturn(Optional.empty());
        when(teamMemberRepository.save(any(TeamMember.class))).thenReturn(new TeamMember());
        when(teamMemberMapper.teamMemberToTeamMemberResponse(any(TeamMember.class))).thenReturn(new TeamMemberResponse());

        TeamMemberRequest request = TeamMemberRequest.builder().userId(3L).role(TeamRole.MEMBER).build();
        TeamMemberResponse response = teamService.addMember(1L, request, "owner@example.com");

        assertNotNull(response);
        verify(teamMemberRepository).save(any(TeamMember.class));
    }

    @Test
    void testAddMemberAsAdminSuccess() {
        when(projectRepository.findById(1L)).thenReturn(Optional.of(project));
        when(userRepository.findByEmailIgnoreCase("admin@example.com")).thenReturn(Optional.of(adminUser));
        when(teamMemberRepository.findByProjectIdAndUserId(1L, 2L)).thenReturn(Optional.of(adminMember));
        when(userRepository.findById(3L)).thenReturn(Optional.of(regularUser));
        when(teamMemberRepository.findByProjectIdAndUserId(1L, 3L)).thenReturn(Optional.empty());
        when(teamMemberRepository.save(any(TeamMember.class))).thenReturn(new TeamMember());
        when(teamMemberMapper.teamMemberToTeamMemberResponse(any(TeamMember.class))).thenReturn(new TeamMemberResponse());

        TeamMemberRequest request = TeamMemberRequest.builder().userId(3L).role(TeamRole.MEMBER).build();
        TeamMemberResponse response = teamService.addMember(1L, request, "admin@example.com");

        assertNotNull(response);
        verify(teamMemberRepository).save(any(TeamMember.class));
    }

    @Test
    void testAddMemberUnauthorized() {
        User outsider = User.builder().id(4L).email("outsider@example.com").build();
        when(projectRepository.findById(1L)).thenReturn(Optional.of(project));
        when(userRepository.findByEmailIgnoreCase("outsider@example.com")).thenReturn(Optional.of(outsider));
        when(teamMemberRepository.findByProjectIdAndUserId(1L, 4L)).thenReturn(Optional.empty());

        TeamMemberRequest request = TeamMemberRequest.builder().userId(3L).role(TeamRole.MEMBER).build();
        
        assertThrows(UnauthorizedException.class, () -> {
            teamService.addMember(1L, request, "outsider@example.com");
        });
    }
}
