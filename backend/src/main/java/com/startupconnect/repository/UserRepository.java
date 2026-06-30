package com.startupconnect.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.startupconnect.entity.User;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    boolean existsByEmailIgnoreCase(String email);
    Optional<User> findByEmailIgnoreCase(String email);
    
    @Query("SELECT u FROM User u LEFT JOIN u.skills s WHERE " +
           "(:keyword IS NULL OR LOWER(u.name) LIKE LOWER(CONCAT('%', :keyword, '%'))) AND " +
           "(:college IS NULL OR LOWER(u.college) = LOWER(:college)) AND " +
           "(:course IS NULL OR LOWER(u.course) = LOWER(:course)) AND " +
           "(:skill IS NULL OR LOWER(s.name) = LOWER(:skill))")
    Page<User> searchUsers(@Param("keyword") String keyword, @Param("college") String college, @Param("course") String course, @Param("skill") String skill, Pageable pageable);
}
