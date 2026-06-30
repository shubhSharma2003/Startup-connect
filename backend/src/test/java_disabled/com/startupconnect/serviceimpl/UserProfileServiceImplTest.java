package com.startupconnect.serviceimpl;

import com.startupconnect.dto.user.FileUploadResponse;
import com.startupconnect.dto.user.SkillRequest;
import com.startupconnect.dto.user.SkillResponse;
import com.startupconnect.dto.user.UpdateProfileRequest;
import com.startupconnect.dto.user.UserProfileResponse;
import com.startupconnect.entity.Skill;
import com.startupconnect.entity.User;
import com.startupconnect.exception.BadRequestException;
import com.startupconnect.mapper.UserMapper;
import com.startupconnect.repository.SkillRepository;
import com.startupconnect.repository.UserRepository;
import com.startupconnect.service.FileStorageService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockMultipartFile;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.HashSet;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class UserProfileServiceImplTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private SkillRepository skillRepository;

    @Mock
    private FileStorageService fileStorageService;

    private UserProfileServiceImpl userProfileService;

    @BeforeEach
    void setUp() {
        userProfileService = new UserProfileServiceImpl(
                userRepository,
                skillRepository,
                new UserMapper(),
                fileStorageService
        );
    }

    @Test
    void updateProfilePersistsProfileFields() {
        User user = baseUser();
        UpdateProfileRequest request = new UpdateProfileRequest(
                "Shubh Sharma",
                "Building useful things",
                "Startup College",
                "Computer Science",
                2027,
                "https://github.com/shubh",
                "https://linkedin.com/in/shubh"
        );

        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(userRepository.save(any(User.class))).thenAnswer(invocation -> invocation.getArgument(0));

        UserProfileResponse response = userProfileService.updateProfile(1L, request);

        assertThat(response.name()).isEqualTo("Shubh Sharma");
        assertThat(response.bio()).isEqualTo("Building useful things");
        assertThat(response.githubUrl()).isEqualTo("https://github.com/shubh");
        verify(userRepository).save(user);
    }

    @Test
    void addSkillCreatesSkillWhenMissing() {
        User user = baseUser();
        Skill savedSkill = Skill.builder().id(5L).name("Java").build();

        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(skillRepository.findByNameIgnoreCase("Java")).thenReturn(Optional.empty());
        when(skillRepository.save(any(Skill.class))).thenReturn(savedSkill);
        when(userRepository.save(any(User.class))).thenAnswer(invocation -> invocation.getArgument(0));

        SkillResponse response = userProfileService.addSkill(1L, new SkillRequest("java"));

        assertThat(response.id()).isEqualTo(5L);
        assertThat(response.name()).isEqualTo("Java");
        assertThat(user.getSkills()).extracting(Skill::getName).contains("Java");
    }

    @Test
    void addSkillRejectsDuplicateSkill() {
        User user = baseUser();
        user.getSkills().add(Skill.builder().id(5L).name("Java").build());

        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(skillRepository.findByNameIgnoreCase("Java")).thenReturn(Optional.of(Skill.builder().id(5L).name("Java").build()));

        assertThatThrownBy(() -> userProfileService.addSkill(1L, new SkillRequest("java")))
                .isInstanceOf(BadRequestException.class)
                .hasMessage("Skill is already added to profile");
    }

    @Test
    void uploadProfilePictureStoresUrlOnUser() {
        User user = baseUser();
        MockMultipartFile file = new MockMultipartFile("file", "avatar.png", "image/png", "image".getBytes());

        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(fileStorageService.uploadProfileImage(1L, file)).thenReturn("https://cdn.example/avatar.png");

        FileUploadResponse response = userProfileService.uploadProfilePicture(1L, file);

        assertThat(response.fileUrl()).isEqualTo("https://cdn.example/avatar.png");
        assertThat(user.getProfileImage()).isEqualTo("https://cdn.example/avatar.png");
        verify(userRepository).save(user);
    }

    private User baseUser() {
        return User.builder()
                .id(1L)
                .name("Shubh")
                .email("shubh@example.com")
                .password("encoded")
                .rating(BigDecimal.ZERO)
                .emailVerified(true)
                .enabled(true)
                .createdAt(Instant.now())
                .updatedAt(Instant.now())
                .skills(new HashSet<>())
                .build();
    }
}
