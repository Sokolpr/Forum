CREATE TABLE subscriptions
(
    id         uuid                     not null,
    user_id    uuid                     not null,
    branch_id  uuid                     not null,
    created_at timestamp with time zone not null,

    constraint pk_subscriptions primary key (id),
    constraint fk_subscription_user foreign key (user_id) references forum_users (id),
    constraint fk_subscription_branch foreign key (branch_id) references brances (id),
    constraint uk_subscription_user_branch unique ("user_id", "branch_id")
);





COMMENT ON TABLE subscriptions IS 'Подписка пользователя на ветку — основа для уведомлений о новых сообщениях.';

COMMENT ON COLUMN subscriptions.id IS 'Уникальный идентификатор записи (UUID v7, генерируется приложением).';
COMMENT ON COLUMN subscriptions.user_id IS 'Подписчик. Внешний ключ на forum_users.id.';
COMMENT ON COLUMN subscriptions.branch_id IS 'Ветка, на которую подписан пользователь. Внешний ключ на branches.id.';
COMMENT ON COLUMN subscriptions.created_at IS 'Дата и время создания подписки. Заполняется приложением автоматически.';