CREATE TABLE users (
                       id            BIGSERIAL PRIMARY KEY,
                       username      VARCHAR(30)  NOT NULL UNIQUE,
                       password_hash VARCHAR(100) NOT NULL,
                       created_at    TIMESTAMPTZ  NOT NULL DEFAULT now()
);

CREATE TABLE friend_groups (
                               id          BIGSERIAL PRIMARY KEY,
                               name        VARCHAR(50) NOT NULL,
                               invite_code VARCHAR(12) NOT NULL UNIQUE,
                               created_by  BIGINT      NOT NULL REFERENCES users(id),
                               created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE group_members (
                               group_id  BIGINT      NOT NULL REFERENCES friend_groups(id) ON DELETE CASCADE,
                               user_id   BIGINT      NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                               joined_at TIMESTAMPTZ NOT NULL DEFAULT now(),
                               PRIMARY KEY (group_id, user_id)
);

CREATE TABLE pints (
                       id         BIGSERIAL PRIMARY KEY,
                       user_id    BIGINT       NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                       volume_ml  INTEGER      NOT NULL CHECK (volume_ml > 0 AND volume_ml <= 5000),
                       drink_name VARCHAR(100),
                       venue      VARCHAR(100),
                       drank_at   TIMESTAMPTZ  NOT NULL,
                       created_at TIMESTAMPTZ  NOT NULL DEFAULT now()
);

CREATE INDEX idx_pints_user_drank_at ON pints (user_id, drank_at);