package com.startupconnect.dto.user;

import java.math.BigDecimal;
import java.util.Set;

public record UserSearchResponse(
        Long id,
        String name,
        String email,
        String college,
        String course,
        Integer graduationYear,
        String profileImage,
        BigDecimal rating,
        Set<SkillResponse> skills
) {
}
