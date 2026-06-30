package com.startupconnect.mapper;

import com.startupconnect.dto.TeamMemberResponse;
import com.startupconnect.entity.TeamMember;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper(componentModel = "spring")
public interface TeamMemberMapper {

    TeamMemberMapper INSTANCE = Mappers.getMapper(TeamMemberMapper.class);

    @Mapping(target = "projectId", source = "project.id")
    @Mapping(target = "projectTitle", source = "project.title")
    @Mapping(target = "user.id", source = "user.id")
    @Mapping(target = "user.name", source = "user.name")
    @Mapping(target = "user.email", source = "user.email")
    @Mapping(target = "user.profileImage", source = "user.profileImage")
    TeamMemberResponse teamMemberToTeamMemberResponse(TeamMember teamMember);
}
