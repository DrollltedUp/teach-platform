ALTER TABLE users
    ADD COLUMN password_hash TEXT NOT NULL,
    ADD COLUMN full_name     TEXT NOT NULL DEFAULT '',
    ADD COLUMN teacher_id    UUID REFERENCES users(id);

ALTER TABLE users
    ADD CONSTRAINT users_teacher_link_chk
    CHECK ((role = 'student') = (teacher_id IS NOT NULL));

CREATE INDEX users_teacher_id_idx ON users(teacher_id);

CREATE TABLE groups (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    teacher_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name       TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (teacher_id, name)
);

CREATE TABLE group_members (
    group_id   UUID NOT NULL REFERENCES groups(id) ON DELETE CASCADE,
    student_id UUID NOT NULL REFERENCES users(id)  ON DELETE CASCADE,
    PRIMARY KEY (group_id, student_id)
);
CREATE INDEX group_members_student_idx ON group_members(student_id);

CREATE TABLE refresh_tokens (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id    UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token_hash BYTEA NOT NULL UNIQUE,
    expires_at TIMESTAMPTZ NOT NULL,
    revoked_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX refresh_tokens_user_idx ON refresh_tokens(user_id);