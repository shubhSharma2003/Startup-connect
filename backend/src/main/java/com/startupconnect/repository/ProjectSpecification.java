package com.startupconnect.repository;

import com.startupconnect.dto.ProjectSearchCriteria;
import com.startupconnect.entity.Project;
import com.startupconnect.entity.Skill;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;

import java.util.ArrayList;
import java.util.List;

public class ProjectSpecification {

    public static Specification<Project> withCriteria(ProjectSearchCriteria criteria) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (criteria.getKeyword() != null && !criteria.getKeyword().trim().isEmpty()) {
                String likePattern = "%" + criteria.getKeyword().toLowerCase() + "%";
                Predicate titleLike = cb.like(cb.lower(root.get("title")), likePattern);
                Predicate descLike = cb.like(cb.lower(root.get("description")), likePattern);
                predicates.add(cb.or(titleLike, descLike));
            }

            if (criteria.getStatus() != null) {
                predicates.add(cb.equal(root.get("status"), criteria.getStatus()));
            }

            if (criteria.getOwnerId() != null) {
                predicates.add(cb.equal(root.get("owner").get("id"), criteria.getOwnerId()));
            }

            if (criteria.getSkillIds() != null && !criteria.getSkillIds().isEmpty()) {
                Join<Project, Skill> skillsJoin = root.join("skills");
                predicates.add(skillsJoin.get("id").in(criteria.getSkillIds()));
                query.distinct(true); // Since we join on a collection, we might get duplicate project rows
            }

            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }
}
