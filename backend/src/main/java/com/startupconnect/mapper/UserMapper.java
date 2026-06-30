package com.startupconnect.mapper;

import com.startupconnect.dto.user.SkillResponse;
import com.startupconnect.dto.user.UserProfileResponse;
import com.startupconnect.dto.user.UserSearchResponse;
import com.startupconnect.entity.Skill;
import com.startupconnect.entity.User;
import org.springframework.stereotype.Component;

import java.util.Set;
import java.util.stream.Collectors;

@Component
public class UserMapper {

    public UserProfileResponse toProfileResponse(User user) {
        return new UserProfileResponse(
                user.getId(),
                user.getName(),
                user.getEmail(),
                user.getBio(),
                user.getCollege(),
                user.getCourse(),
                user.getGraduationYear(),
                user.getProfileImage(),
                user.getGithubUrl(),
                user.getLinkedinUrl(),
                user.getResumeUrl(),
                user.getRating(),
                user.isEmailVerified(),
                toSkillResponses(user.getSkills()),
                user.getCreatedAt(),
                user.getUpdatedAt()
        );
    }

    public UserSearchResponse toSearchResponse(User user) {
        return new UserSearchResponse(
                user.getId(),
                user.getName(),
                user.getEmail(),
                user.getCollege(),
                user.getCourse(),
                user.getGraduationYear(),
                user.getProfileImage(),
                user.getRating(),
                toSkillResponses(user.getSkills())
        );
    }

    public SkillResponse toSkillResponse(Skill skill) {
        return new SkillResponse(skill.getId(), skill.getName());
    }

    private Set<SkillResponse> toSkillResponses(Set<Skill> skills) {
        return skills.stream()
                .map(this::toSkillResponse)
                .collect(Collectors.toSet());
    }
}
