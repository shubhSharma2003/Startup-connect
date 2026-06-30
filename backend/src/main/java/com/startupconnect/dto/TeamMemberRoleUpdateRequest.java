package com.startupconnect.dto;

import com.startupconnect.entity.TeamRole;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TeamMemberRoleUpdateRequest {

    @NotNull(message = "Role is required")
    private TeamRole role;
}
