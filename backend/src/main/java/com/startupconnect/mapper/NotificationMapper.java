package com.startupconnect.mapper;
import com.startupconnect.dto.NotificationResponse;
import com.startupconnect.entity.Notification;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface NotificationMapper {
    @Mapping(source = "read", target = "read")
    NotificationResponse notificationToNotificationResponse(Notification notification);
}
