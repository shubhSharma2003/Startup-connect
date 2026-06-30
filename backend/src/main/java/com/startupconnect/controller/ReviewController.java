package com.startupconnect.controller;

import com.startupconnect.dto.ApiResponse;
import com.startupconnect.dto.RatingSummaryResponse;
import com.startupconnect.dto.ReviewRequest;
import com.startupconnect.dto.ReviewResponse;
import com.startupconnect.entity.ReviewTargetType;
import com.startupconnect.service.ReviewService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/reviews")
@RequiredArgsConstructor
@Tag(name = "Review and Rating Management", description = "APIs for user and project reviews")
public class ReviewController {

    private final ReviewService reviewService;

    @Operation(summary = "Add a new review")
    @PostMapping
    public ResponseEntity<ApiResponse<ReviewResponse>> addReview(
            @Valid @RequestBody ReviewRequest request,
            Authentication authentication) {
        ReviewResponse response = reviewService.addReview(request, authentication.getName());
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success("Review added successfully", response));
    }

    @Operation(summary = "Update an existing review")
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<ReviewResponse>> updateReview(
            @PathVariable Long id,
            @Valid @RequestBody ReviewRequest request,
            Authentication authentication) {
        ReviewResponse response = reviewService.updateReview(id, request, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Review updated successfully", response));
    }

    @Operation(summary = "Get paginated reviews for a specific target")
    @GetMapping("/target/{targetType}/{targetId}")
    public ResponseEntity<ApiResponse<Page<ReviewResponse>>> getTargetReviews(
            @PathVariable ReviewTargetType targetType,
            @PathVariable Long targetId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<ReviewResponse> response = reviewService.getTargetReviews(targetId, targetType, page, size);
        return ResponseEntity.ok(ApiResponse.success("Reviews retrieved successfully", response));
    }

    @Operation(summary = "Get average rating summary for a specific target")
    @GetMapping("/target/{targetType}/{targetId}/summary")
    public ResponseEntity<ApiResponse<RatingSummaryResponse>> getTargetRatingSummary(
            @PathVariable ReviewTargetType targetType,
            @PathVariable Long targetId) {
        RatingSummaryResponse response = reviewService.getTargetRatingSummary(targetId, targetType);
        return ResponseEntity.ok(ApiResponse.success("Rating summary retrieved successfully", response));
    }

    @Operation(summary = "Delete a review")
    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteReview(
            @PathVariable Long id,
            Authentication authentication) {
        reviewService.deleteReview(id, authentication.getName());
        return ResponseEntity.ok(ApiResponse.success("Review deleted successfully", null));
    }
}
