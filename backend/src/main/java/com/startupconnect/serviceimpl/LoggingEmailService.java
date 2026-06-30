package com.startupconnect.serviceimpl;

import com.startupconnect.entity.User;
import com.startupconnect.service.EmailService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class LoggingEmailService implements EmailService {

    private final String frontendBaseUrl;

    public LoggingEmailService(@Value("${app.frontend-base-url}") String frontendBaseUrl) {
        this.frontendBaseUrl = frontendBaseUrl;
    }

    @Override
    public void sendEmailVerification(User user, String verificationToken) {
        String verificationUrl = frontendBaseUrl + "/verify-email?token=" + verificationToken;
        log.info("Email verification link generated for {}: {}", user.getEmail(), verificationUrl);
    }

    @Override
    public void sendPasswordReset(User user, String resetToken) {
        String resetUrl = frontendBaseUrl + "/reset-password?token=" + resetToken;
        log.info("Password reset link generated for {}: {}", user.getEmail(), resetUrl);
    }
}
