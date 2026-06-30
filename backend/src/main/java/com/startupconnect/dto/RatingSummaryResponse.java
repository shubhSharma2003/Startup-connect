package com.startupconnect.dto;

import com.startupconnect.entity.ReviewTargetType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class RatingSummaryResponse {
    private Long targetId;
    private ReviewTargetType targetType;
    private double averageRating;
    private long totalReviews;
}
