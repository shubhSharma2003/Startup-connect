package com.startupconnect.mapper;

import com.startupconnect.dto.auth.AuthUserResponse;
import com.startupconnect.entity.Role;
import com.startupconnect.entity.User;
import org.springframework.stereotype.Component;

import java.util.Set;
import java.util.stream.Collectors;

@Component
public class AuthMapper {

    public AuthUserResponse toAuthUserResponse(User user) {
        Set<String> roles = user.getRoles()
                .stream()
                .map(Role::getName)
                .map(Enum::name)
                .collect(Collectors.toSet());

        return new AuthUserResponse(
                user.getId(),
                user.getName(),
                user.getEmail(),
                user.isEmailVerified(),
                user.getRating(),
                roles
        );
    }
}
