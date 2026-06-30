package com.startupconnect.mapper;

import com.startupconnect.dto.TaskResponse;
import com.startupconnect.entity.Task;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper(componentModel = "spring")
public interface TaskMapper {

    TaskMapper INSTANCE = Mappers.getMapper(TaskMapper.class);

    @Mapping(target = "projectId", source = "project.id")
    @Mapping(target = "assignee.id", source = "assignee.id")
    @Mapping(target = "assignee.name", source = "assignee.name")
    @Mapping(target = "assignee.email", source = "assignee.email")
    @Mapping(target = "assignee.profileImage", source = "assignee.profileImage")
    TaskResponse taskToTaskResponse(Task task);
}
