CREATE TABLE moderation_audit_logs
(
    id             uuid                     not null,
    moderator_id   uuid                     not null,
    target_user_id uuid,
    target_type    varchar(20)              not null,
    target_id      uuid                     not null,
    action         varchar(20)              not null,
    reason         text,
    created_at     timestamp with time zone not null,

    constraint pk_moderation_audit_logs primary key (id),
    constraint fk_audit_moderator foreign key (moderator_id) references forum_users (id),
    constraint fk_audit_target_user foreign key (target_user_id) references forum_suers (id)
);

create index idx_audit_moderator on moderation_audit_logs (moderator_id);
create index idx_audit_target on moderation_audit_logs (target_type);



COMMENT ON TABLE moderation_audit_logs IS 'Журнал действий модераторов (аудит). Цель действия может быть любого типа и хранится полиморфно через target_type и target_id.';

COMMENT ON COLUMN moderation_audit_logs.id IS 'Уникальный идентификатор записи (UUID v7, генерируется приложением).';
COMMENT ON COLUMN moderation_audit_logs.moderator_id IS 'Модератор, выполнивший действие. Внешний ключ на forum_users.id.';
COMMENT ON COLUMN moderation_audit_logs.target_user_id IS 'Пользователь, в отношении которого выполнено действие, если целью был USER. Внешний ключ на forum_users.id.';
COMMENT ON COLUMN moderation_audit_logs.target_type IS 'Тип объекта модерации: POST, BRANCH, TOPIC или USER.';
COMMENT ON COLUMN moderation_audit_logs.target_id IS 'Идентификатор объекта модерации. Для цели типа USER дублирует target_user_id.';
COMMENT ON COLUMN moderation_audit_logs.action IS 'Выполненное действие: DELETE, BAN, UNBAN, CLOSE, OPEN, PIN, UNPIN или EDIT.';
COMMENT ON COLUMN moderation_audit_logs.reason IS 'Причина или комментарий модератора к действию.';
COMMENT ON COLUMN moderation_audit_logs.created_at IS 'Дата и время совершения действия. Заполняется приложением автоматически.';