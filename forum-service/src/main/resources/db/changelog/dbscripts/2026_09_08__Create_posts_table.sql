CREATE TABLE posts
(
    id             uuid                     not null,
    branch_id      uuid                     not null,
    user_id        uuid                     not null,
    parent_id      uuid,
    content        text                     not null,
    edited_at      timestamp with time zone,
    deleted_at     timestamp with time zone,
    deleted_reason text,
    created_at     timestamp with time zone not null,
    updated_at     timestamp with time zone not null,
    version        bigint                   not null,

    constraint pk_posts primary key (id),
    constraint fk_post_branch foreign key (branch_id) references branches (id),
    constraint fk_post_user foreign key (user_id) references users (id),
    constraint fk_post_parent foreign key (parent_id) references posts(id)
);

create index idx_post_branch on posts (branch_id);
create index idx_post_user on posts (user_id);
create index idx_post_parent on posts (parent_id);
create index idx_post_deleted on posts (deleted_at);



COMMENT ON TABLE posts IS 'Сообщение форума: стартовое сообщение ветки либо комментарий к нему. Вложенность ограничена одним уровнем. Мягкое удаление через deleted_at.';

COMMENT ON COLUMN posts.id IS 'Уникальный идентификатор записи (UUID v7, генерируется приложением).';
COMMENT ON COLUMN posts.branch_id IS 'Ветка, в которой опубликовано сообщение. Внешний ключ на branches.id.';
COMMENT ON COLUMN posts.user_id IS 'Автор сообщения. Внешний ключ на forum_users.id.';
COMMENT ON COLUMN posts.parent_id IS 'Родительское сообщение: стартовое сообщение ветки, если текущее сообщение является комментарием. NULL у стартовых сообщений.';
COMMENT ON COLUMN posts.content IS 'Содержимое сообщения.';
COMMENT ON COLUMN posts.edited_at IS 'Дата и время редактирования сообщения. NULL означает, что сообщение не редактировалось.';
COMMENT ON COLUMN posts.deleted_at IS 'Дата и время мягкого удаления сообщения. NULL означает, что сообщение активно.';
COMMENT ON COLUMN posts.deleted_reason IS 'Причина удаления сообщения.';
COMMENT ON COLUMN posts.created_at IS 'Дата и время создания записи. Заполняется приложением автоматически.';
COMMENT ON COLUMN posts.updated_at IS 'Дата и время последнего обновления записи. Заполняется приложением автоматически.';
COMMENT ON COLUMN posts.version IS 'Версия для оптимистичной блокировки (@Version). Стартует с 0.';
