package com.startupconnect.controller;

import com.startupconnect.constants.AppConstants;
import com.startupconnect.dto.ApiResponse;
import com.startupconnect.dto.PageResponse;
import com.startupconnect.dto.user.FileUploadResponse;
import com.startupconnect.dto.user.SkillRequest;
import com.startupconnect.dto.user.SkillResponse;
import com.startupconnect.dto.user.UpdateProfileRequest;
import com.startupconnect.dto.user.UserProfileResponse;
import com.startupconnect.dto.user.UserSearchResponse;
import com.startupconnect.security.UserPrincipal;
import com.startupconnect.service.UserProfileService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Positive;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

@Validated
@RestController
@RequiredArgsConstructor
@RequestMapping(AppConstants.API_BASE_PATH + "/users")
public class UserProfileController {

    private final UserProfileService userProfileService;

    @GetMapping("/me")
    public ResponseEntity<ApiResponse<UserProfileResponse>> getMyProfile(
            @AuthenticationPrincipal UserPrincipal principal
    ) {
        return ResponseEntity.ok(ApiResponse.success(
                "Profile fetched successfully",
                userProfileService.getMyProfile(principal.getId())
        ));
    }

    @GetMapping("/{userId}")
    public ResponseEntity<ApiResponse<UserProfileResponse>> getProfileById(
            @PathVariable @Positive(message = "User id must be positive") Long userId
    ) {
        return ResponseEntity.ok(ApiResponse.success(
                "User profile fetched successfully",
                userProfileService.getProfileById(userId)
        ));
    }

    @PutMapping("/me")
    public ResponseEntity<ApiResponse<UserProfileResponse>> updateProfile(
            @AuthenticationPrincipal UserPrincipal principal,
            @Valid @RequestBody UpdateProfileRequest request
    ) {
        return ResponseEntity.ok(ApiResponse.success(
                "Profile updated successfully",
                userProfileService.updateProfile(principal.getId(), request)
        ));
    }

    @PostMapping(value = "/me/profile-picture", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<ApiResponse<FileUploadResponse>> uploadProfilePicture(
            @AuthenticationPrincipal UserPrincipal principal,
            @RequestPart("file") MultipartFile file
    ) {
        return ResponseEntity.ok(ApiResponse.success(
                "Profile picture uploaded successfully",
                userProfileService.uploadProfilePicture(principal.getId(), file)
        ));
    }

    @PostMapping(value = "/me/resume", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<ApiResponse<FileUploadResponse>> uploadResume(
            @AuthenticationPrincipal UserPrincipal principal,
            @RequestPart("file") MultipartFile file
    ) {
        return ResponseEntity.ok(ApiResponse.success(
                "Resume uploaded successfully",
                userProfileService.uploadResume(principal.getId(), file)
        ));
    }

    @PostMapping("/me/skills")
    public ResponseEntity<ApiResponse<SkillResponse>> addSkill(
            @AuthenticationPrincipal UserPrincipal principal,
            @Valid @RequestBody SkillRequest request
    ) {
        return ResponseEntity.ok(ApiResponse.success(
                "Skill added successfully",
                userProfileService.addSkill(principal.getId(), request)
        ));
    }

    @DeleteMapping("/me/skills/{skillId}")
    public ResponseEntity<ApiResponse<Map<String, Boolean>>> removeSkill(
            @AuthenticationPrincipal UserPrincipal principal,
            @PathVariable @Positive(message = "Skill id must be positive") Long skillId
    ) {
        userProfileService.removeSkill(principal.getId(), skillId);
        return ResponseEntity.ok(ApiResponse.success("Skill removed successfully", Map.of("removed", true)));
    }

    @GetMapping
    public ResponseEntity<ApiResponse<PageResponse<UserSearchResponse>>> searchUsers(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String college,
            @RequestParam(required = false) String course,
            @RequestParam(required = false) String skill,
            @PageableDefault(size = 10, sort = "name") Pageable pageable
    ) {
        return ResponseEntity.ok(ApiResponse.success(
                "Users fetched successfully",
                userProfileService.searchUsers(keyword, college, course, skill, pageable)
        ));
    }
}
