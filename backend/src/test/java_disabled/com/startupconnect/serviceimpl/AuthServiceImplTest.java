package com.startupconnect.serviceimpl;

import com.startupconnect.dto.auth.AuthResponse;
import com.startupconnect.dto.auth.LoginRequest;
import com.startupconnect.dto.auth.RegisterRequest;
import com.startupconnect.entity.Role;
import com.startupconnect.entity.RoleName;
import com.startupconnect.entity.User;
import com.startupconnect.exception.BadRequestException;
import com.startupconnect.mapper.AuthMapper;
import com.startupconnect.repository.EmailVerificationTokenRepository;
import com.startupconnect.repository.PasswordResetTokenRepository;
import com.startupconnect.repository.RefreshTokenRepository;
import com.startupconnect.repository.RoleRepository;
import com.startupconnect.repository.UserRepository;
import com.startupconnect.security.JwtService;
import com.startupconnect.service.EmailService;
import com.startupconnect.util.SecureTokenGenerator;
import com.startupconnect.util.TokenHashUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.util.ReflectionTestUtils;

import java.math.BigDecimal;
import java.util.Optional;
import java.util.Set;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class AuthServiceImplTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private RoleRepository roleRepository;

    @Mock
    private RefreshTokenRepository refreshTokenRepository;

    @Mock
    private EmailVerificationTokenRepository emailVerificationTokenRepository;

    @Mock
    private PasswordResetTokenRepository passwordResetTokenRepository;

    @Mock
    private AuthenticationManager authenticationManager;

    @Mock
    private EmailService emailService;

    private AuthServiceImpl authService;
    private Role studentRole;

    @BeforeEach
    void setUp() {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        JwtService jwtService = new JwtService("test-development-secret-key-that-is-long-enough-for-hmac-sha256", 900000);
        authService = new AuthServiceImpl(
                userRepository,
                roleRepository,
                refreshTokenRepository,
                emailVerificationTokenRepository,
                passwordResetTokenRepository,
                passwordEncoder,
                authenticationManager,
                jwtService,
                new AuthMapper(),
                new SecureTokenGenerator(),
                new TokenHashUtil(),
                emailService
        );
        ReflectionTestUtils.setField(authService, "refreshTokenExpirationMs", 604800000L);
        ReflectionTestUtils.setField(authService, "emailVerificationExpirationMs", 86400000L);
        ReflectionTestUtils.setField(authService, "passwordResetExpirationMs", 900000L);

        studentRole = Role.builder().id(1L).name(RoleName.STUDENT).build();
    }

    @Test
    void registerCreatesUserAndTokens() {
        RegisterRequest request = new RegisterRequest(
                "Shubh",
                "SHUBH@example.com",
                "Strong@123",
                "Startup College",
                "Computer Science",
                2027
        );
        User savedUser = User.builder()
                .id(10L)
                .name("Shubh")
                .email("shubh@example.com")
                .password("encoded")
                .rating(BigDecimal.ZERO)
                .emailVerified(false)
                .enabled(true)
                .roles(Set.of(studentRole))
                .build();

        when(userRepository.existsByEmailIgnoreCase("shubh@example.com")).thenReturn(false);
        when(roleRepository.findByName(RoleName.STUDENT)).thenReturn(Optional.of(studentRole));
        when(userRepository.save(any(User.class))).thenReturn(savedUser);

        AuthResponse response = authService.register(request);

        assertThat(response.accessToken()).isNotBlank();
        assertThat(response.refreshToken()).isNotBlank();
        assertThat(response.user().email()).isEqualTo("shubh@example.com");
        verify(emailVerificationTokenRepository).save(any());
        verify(refreshTokenRepository).save(any());
        verify(emailService).sendEmailVerification(any(User.class), any(String.class));
    }

    @Test
    void registerRejectsDuplicateEmail() {
        RegisterRequest request = new RegisterRequest(
                "Shubh",
                "shubh@example.com",
                "Strong@123",
                null,
                null,
                null
        );
        when(userRepository.existsByEmailIgnoreCase("shubh@example.com")).thenReturn(true);

        assertThatThrownBy(() -> authService.register(request))
                .isInstanceOf(BadRequestException.class)
                .hasMessage("Email is already registered");
    }

    @Test
    void loginAuthenticatesAndReturnsTokens() {
        LoginRequest request = new LoginRequest("shubh@example.com", "Strong@123");
        User user = User.builder()
                .id(11L)
                .name("Shubh")
                .email("shubh@example.com")
                .password("encoded")
                .rating(BigDecimal.ZERO)
                .emailVerified(true)
                .enabled(true)
                .roles(Set.of(studentRole))
                .build();

        when(userRepository.findByEmailIgnoreCase("shubh@example.com")).thenReturn(Optional.of(user));

        AuthResponse response = authService.login(request);

        assertThat(response.accessToken()).isNotBlank();
        assertThat(response.refreshToken()).isNotBlank();
        verify(authenticationManager).authenticate(any(UsernamePasswordAuthenticationToken.class));
        verify(refreshTokenRepository).save(any());
    }
}
