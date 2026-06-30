package com.startupconnect.service;

import com.startupconnect.entity.User;

public interface EmailService {

    void sendEmailVerification(User user, String verificationToken);

    void sendPasswordReset(User user, String resetToken);
}
