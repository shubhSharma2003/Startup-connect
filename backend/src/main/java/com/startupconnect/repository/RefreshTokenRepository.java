package com.startupconnect.repository;

import com.startupconnect.entity.RefreshToken;
import com.startupconnect.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface RefreshTokenRepository extends JpaRepository<RefreshToken, Long> {

    Optional<RefreshToken> findByTokenHashAndRevokedFalse(String tokenHash);

    @Modifying
    @Query("update RefreshToken token set token.revoked = true where token.user = :user and token.revoked = false")
    void revokeAllByUser(User user);
}
