package com.startupconnect.dto.auth;

import java.math.BigDecimal;
import java.util.Set;

public record AuthUserResponse(
        Long id,
        String name,
        String email,
        boolean emailVerified,
        BigDecimal rating,
        Set<String> roles
) {
}
