package com.startupconnect.service.impl;

import com.startupconnect.dto.RatingSummaryResponse;
import com.startupconnect.dto.ReviewRequest;
import com.startupconnect.dto.ReviewResponse;
import com.startupconnect.entity.Review;
import com.startupconnect.entity.ReviewTargetType;
import com.startupconnect.entity.User;
import com.startupconnect.exception.BadRequestException;
import com.startupconnect.exception.ResourceNotFoundException;
import com.startupconnect.exception.UnauthorizedException;
import com.startupconnect.mapper.ReviewMapper;
import com.startupconnect.repository.ReviewRepository;
import com.startupconnect.repository.UserRepository;
import com.startupconnect.service.ReviewService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
public class ReviewServiceImpl implements ReviewService {

    private final ReviewRepository reviewRepository;
    private final UserRepository userRepository;
    private final ReviewMapper reviewMapper;
    private final ApplicationEventPublisher eventPublisher;

    @Override
    @Transactional
    public ReviewResponse addReview(ReviewRequest request, String reviewerEmail) {
        User reviewer = getUserByEmail(reviewerEmail);

        if (request.getTargetType() == ReviewTargetType.USER && request.getTargetId().equals(reviewer.getId())) {
            throw new BadRequestException("You cannot review yourself");
        }

        reviewRepository.findByReviewerIdAndTargetIdAndTargetType(reviewer.getId(), request.getTargetId(), request.getTargetType())
                .ifPresent(r -> {
                    throw new BadRequestException("You have already reviewed this target. Please update your existing review.");
                });

        Review review = Review.builder()
                .reviewer(reviewer)
                .targetId(request.getTargetId())
                .targetType(request.getTargetType())
                .rating(request.getRating())
                .comment(request.getComment())
                .build();

        Review savedReview = reviewRepository.save(review);
        notifyTargetIfUser(savedReview);

        return reviewMapper.reviewToReviewResponse(savedReview);
    }

    @Override
    @Transactional
    public ReviewResponse updateReview(Long reviewId, ReviewRequest request, String reviewerEmail) {
        Review review = getReviewById(reviewId);
        verifyOwnership(review, reviewerEmail);

        if (!review.getTargetId().equals(request.getTargetId()) || review.getTargetType() != request.getTargetType()) {
            throw new BadRequestException("Target ID and Type cannot be changed");
        }

        review.setRating(request.getRating());
        review.setComment(request.getComment());

        return reviewMapper.reviewToReviewResponse(reviewRepository.save(review));
    }

    @Override
    @Transactional(readOnly = true)
    public Page<ReviewResponse> getTargetReviews(Long targetId, ReviewTargetType targetType, int page, int size) {
        return reviewRepository.findByTargetIdAndTargetTypeOrderByCreatedAtDesc(targetId, targetType, PageRequest.of(page, size))
                .map(reviewMapper::reviewToReviewResponse);
    }

    @Override
    @Transactional(readOnly = true)
    public RatingSummaryResponse getTargetRatingSummary(Long targetId, ReviewTargetType targetType) {
        Double avgRating = reviewRepository.calculateAverageRating(targetId, targetType);
        long count = reviewRepository.countByTargetIdAndTargetType(targetId, targetType);
        
        return RatingSummaryResponse.builder()
                .targetId(targetId)
                .targetType(targetType)
                .averageRating(avgRating != null ? Math.round(avgRating * 10.0) / 10.0 : 0.0)
                .totalReviews(count)
                .build();
    }

    @Override
    @Transactional
    public void deleteReview(Long reviewId, String reviewerEmail) {
        Review review = getReviewById(reviewId);
        verifyOwnership(review, reviewerEmail);
        reviewRepository.delete(review);
    }

    private User getUserByEmail(String email) {
        return userRepository.findByEmailIgnoreCase(email)
                .orElseThrow(() -> new UnauthorizedException("User not found"));
    }

    private Review getReviewById(Long id) {
        return reviewRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Review not found with id: " + id));
    }

    private void verifyOwnership(Review review, String currentUserEmail) {
        if (!review.getReviewer().getEmail().equalsIgnoreCase(currentUserEmail)) {
            throw new UnauthorizedException("You do not have permission to modify this review");
        }
    }

    private void notifyTargetIfUser(Review review) {
        if (review.getTargetType() == ReviewTargetType.USER) {
            com.startupconnect.service.event.NotificationEvent event = com.startupconnect.service.event.NotificationEvent.builder()
                    .recipientUserId(review.getTargetId())
                    .type(com.startupconnect.entity.NotificationType.REVIEW_RECEIVED)
                    .title("New Review Received")
                    .message(review.getReviewer().getName() + " left you a " + review.getRating() + "-star review.")
                    .referenceId(review.getId())
                    .build();
            eventPublisher.publishEvent(event);
        }
    }
}
