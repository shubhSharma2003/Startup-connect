package com.startupconnect.mapper;

import com.startupconnect.dto.ReviewResponse;
import com.startupconnect.entity.Review;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper(componentModel = "spring")
public interface ReviewMapper {

    ReviewMapper INSTANCE = Mappers.getMapper(ReviewMapper.class);

    @Mapping(target = "reviewer.id", source = "reviewer.id")
    @Mapping(target = "reviewer.name", source = "reviewer.name")
    @Mapping(target = "reviewer.email", source = "reviewer.email")
    ReviewResponse reviewToReviewResponse(Review review);
}
