ALTER TABLE users
    ADD COLUMN auth_id text NOT NULL,
    DROP COLUMN password;