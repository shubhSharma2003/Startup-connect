package com.startupconnect.service.impl;

import com.startupconnect.dto.RatingSummaryResponse;
import com.startupconnect.dto.ReviewRequest;
import com.startupconnect.dto.ReviewResponse;
import com.startupconnect.entity.Review;
import com.startupconnect.entity.ReviewTargetType;
import com.startupconnect.entity.User;
import com.startupconnect.exception.BadRequestException;
import com.startupconnect.exception.UnauthorizedException;
import com.startupconnect.mapper.ReviewMapper;
import com.startupconnect.repository.ReviewRepository;
import com.startupconnect.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.context.ApplicationEventPublisher;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ReviewServiceImplTest {

    @Mock
    private ReviewRepository reviewRepository;
    @Mock
    private UserRepository userRepository;
    @Mock
    private ReviewMapper reviewMapper;
    @Mock
    private ApplicationEventPublisher eventPublisher;

    @InjectMocks
    private ReviewServiceImpl reviewService;

    private User reviewer;
    private User targetUser;
    private Review review;
    private ReviewRequest reviewRequest;

    @BeforeEach
    void setUp() {
        reviewer = User.builder().id(1L).email("reviewer@example.com").name("Reviewer").build();
        targetUser = User.builder().id(2L).email("target@example.com").name("Target").build();

        reviewRequest = ReviewRequest.builder()
                .targetId(2L)
                .targetType(ReviewTargetType.USER)
                .rating(5)
                .comment("Great teammate")
                .build();

        review = Review.builder()
                .id(1L)
                .reviewer(reviewer)
                .targetId(2L)
                .targetType(ReviewTargetType.USER)
                .rating(5)
                .comment("Great teammate")
                .build();
    }

    @Test
    void testAddReviewSuccess() {
        when(userRepository.findByEmailIgnoreCase("reviewer@example.com")).thenReturn(Optional.of(reviewer));
        when(reviewRepository.findByReviewerIdAndTargetIdAndTargetType(1L, 2L, ReviewTargetType.USER)).thenReturn(Optional.empty());
        when(reviewRepository.save(any(Review.class))).thenReturn(review);
        when(reviewMapper.reviewToReviewResponse(any(Review.class))).thenReturn(new ReviewResponse());

        reviewService.addReview(reviewRequest, "reviewer@example.com");

        verify(reviewRepository).save(any(Review.class));
        verify(eventPublisher).publishEvent(any(com.startupconnect.service.event.NotificationEvent.class));
    }

    @Test
    void testAddReviewSelfReviewThrowsException() {
        when(userRepository.findByEmailIgnoreCase("reviewer@example.com")).thenReturn(Optional.of(reviewer));
        
        reviewRequest.setTargetId(1L);

        assertThrows(BadRequestException.class, () -> {
            reviewService.addReview(reviewRequest, "reviewer@example.com");
        });
    }

    @Test
    void testGetTargetRatingSummary() {
        when(reviewRepository.calculateAverageRating(2L, ReviewTargetType.USER)).thenReturn(4.56);
        when(reviewRepository.countByTargetIdAndTargetType(2L, ReviewTargetType.USER)).thenReturn(10L);

        RatingSummaryResponse summary = reviewService.getTargetRatingSummary(2L, ReviewTargetType.USER);

        assertEquals(4.6, summary.getAverageRating());
        assertEquals(10L, summary.getTotalReviews());
    }

    @Test
    void testUpdateReviewUnauthorized() {
        when(reviewRepository.findById(1L)).thenReturn(Optional.of(review));

        assertThrows(UnauthorizedException.class, () -> {
            reviewService.updateReview(1L, reviewRequest, "target@example.com");
        });
    }
}
