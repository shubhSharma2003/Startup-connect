package com.startupconnect.serviceimpl;

import com.startupconnect.constants.AppConstants;
import com.startupconnect.dto.PageResponse;
import com.startupconnect.dto.user.FileUploadResponse;
import com.startupconnect.dto.user.SkillRequest;
import com.startupconnect.dto.user.SkillResponse;
import com.startupconnect.dto.user.UpdateProfileRequest;
import com.startupconnect.dto.user.UserProfileResponse;
import com.startupconnect.dto.user.UserSearchResponse;
import com.startupconnect.entity.Skill;
import com.startupconnect.entity.User;
import com.startupconnect.exception.BadRequestException;
import com.startupconnect.exception.ResourceNotFoundException;
import com.startupconnect.mapper.UserMapper;
import com.startupconnect.repository.SkillRepository;
import com.startupconnect.repository.UserRepository;
import com.startupconnect.service.FileStorageService;
import com.startupconnect.service.UserProfileService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.Locale;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserProfileServiceImpl implements UserProfileService {

    private final UserRepository userRepository;
    private final SkillRepository skillRepository;
    private final UserMapper userMapper;
    private final FileStorageService fileStorageService;

    @Override
    @Transactional(readOnly = true)
    public UserProfileResponse getMyProfile(Long authenticatedUserId) {
        return userMapper.toProfileResponse(getUserById(authenticatedUserId));
    }

    @Override
    @Transactional(readOnly = true)
    public UserProfileResponse getProfileById(Long userId) {
        return userMapper.toProfileResponse(getUserById(userId));
    }

    @Override
    @Transactional
    public UserProfileResponse updateProfile(Long authenticatedUserId, UpdateProfileRequest request) {
        User user = getUserById(authenticatedUserId);
        user.setName(request.name().trim());
        user.setBio(trimToNull(request.bio()));
        user.setCollege(trimToNull(request.college()));
        user.setCourse(trimToNull(request.course()));
        user.setGraduationYear(request.graduationYear());
        user.setGithubUrl(trimToNull(request.githubUrl()));
        user.setLinkedinUrl(trimToNull(request.linkedinUrl()));
        User savedUser = userRepository.save(user);
        log.info("Profile updated for user {}", savedUser.getId());
        return userMapper.toProfileResponse(savedUser);
    }

    @Override
    @Transactional
    public FileUploadResponse uploadProfilePicture(Long authenticatedUserId, MultipartFile file) {
        User user = getUserById(authenticatedUserId);
        String fileUrl = fileStorageService.uploadProfileImage(authenticatedUserId, file);
        user.setProfileImage(fileUrl);
        userRepository.save(user);
        return new FileUploadResponse(file.getOriginalFilename(), fileUrl, file.getContentType(), file.getSize());
    }

    @Override
    @Transactional
    public FileUploadResponse uploadResume(Long authenticatedUserId, MultipartFile file) {
        User user = getUserById(authenticatedUserId);
        String fileUrl = fileStorageService.uploadResume(authenticatedUserId, file);
        user.setResumeUrl(fileUrl);
        userRepository.save(user);
        return new FileUploadResponse(file.getOriginalFilename(), fileUrl, file.getContentType(), file.getSize());
    }

    @Override
    @Transactional
    public SkillResponse addSkill(Long authenticatedUserId, SkillRequest request) {
        User user = getUserById(authenticatedUserId);
        String normalizedSkillName = normalizeSkillName(request.name());
        Skill skill = skillRepository.findByNameIgnoreCase(normalizedSkillName)
                .orElseGet(() -> skillRepository.save(Skill.builder().name(normalizedSkillName).build()));

        boolean alreadyAdded = user.getSkills()
                .stream()
                .anyMatch(existingSkill -> existingSkill.getName().equalsIgnoreCase(skill.getName()));
        if (alreadyAdded) {
            throw new BadRequestException("Skill is already added to profile");
        }

        user.getSkills().add(skill);
        userRepository.save(user);
        log.info("Skill {} added to user {}", skill.getName(), user.getId());
        return userMapper.toSkillResponse(skill);
    }

    @Override
    @Transactional
    public void removeSkill(Long authenticatedUserId, Long skillId) {
        User user = getUserById(authenticatedUserId);
        Skill skill = skillRepository.findById(skillId)
                .orElseThrow(() -> new ResourceNotFoundException("Skill not found"));
        boolean removed = user.getSkills().removeIf(existingSkill -> existingSkill.getId().equals(skill.getId()));
        if (!removed) {
            throw new BadRequestException("Skill is not associated with profile");
        }
        userRepository.save(user);
        log.info("Skill {} removed from user {}", skill.getName(), user.getId());
    }

    @Override
    @Transactional(readOnly = true)
    public PageResponse<UserSearchResponse> searchUsers(
            String keyword,
            String college,
            String course,
            String skill,
            Pageable pageable
    ) {
        Pageable boundedPageable = PageRequest.of(
                pageable.getPageNumber(),
                Math.min(pageable.getPageSize(), AppConstants.MAX_PAGE_SIZE),
                pageable.getSort()
        );
        Page<UserSearchResponse> responsePage = userRepository.searchUsers(
                trimToNull(keyword),
                trimToNull(college),
                trimToNull(course),
                trimToNull(skill),
                boundedPageable
        ).map(userMapper::toSearchResponse);
        return PageResponse.from(responsePage);
    }

    private User getUserById(Long userId) {
        return userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    }

    private String normalizeSkillName(String skillName) {
        String trimmed = skillName.trim().replaceAll("\\s+", " ");
        return trimmed.substring(0, 1).toUpperCase(Locale.ROOT) + trimmed.substring(1);
    }

    private String trimToNull(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        return value.trim();
    }
}
