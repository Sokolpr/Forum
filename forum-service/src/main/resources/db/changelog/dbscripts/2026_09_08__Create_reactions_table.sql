CREATE TABLE reactions
(
    id         uuid                     not null,
    user_id    uuid                     not null,
    post_id    uuid                     not null,
    type       varchar(20)              not null,
    created_at timestamp with time zone not null,
    updated_at timestamp with time zone not null,
    version bigint not null,

    constraint pk_reactions primary key (id),
    constraint uk_reaction_user_post unique ("user_id", "post_id"),
    constraint fk_reaction_user foreign key (user_id) references forum_users(id),
    constraint fk_reaction_post foreign key (post_id) references posts(id)

);

create index idx_post_branch on posts (branch_id);
create index idx_post_user on posts (user_id);
create index idx_post_parent on posts (parent_id);
create index idx_post_deleted on posts (deleted_at);


COMMENT ON TABLE reactions IS 'Реакция пользователя на сообщение. Уникальность пары user_id и post_id гарантирует не более одной реакции пользователя на сообщение.';

COMMENT ON COLUMN reactions.id IS 'Уникальный идентификатор записи (UUID v7, генерируется приложением).';
COMMENT ON COLUMN reactions.user_id IS 'Пользователь, поставивший реакцию. Внешний ключ на forum_users.id.';
COMMENT ON COLUMN reactions.post_id IS 'Сообщение, на которое поставлена реакция. Внешний ключ на posts.id.';
COMMENT ON COLUMN reactions.type IS 'Тип реакции: LIKE, DISLIKE, LOVE, LAUGH, SAD или ANGRY.';
COMMENT ON COLUMN reactions.created_at IS 'Дата и время создания реакции. Заполняется приложением автоматически.';
COMMENT ON COLUMN reactions.updated_at IS 'Дата и время последнего изменения реакции (например смена LIKE на LOVE).';
COMMENT ON COLUMN reactions.version IS 'Версия для оптимистичной блокировки (@Version). Стартует с 0.';