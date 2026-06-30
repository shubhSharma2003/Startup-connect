package com.startupconnect.service;

import com.startupconnect.dto.RatingSummaryResponse;
import com.startupconnect.dto.ReviewRequest;
import com.startupconnect.dto.ReviewResponse;
import com.startupconnect.entity.ReviewTargetType;
import org.springframework.data.domain.Page;

public interface ReviewService {
    ReviewResponse addReview(ReviewRequest request, String reviewerEmail);
    ReviewResponse updateReview(Long reviewId, ReviewRequest request, String reviewerEmail);
    Page<ReviewResponse> getTargetReviews(Long targetId, ReviewTargetType targetType, int page, int size);
    RatingSummaryResponse getTargetRatingSummary(Long targetId, ReviewTargetType targetType);
    void deleteReview(Long reviewId, String reviewerEmail);
}
