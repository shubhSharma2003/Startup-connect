package com.startupconnect.config;

import com.startupconnect.entity.Role;
import com.startupconnect.entity.RoleName;
import com.startupconnect.repository.RoleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;

@Configuration
@RequiredArgsConstructor
public class RoleDataInitializer {

    private final RoleRepository roleRepository;

    @Bean
    @Transactional
    CommandLineRunner seedRoles() {
        return args -> Arrays.stream(RoleName.values())
                .filter(roleName -> roleRepository.findByName(roleName).isEmpty())
                .map(roleName -> Role.builder().name(roleName).build())
                .forEach(roleRepository::save);
    }
}
