package com.startupconnect.repository;

import com.startupconnect.entity.Review;
import com.startupconnect.entity.ReviewTargetType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    Page<Review> findByTargetIdAndTargetTypeOrderByCreatedAtDesc(Long targetId, ReviewTargetType targetType, Pageable pageable);

    Optional<Review> findByReviewerIdAndTargetIdAndTargetType(Long reviewerId, Long targetId, ReviewTargetType targetType);

    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.targetId = :targetId AND r.targetType = :targetType")
    Double calculateAverageRating(@Param("targetId") Long targetId, @Param("targetType") ReviewTargetType targetType);

    long countByTargetIdAndTargetType(Long targetId, ReviewTargetType targetType);
}
