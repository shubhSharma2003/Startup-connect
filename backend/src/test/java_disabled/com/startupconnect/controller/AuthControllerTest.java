package com.startupconnect.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.startupconnect.dto.auth.AuthResponse;
import com.startupconnect.dto.auth.AuthUserResponse;
import com.startupconnect.dto.auth.RegisterRequest;
import com.startupconnect.exception.GlobalExceptionHandler;
import com.startupconnect.service.AuthService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;
import org.springframework.boot.autoconfigure.security.servlet.SecurityFilterAutoConfiguration;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import com.startupconnect.security.JwtAuthenticationFilter;
import org.springframework.test.web.servlet.MockMvc;

import java.math.BigDecimal;
import java.util.Set;

import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.notNullValue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(
        controllers = AuthController.class,
        excludeAutoConfiguration = {SecurityAutoConfiguration.class, SecurityFilterAutoConfiguration.class}
)
@AutoConfigureMockMvc(addFilters = false)
@Import(GlobalExceptionHandler.class)
class AuthControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private AuthService authService;

    @MockBean
    private JwtAuthenticationFilter jwtAuthenticationFilter;

    @Test
    void registerReturnsCreatedResponse() throws Exception {
        RegisterRequest request = new RegisterRequest(
                "Shubh",
                "shubh@example.com",
                "Strong@123",
                "Startup College",
                "Computer Science",
                2027
        );
        AuthResponse response = new AuthResponse(
                "access-token",
                "refresh-token",
                "Bearer",
                900000,
                new AuthUserResponse(1L, "Shubh", "shubh@example.com", false, BigDecimal.ZERO, Set.of("STUDENT"))
        );

        when(authService.register(any(RegisterRequest.class))).thenReturn(response);

        mockMvc.perform(post("/api/v1/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.success", equalTo(true)))
                .andExpect(jsonPath("$.message", equalTo("User registered successfully")))
                .andExpect(jsonPath("$.data.accessToken", equalTo("access-token")))
                .andExpect(jsonPath("$.data.user.email", equalTo("shubh@example.com")))
                .andExpect(jsonPath("$.timestamp", notNullValue()));
    }

    @Test
    void registerValidatesPasswordStrength() throws Exception {
        RegisterRequest request = new RegisterRequest(
                "Shubh",
                "shubh@example.com",
                "weakpass",
                null,
                null,
                null
        );

        mockMvc.perform(post("/api/v1/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.success", equalTo(false)))
                .andExpect(jsonPath("$.message", equalTo("Validation failed")))
                .andExpect(jsonPath("$.data[0].field", equalTo("password")));
    }
}
