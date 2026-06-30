package com.startupconnect.dto;

import com.startupconnect.entity.ProjectStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProjectSearchCriteria {
    private String keyword;
    private ProjectStatus status;
    private Set<Long> skillIds;
    private Long ownerId;
}
