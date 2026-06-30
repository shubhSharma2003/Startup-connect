package com.startupconnect.repository;

import com.startupconnect.entity.Application;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface ApplicationRepository extends JpaRepository<Application, Long> {
    Optional<Application> findByProjectIdAndApplicantId(Long projectId, Long applicantId);
    List<Application> findByProjectId(Long projectId);
    List<Application> findByApplicantId(Long applicantId);
}
