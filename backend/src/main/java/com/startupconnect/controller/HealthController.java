package com.startupconnect.controller;

import com.startupconnect.constants.AppConstants;
import com.startupconnect.dto.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping(AppConstants.API_BASE_PATH + "/health")
public class HealthController {

    @GetMapping
    public ResponseEntity<ApiResponse<Map<String, String>>> health() {
        return ResponseEntity.ok(ApiResponse.success(
                "StartupConnect API is running",
                Map.of("status", "UP")
        ));
    }
}
