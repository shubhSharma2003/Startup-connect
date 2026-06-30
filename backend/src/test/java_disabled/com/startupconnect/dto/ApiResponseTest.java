package com.startupconnect.dto;

import org.junit.jupiter.api.Test;

import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;

class ApiResponseTest {

    @Test
    void successCreatesStandardResponseShape() {
        ApiResponse<Map<String, String>> response = ApiResponse.success("Created", Map.of("id", "1"));

        assertThat(response.success()).isTrue();
        assertThat(response.message()).isEqualTo("Created");
        assertThat(response.data()).containsEntry("id", "1");
        assertThat(response.timestamp()).isNotNull();
    }

    @Test
    void failureCreatesStandardResponseShape() {
        ApiResponse<Object> response = ApiResponse.failure("Validation failed", null);

        assertThat(response.success()).isFalse();
        assertThat(response.message()).isEqualTo("Validation failed");
        assertThat(response.data()).isNull();
        assertThat(response.timestamp()).isNotNull();
    }
}
