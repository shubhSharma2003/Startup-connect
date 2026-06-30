package com.startupconnect.service;
import com.startupconnect.dto.PageResponse;
import com.startupconnect.dto.user.*;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

public interface UserProfileService {
    UserProfileResponse getMyProfile(Long authenticatedUserId);
    UserProfileResponse getProfileById(Long userId);
    UserProfileResponse updateProfile(Long authenticatedUserId, UpdateProfileRequest request);
    FileUploadResponse uploadProfilePicture(Long authenticatedUserId, MultipartFile file);
    FileUploadResponse uploadResume(Long authenticatedUserId, MultipartFile file);
    SkillResponse addSkill(Long authenticatedUserId, SkillRequest request);
    void removeSkill(Long authenticatedUserId, Long skillId);
    PageResponse<UserSearchResponse> searchUsers(String keyword, String college, String course, String skill, Pageable pageable);
}
