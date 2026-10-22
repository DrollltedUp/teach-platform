CREATE TABLE users (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email         TEXT NOT NULL UNIQUE,
    role          TEXT NOT NULL CHECK (role IN ('teacher', 'student')),
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);