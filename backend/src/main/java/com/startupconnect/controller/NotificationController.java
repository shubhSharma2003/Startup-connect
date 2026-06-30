package com.startupconnect.controller;

import com.startupconnect.dto.ApiResponse;
import com.startupconnect.dto.NotificationCountResponse;
import com.startupconnect.dto.NotificationResponse;
import com.startupconnect.service.NotificationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/notifications")
@RequiredArgsConstructor
@Tag(name = "Notification Management", description = "APIs for user notifications")
public class NotificationController {

    private final NotificationService notificationService;

    @Operation(summary = "Get paginated user notifications")
    @GetMapping
    public ResponseEntity<ApiResponse<Page<NotificationResponse>>> getUserNotifications(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            Authentication authentication) {
        Page<NotificationResponse> response = notificationService.getUserNotifications(authentication.getName(), page, size);
        return ResponseEntity.ok(ApiResponse.success("Notifications retrieved successfully", response));
    }

    @Operation(summary = "Get unread notifications count")
    @GetMapping("/unread-count")
    public ResponseEntity<ApiResponse<NotificationCountResponse>> getUnreadCount(
            Authentication authentication) {
        NotificationCountResponse response = notificationService.getUnreadCount(authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Unread count retrieved successfully", response));
    }

    @Operation(summary = "Mark a notification as read")
    @PutMapping("/{id}/read")
    public ResponseEntity<ApiResponse<Void>> markAsRead(
            @PathVariable Long id,
            Authentication authentication) {
        notificationService.markAsRead(id, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Notification marked as read", null));
    }

    @Operation(summary = "Mark all user notifications as read")
    @PutMapping("/read-all")
    public ResponseEntity<ApiResponse<Void>> markAllAsRead(
            Authentication authentication) {
        notificationService.markAllAsRead(authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("All notifications marked as read", null));
    }

    @Operation(summary = "Delete a notification")
    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteNotification(
            @PathVariable Long id,
            Authentication authentication) {
        notificationService.deleteNotification(id, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Notification deleted successfully", null));
    }
}
