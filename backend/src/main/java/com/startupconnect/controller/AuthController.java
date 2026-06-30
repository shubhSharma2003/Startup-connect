package com.startupconnect.controller;

import com.startupconnect.constants.AppConstants;
import com.startupconnect.dto.ApiResponse;
import com.startupconnect.dto.auth.AuthResponse;
import com.startupconnect.dto.auth.ForgotPasswordRequest;
import com.startupconnect.dto.auth.LoginRequest;
import com.startupconnect.dto.auth.LogoutRequest;
import com.startupconnect.dto.auth.RefreshTokenRequest;
import com.startupconnect.dto.auth.RegisterRequest;
import com.startupconnect.dto.auth.ResetPasswordRequest;
import com.startupconnect.dto.auth.TokenResponse;
import com.startupconnect.dto.auth.VerifyEmailRequest;
import com.startupconnect.service.AuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping(AppConstants.API_BASE_PATH + "/auth")
public class AuthController {

    private final AuthService authService;

    @PostMapping("/register")
    public ResponseEntity<ApiResponse<AuthResponse>> register(@Valid @RequestBody RegisterRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success("User registered successfully", authService.register(request)));
    }

    @PostMapping("/login")
    public ResponseEntity<ApiResponse<AuthResponse>> login(@Valid @RequestBody LoginRequest request) {
        return ResponseEntity.ok(ApiResponse.success("Login successful", authService.login(request)));
    }

    @PostMapping("/refresh-token")
    public ResponseEntity<ApiResponse<TokenResponse>> refreshToken(@Valid @RequestBody RefreshTokenRequest request) {
        return ResponseEntity.ok(ApiResponse.success("Token refreshed successfully", authService.refreshToken(request)));
    }

    @PostMapping("/forgot-password")
    public ResponseEntity<ApiResponse<Map<String, String>>> forgotPassword(@Valid @RequestBody ForgotPasswordRequest request) {
        authService.forgotPassword(request);
        return ResponseEntity.ok(ApiResponse.success(
                "If the email exists, password reset instructions have been sent",
                Map.of("email", request.email())
        ));
    }

    @PostMapping("/reset-password")
    public ResponseEntity<ApiResponse<Map<String, Boolean>>> resetPassword(@Valid @RequestBody ResetPasswordRequest request) {
        authService.resetPassword(request);
        return ResponseEntity.ok(ApiResponse.success("Password reset successfully", Map.of("reset", true)));
    }

    @PostMapping("/verify-email")
    public ResponseEntity<ApiResponse<Map<String, Boolean>>> verifyEmail(@Valid @RequestBody VerifyEmailRequest request) {
        authService.verifyEmail(request);
        return ResponseEntity.ok(ApiResponse.success("Email verified successfully", Map.of("verified", true)));
    }

    @PostMapping("/logout")
    public ResponseEntity<ApiResponse<Map<String, Boolean>>> logout(@Valid @RequestBody LogoutRequest request) {
        authService.logout(request);
        return ResponseEntity.ok(ApiResponse.success("Logout successful", Map.of("loggedOut", true)));
    }
}
