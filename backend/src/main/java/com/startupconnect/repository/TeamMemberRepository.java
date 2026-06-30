package com.startupconnect.repository;

import com.startupconnect.entity.TeamMember;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface TeamMemberRepository extends JpaRepository<TeamMember, Long> {
    Optional<TeamMember> findByProjectIdAndUserId(Long projectId, Long userId);
    List<TeamMember> findByProjectId(Long projectId);
}
