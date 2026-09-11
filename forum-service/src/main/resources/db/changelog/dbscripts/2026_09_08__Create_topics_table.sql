CREATE TABLE topics
(
    id         uuid                     not null,
    title      varchar(255)             not null,
    description  text                     not null,
    moderator_id uuid not null,
    sort_order bigint not null,
    created_at timestamp with time zone not null,
    updated_at timestamp with time zone not null,
    deleted_at timestamp with time zone ,
    deleted_reason text,
    version bigint not null,


    constraint pk_topics primary key (id),
    constraint fk_topic_moderator foreign key (moderator_id) references moderation_audit_logs (id),
);

create index idx_topic_moderator on topics(moderator_id);
create index idx_topic_sort_order on topics(sort_order);



COMMENT ON TABLE topics IS 'Раздел или категория форума. Поддерживает мягкое удаление через deleted_at и deleted_reason.';

COMMENT ON COLUMN topics.id IS 'Уникальный идентификатор записи (UUID v7, генерируется приложением).';
COMMENT ON COLUMN topics.title IS 'Название раздела форума.';
COMMENT ON COLUMN topics.description IS 'Описание раздела.';
COMMENT ON COLUMN topics.moderator_id IS 'Модератор раздела. Внешний ключ на forum_users.id. NULL, если модератор не назначен.';
COMMENT ON COLUMN topics.sort_order IS 'Порядок сортировки раздела в списке.';
COMMENT ON COLUMN topics.created_at IS 'Дата и время создания записи. Заполняется приложением автоматически.';
COMMENT ON COLUMN topics.updated_at IS 'Дата и время последнего обновления записи. Заполняется приложением автоматически.';
COMMENT ON COLUMN topics.deleted_at IS 'Дата и время мягкого удаления раздела. NULL означает, что раздел активен.';
COMMENT ON COLUMN topics.deleted_reason IS 'Причина удаления раздела.';
COMMENT ON COLUMN topics.version IS 'Версия для оптимистичной блокировки (@Version). Стартует с 0.';



