package com.startupconnect.repository;

import com.startupconnect.entity.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import java.util.List;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {
    Page<Notification> findByUserId(Long userId, Pageable pageable);
    int countByUserIdAndIsReadFalse(Long userId);
    List<Notification> findByUserIdAndIsReadFalse(Long userId);
}
