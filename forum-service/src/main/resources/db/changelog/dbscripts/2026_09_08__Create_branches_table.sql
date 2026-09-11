CREATE TABLE branches
(
    id                uuid                     not null,
    topic_id          uuid                     not null,
    user_id           uuid                     not null,
    title             varchar(255)             not null,
    is_pinned         boolean                  not null,
    is_closed         boolean                  not null,
    views_count       bigint                   not null,
    last_post_id      uuid                     not null,
    last_comment_date timestamp with time zone not null,
    deleted_at        timestamp with time zone not null,
    deleted_reason    text                     not null,
    created_at        timestamp with time zone not null,
    updated_at        timestamp with time zone not null,
    version           bigint                   not null,

    constraint pk_branches primary key (id),
    constraint fk_branches_user foreign key (user_id) references forum_users (id),
    constraint fk_branches_topic foreign key (user_id) references topics (id)
);

create index idx_branch_topic on branches (topic_id);
create index idx_branch_user on branches (user_id);
create index idx_branch_pinned on branches (is_pinned);
create index idx_branch_closed on branches (is_closed);
create index idx_branch_last_comment on branches (last_comment_date);
create index idx_branch_deleted on branches (deleted_at);
create index idx_branch_topic_pinned_date on branches (topic_id, is_pinned DESC,
                                                       last_comment_date DESC);



COMMENT ON COLUMN branches.id IS 'Уникальный идентификатор записи (UUID v7, генерируется приложением).';
COMMENT ON COLUMN branches.topic_id IS 'Раздел, к которому относится ветка. Внешний ключ на topics.id.';
COMMENT ON COLUMN branches.user_id IS 'Автор ветки. Внешний ключ на forum_users.id.';
COMMENT ON COLUMN branches.title IS 'Заголовок ветки обсуждения.';
COMMENT ON COLUMN branches.is_pinned IS 'Флаг закрепления ветки вверху списка раздела.';
COMMENT ON COLUMN branches.is_closed IS 'Флаг закрытия ветки для новых сообщений.';
COMMENT ON COLUMN branches.views_count IS 'Счётчик просмотров ветки.';
COMMENT ON COLUMN branches.last_post_id IS 'Идентификатор последнего сообщения ветки. Денормализация, внешняя связка без FK.';
COMMENT ON COLUMN branches.last_comment_date IS 'Дата и время последнего комментария в ветке. Используется для сортировки лент.';
COMMENT ON COLUMN branches.deleted_at IS 'Дата и время мягкого удаления ветки. NULL означает, что ветка активна.';
COMMENT ON COLUMN branches.deleted_reason IS 'Причина удаления ветки.';
COMMENT ON COLUMN branches.created_at IS 'Дата и время создания записи. Заполняется приложением автоматически.';
COMMENT ON COLUMN branches.updated_at IS 'Дата и время последнего обновления записи. Заполняется приложением автоматически.';
COMMENT ON COLUMN branches.version IS 'Версия для оптимистичной блокировки (@Version). Стартует с 0.';