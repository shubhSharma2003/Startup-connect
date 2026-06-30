package com.startupconnect.security;

import com.startupconnect.entity.Role;
import com.startupconnect.entity.RoleName;
import com.startupconnect.entity.User;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;

class JwtServiceTest {

    @Test
    void generateAndValidateAccessToken() {
        JwtService jwtService = new JwtService("test-development-secret-key-that-is-long-enough-for-hmac-sha256", 900000);
        User user = User.builder()
                .id(1L)
                .name("Shubh")
                .email("shubh@example.com")
                .password("encoded")
                .rating(BigDecimal.ZERO)
                .enabled(true)
                .roles(Set.of(Role.builder().id(1L).name(RoleName.STUDENT).build()))
                .build();
        UserPrincipal principal = UserPrincipal.from(user);

        String token = jwtService.generateAccessToken(principal);

        assertThat(token).isNotBlank();
        assertThat(jwtService.extractUsername(token)).isEqualTo("shubh@example.com");
        assertThat(jwtService.isTokenValid(token, principal)).isTrue();
    }
}
