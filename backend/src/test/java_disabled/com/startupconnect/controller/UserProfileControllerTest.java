package com.startupconnect.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.startupconnect.dto.user.UpdateProfileRequest;
import com.startupconnect.dto.user.UserProfileResponse;
import com.startupconnect.entity.Role;
import com.startupconnect.entity.RoleName;
import com.startupconnect.entity.User;
import com.startupconnect.exception.GlobalExceptionHandler;
import com.startupconnect.security.UserPrincipal;
import com.startupconnect.service.UserProfileService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Set;

import static org.hamcrest.Matchers.equalTo;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@ExtendWith(MockitoExtension.class)
class UserProfileControllerTest {

    @Mock
    private UserProfileService userProfileService;

    private MockMvc mockMvc;
    private ObjectMapper objectMapper;
    private UserPrincipal principal;

    @BeforeEach
    void setUp() {
        objectMapper = new ObjectMapper();
        objectMapper.findAndRegisterModules();
        principal = principal();
        LocalValidatorFactoryBean validator = new LocalValidatorFactoryBean();
        validator.afterPropertiesSet();
        mockMvc = MockMvcBuilders
                .standaloneSetup(new UserProfileController(userProfileService))
                .setControllerAdvice(new GlobalExceptionHandler())
                .setCustomArgumentResolvers(authenticationPrincipalResolver())
                .setValidator(validator)
                .build();
    }

    @Test
    void getMyProfileReturnsStandardResponse() throws Exception {
        when(userProfileService.getMyProfile(1L)).thenReturn(profileResponse());

        mockMvc.perform(get("/api/v1/users/me"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success", equalTo(true)))
                .andExpect(jsonPath("$.message", equalTo("Profile fetched successfully")))
                .andExpect(jsonPath("$.data.email", equalTo("shubh@example.com")));
    }

    @Test
    void updateProfileValidatesName() throws Exception {
        UpdateProfileRequest request = new UpdateProfileRequest(
                "",
                "Bio",
                null,
                null,
                2027,
                null,
                null
        );

        mockMvc.perform(put("/api/v1/users/me")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.success", equalTo(false)))
                .andExpect(jsonPath("$.message", equalTo("Validation failed")))
                .andExpect(jsonPath("$.data[0].field", equalTo("name")));
    }

    @Test
    void updateProfileReturnsUpdatedProfile() throws Exception {
        UpdateProfileRequest request = new UpdateProfileRequest(
                "Shubh Sharma",
                "Bio",
                "Startup College",
                "Computer Science",
                2027,
                null,
                null
        );
        when(userProfileService.updateProfile(eq(1L), any(UpdateProfileRequest.class))).thenReturn(profileResponse());

        mockMvc.perform(put("/api/v1/users/me")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message", equalTo("Profile updated successfully")))
                .andExpect(jsonPath("$.data.name", equalTo("Shubh")));
    }

    private HandlerMethodArgumentResolver authenticationPrincipalResolver() {
        return new HandlerMethodArgumentResolver() {
            @Override
            public boolean supportsParameter(MethodParameter parameter) {
                return parameter.hasParameterAnnotation(AuthenticationPrincipal.class)
                        && parameter.getParameterType().equals(UserPrincipal.class);
            }

            @Override
            public Object resolveArgument(
                    MethodParameter parameter,
                    ModelAndViewContainer mavContainer,
                    NativeWebRequest webRequest,
                    WebDataBinderFactory binderFactory
            ) {
                return principal;
            }
        };
    }

    private UserPrincipal principal() {
        User user = User.builder()
                .id(1L)
                .name("Shubh")
                .email("shubh@example.com")
                .password("encoded")
                .enabled(true)
                .roles(Set.of(Role.builder().id(1L).name(RoleName.STUDENT).build()))
                .build();
        return UserPrincipal.from(user);
    }

    private UserProfileResponse profileResponse() {
        return new UserProfileResponse(
                1L,
                "Shubh",
                "shubh@example.com",
                "Bio",
                "Startup College",
                "Computer Science",
                2027,
                null,
                null,
                null,
                null,
                BigDecimal.ZERO,
                true,
                Set.of(),
                Instant.now(),
                Instant.now()
        );
    }
}
