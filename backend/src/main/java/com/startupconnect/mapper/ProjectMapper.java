package com.startupconnect.mapper;

import com.startupconnect.dto.ProjectResponse;
import com.startupconnect.entity.Project;
import com.startupconnect.entity.Skill;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import java.util.Set;
import java.util.stream.Collectors;

@Mapper(componentModel = "spring", uses = {UserMapper.class})
public interface ProjectMapper {
    @Mapping(target = "owner", source = "owner")
    @Mapping(target = "requiredSkills", source = "requiredSkills")
    ProjectResponse projectToProjectResponse(Project project);
    
    default Set<String> mapSkills(Set<Skill> skills) {
        if (skills == null) {
            return null;
        }
        return skills.stream().map(Skill::getName).collect(Collectors.toSet());
    }
}
