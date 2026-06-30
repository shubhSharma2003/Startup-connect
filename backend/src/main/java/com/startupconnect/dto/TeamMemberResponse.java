package com.startupconnect.dto;

import com.startupconnect.entity.TeamRole;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TeamMemberResponse {
    private Long id;
    private Long projectId;
    private String projectTitle;
    private UserSummaryDto user;
    private TeamRole role;
    private LocalDateTime joinedAt;
}
