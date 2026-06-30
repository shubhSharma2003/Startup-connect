package com.startupconnect.mapper;
import com.startupconnect.dto.FileResponse;
import com.startupconnect.entity.ProjectFile;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface FileMapper {
    FileResponse projectFileToFileResponse(ProjectFile projectFile);
}
