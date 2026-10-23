INSERT INTO users (email, password_hash, full_name, role, teacher_id) VALUES ($1, $2, $3, $4, $5) RETURNING *;

SELECT * FROM users WHERE email = $1

SELECT * FROM users WHERE id = $1;

SELECT * FROM users WHERE full_name = $1