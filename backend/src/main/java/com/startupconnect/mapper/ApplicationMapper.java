package com.startupconnect.mapper;
import com.startupconnect.dto.ApplicationResponse;
import com.startupconnect.entity.Application;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring", uses = {UserMapper.class})
public interface ApplicationMapper {
    @Mapping(source = "project.id", target = "projectId")
    @Mapping(source = "applicant", target = "applicant")
    ApplicationResponse applicationToApplicationResponse(Application application);
}
