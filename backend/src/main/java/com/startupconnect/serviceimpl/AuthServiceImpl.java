package com.startupconnect.serviceimpl;

import com.startupconnect.constants.SecurityConstants;
import com.startupconnect.dto.auth.AuthResponse;
import com.startupconnect.dto.auth.ForgotPasswordRequest;
import com.startupconnect.dto.auth.LoginRequest;
import com.startupconnect.dto.auth.LogoutRequest;
import com.startupconnect.dto.auth.RefreshTokenRequest;
import com.startupconnect.dto.auth.RegisterRequest;
import com.startupconnect.dto.auth.ResetPasswordRequest;
import com.startupconnect.dto.auth.TokenResponse;
import com.startupconnect.dto.auth.VerifyEmailRequest;
import com.startupconnect.entity.EmailVerificationToken;
import com.startupconnect.entity.PasswordResetToken;
import com.startupconnect.entity.RefreshToken;
import com.startupconnect.entity.Role;
import com.startupconnect.entity.RoleName;
import com.startupconnect.entity.User;
import com.startupconnect.exception.BadRequestException;
import com.startupconnect.exception.ResourceNotFoundException;
import com.startupconnect.exception.UnauthorizedException;
import com.startupconnect.mapper.AuthMapper;
import com.startupconnect.repository.EmailVerificationTokenRepository;
import com.startupconnect.repository.PasswordResetTokenRepository;
import com.startupconnect.repository.RefreshTokenRepository;
import com.startupconnect.repository.RoleRepository;
import com.startupconnect.repository.UserRepository;
import com.startupconnect.security.JwtService;
import com.startupconnect.security.UserPrincipal;
import com.startupconnect.service.AuthService;
import com.startupconnect.service.EmailService;
import com.startupconnect.util.SecureTokenGenerator;
import com.startupconnect.util.TokenHashUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Locale;
import java.util.Set;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final RefreshTokenRepository refreshTokenRepository;
    private final EmailVerificationTokenRepository emailVerificationTokenRepository;
    private final PasswordResetTokenRepository passwordResetTokenRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;
    private final AuthMapper authMapper;
    private final SecureTokenGenerator secureTokenGenerator;
    private final TokenHashUtil tokenHashUtil;
    private final EmailService emailService;

    @Value("${app.jwt.refresh-token-expiration-ms}")
    private long refreshTokenExpirationMs;

    @Value("${app.security.email-verification-expiration-ms}")
    private long emailVerificationExpirationMs;

    @Value("${app.security.password-reset-expiration-ms}")
    private long passwordResetExpirationMs;

    @Override
    @Transactional
    public AuthResponse register(RegisterRequest request) {
        String normalizedEmail = normalizeEmail(request.email());
        if (userRepository.existsByEmailIgnoreCase(normalizedEmail)) {
            throw new BadRequestException("Email is already registered");
        }

        Role studentRole = getOrCreateRole(RoleName.STUDENT);
        User user = User.builder()
                .name(request.name().trim())
                .email(normalizedEmail)
                .password(passwordEncoder.encode(request.password()))
                .college(trimToNull(request.college()))
                .course(trimToNull(request.course()))
                .graduationYear(request.graduationYear())
                .rating(BigDecimal.ZERO)
                .emailVerified(false)
                .accountLocked(false)
                .enabled(true)
                .roles(Set.of(studentRole))
                .build();

        User savedUser = userRepository.save(user);
        createEmailVerificationToken(savedUser);
        log.info("Registered new user with email {}", savedUser.getEmail());
        return buildAuthResponse(savedUser);
    }

    @Override
    @Transactional
    public AuthResponse login(LoginRequest request) {
        String normalizedEmail = normalizeEmail(request.email());
        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(normalizedEmail, request.password()));
        User user = userRepository.findByEmailIgnoreCase(normalizedEmail)
                .orElseThrow(() -> new UnauthorizedException("Invalid email or password"));
        log.info("User logged in with email {}", normalizedEmail);
        return buildAuthResponse(user);
    }

    @Override
    @Transactional
    public TokenResponse refreshToken(RefreshTokenRequest request) {
        RefreshToken refreshToken = refreshTokenRepository.findByTokenHashAndRevokedFalse(tokenHashUtil.sha256(request.refreshToken()))
                .orElseThrow(() -> new UnauthorizedException("Refresh token is invalid"));

        if (refreshToken.getExpiresAt().isBefore(Instant.now())) {
            refreshToken.setRevoked(true);
            refreshTokenRepository.save(refreshToken);
            throw new UnauthorizedException("Refresh token has expired");
        }

        refreshToken.setRevoked(true);
        refreshTokenRepository.save(refreshToken);
        String newRefreshToken = createRefreshToken(refreshToken.getUser());
        String accessToken = jwtService.generateAccessToken(UserPrincipal.from(refreshToken.getUser()));

        return new TokenResponse(
                accessToken,
                newRefreshToken,
                SecurityConstants.TOKEN_PREFIX.trim(),
                jwtService.getAccessTokenExpirationMs()
        );
    }

    @Override
    @Transactional
    public void forgotPassword(ForgotPasswordRequest request) {
        userRepository.findByEmailIgnoreCase(normalizeEmail(request.email()))
                .ifPresent(user -> {
                    String rawToken = secureTokenGenerator.generateToken();
                    PasswordResetToken token = PasswordResetToken.builder()
                            .tokenHash(tokenHashUtil.sha256(rawToken))
                            .user(user)
                            .expiresAt(Instant.now().plusMillis(passwordResetExpirationMs))
                            .used(false)
                            .createdAt(Instant.now())
                            .build();
                    passwordResetTokenRepository.save(token);
                    emailService.sendPasswordReset(user, rawToken);
                });
    }

    @Override
    @Transactional
    public void resetPassword(ResetPasswordRequest request) {
        PasswordResetToken token = passwordResetTokenRepository.findByTokenHashAndUsedFalse(tokenHashUtil.sha256(request.token()))
                .orElseThrow(() -> new BadRequestException("Password reset token is invalid"));

        if (token.getExpiresAt().isBefore(Instant.now())) {
            throw new BadRequestException("Password reset token has expired");
        }

        User user = token.getUser();
        user.setPassword(passwordEncoder.encode(request.newPassword()));
        token.setUsed(true);
        userRepository.save(user);
        passwordResetTokenRepository.save(token);
        refreshTokenRepository.revokeAllByUser(user);
        log.info("Password reset completed for {}", user.getEmail());
    }

    @Override
    @Transactional
    public void verifyEmail(VerifyEmailRequest request) {
        EmailVerificationToken token = emailVerificationTokenRepository.findByTokenHashAndUsedFalse(tokenHashUtil.sha256(request.token()))
                .orElseThrow(() -> new BadRequestException("Email verification token is invalid"));

        if (token.getExpiresAt().isBefore(Instant.now())) {
            throw new BadRequestException("Email verification token has expired");
        }

        User user = token.getUser();
        user.setEmailVerified(true);
        token.setUsed(true);
        userRepository.save(user);
        emailVerificationTokenRepository.save(token);
        log.info("Email verified for {}", user.getEmail());
    }

    @Override
    @Transactional
    public void logout(LogoutRequest request) {
        refreshTokenRepository.findByTokenHashAndRevokedFalse(tokenHashUtil.sha256(request.refreshToken()))
                .ifPresent(refreshToken -> {
                    refreshToken.setRevoked(true);
                    refreshTokenRepository.save(refreshToken);
                    log.info("Refresh token revoked for {}", refreshToken.getUser().getEmail());
                });
    }

    private AuthResponse buildAuthResponse(User user) {
        String accessToken = jwtService.generateAccessToken(UserPrincipal.from(user));
        String refreshToken = createRefreshToken(user);
        return new AuthResponse(
                accessToken,
                refreshToken,
                SecurityConstants.TOKEN_PREFIX.trim(),
                jwtService.getAccessTokenExpirationMs(),
                authMapper.toAuthUserResponse(user)
        );
    }

    private String createRefreshToken(User user) {
        String rawToken = secureTokenGenerator.generateToken();
        RefreshToken refreshToken = RefreshToken.builder()
                .tokenHash(tokenHashUtil.sha256(rawToken))
                .user(user)
                .expiresAt(Instant.now().plusMillis(refreshTokenExpirationMs))
                .revoked(false)
                .createdAt(Instant.now())
                .build();
        refreshTokenRepository.save(refreshToken);
        return rawToken;
    }

    private void createEmailVerificationToken(User user) {
        String rawToken = secureTokenGenerator.generateToken();
        EmailVerificationToken token = EmailVerificationToken.builder()
                .tokenHash(tokenHashUtil.sha256(rawToken))
                .user(user)
                .expiresAt(Instant.now().plusMillis(emailVerificationExpirationMs))
                .used(false)
                .createdAt(Instant.now())
                .build();
        emailVerificationTokenRepository.save(token);
        emailService.sendEmailVerification(user, rawToken);
    }

    private Role getOrCreateRole(RoleName roleName) {
        return roleRepository.findByName(roleName)
                .orElseGet(() -> roleRepository.save(Role.builder().name(roleName).build()));
    }

    private String normalizeEmail(String email) {
        if (email == null) {
            throw new ResourceNotFoundException("Email is required");
        }
        return email.trim().toLowerCase(Locale.ROOT);
    }

    private String trimToNull(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        return value.trim();
    }
}
