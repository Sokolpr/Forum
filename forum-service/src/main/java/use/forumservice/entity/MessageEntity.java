package use.forumservice.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.Instant;
import java.util.UUID;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "messages")
public class MessageEntity {

    // id сообщения
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    // id пользователя
    @Column(name = "owner_id", nullable = false)
    private UUID ownerId;
    // id родительского сообщения
    @Column(name = "parent_id")
    private UUID parentId;

    // сообщение
    @Column(columnDefinition = "TEXT")
    private String message;

    // время создания
    @CreationTimestamp
    @Column(nullable = false, updatable = false)
    private Instant createTime;

    // время обновления
    @UpdateTimestamp
    @Column(nullable = false)
    private Instant updateTime;


    public MessageEntity(UUID ownerId, UUID parentId, String message) {
        this.id=UUID.randomUUID();
        this.ownerId = ownerId;
        this.parentId = parentId;
        this.message = message;
    }
}
