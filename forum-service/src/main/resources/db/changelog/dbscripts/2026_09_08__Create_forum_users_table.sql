CREATE TABLE forum_users
(
    id              uuid                     not null,
    auth_user_id    uuid                     not null,
    profile_user_id uuid                     not null,
    username        varchar(255)             not null,
    avatar_url      varchar(500)             not null,
    role            varchar(20)              not null,
    banned_until    timestamp with time zone not null,
    ban_reason      text                     not null,
    created_at      timestamp with time zone not null,
    updated_at      timestamp with time zone not null,
    version         bigint                   not null,

    constraint pk_forum_users primary key (id),
    constraint uk_forum_user_auth_id unique (auth_user_id),
    constraint uk_forum_user_profile_id unique (profile_user_id)
);

create index idx_forum_user_username on forum_users (username);

create index idx_forum_user_role on forum_users (role);

COMMENT ON TABLE forum_users IS 'Пользователь форума: локальная проекция пользователя из сервисов Auth и Profile. Мягкая блокировка через banned_until.';

COMMENT ON COLUMN forum_users.id IS 'Уникальный идентификатор записи (UUID v7, генерируется приложением).';
COMMENT ON COLUMN forum_users.auth_user_id IS 'UUID пользователя в Auth-сервисе (внешний ключ логической связки).';
COMMENT ON COLUMN forum_users.profile_user_id IS 'UUID пользователя в Profile-сервисе (внешний ключ логической связки).';
COMMENT ON COLUMN forum_users.username IS 'Отображаемое имя пользователя на форуме.';
COMMENT ON COLUMN forum_users.avatar_url IS 'Ссылка на аватар пользователя.';
COMMENT ON COLUMN forum_users.role IS 'Роль пользователя на форуме: ADMIN, MODERATOR, TOPIC_MODERATOR или USER.';
COMMENT ON COLUMN forum_users.banned_until IS 'Момент окончания блокировки. NULL означает, что пользователь не заблокирован.';
COMMENT ON COLUMN forum_users.ban_reason IS 'Причина блокировки пользователя.';
COMMENT ON COLUMN forum_users.created_at IS 'Дата и время создания записи. Заполняется приложением автоматически.';
COMMENT ON COLUMN forum_users.updated_at IS 'Дата и время последнего обновления записи. Заполняется приложением автоматически.';
COMMENT ON COLUMN forum_users.version IS 'Версия для оптимистичной блокировки (@Version). Стартует с 0.';