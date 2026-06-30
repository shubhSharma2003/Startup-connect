CREATE TABLE skills (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT uk_skills_name UNIQUE (name)
);

CREATE TABLE user_skills (
    user_id BIGINT NOT NULL,
    skill_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, skill_id),
    CONSTRAINT fk_user_skills_user FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_user_skills_skill FOREIGN KEY (skill_id) REFERENCES skills (id)
);

CREATE INDEX idx_skills_name ON skills (name);
CREATE INDEX idx_user_skills_skill_id ON user_skills (skill_id);
