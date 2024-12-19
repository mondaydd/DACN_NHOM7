package vn.nhom18.shoppingclothes.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.nhom18.shoppingclothes.domain.Message;

@Repository
public interface MessageRepository extends JpaRepository<Message, Long> {
        List<Message> findBySenderIdOrReceiverId(long senderId, long receiverId);

        long countByReceiverId(Long receiverId);

        // Lấy tất cả tin nhắn gửi đến user, không phân biệt trạng thái đã đọc hay chưa
        List<Message> findByReceiverId(Long receiverId);

        @Query("SELECT m FROM Message m WHERE m.receiver.id = :receiverId")
        List<Message> findMessagesByReceiverId(@Param("receiverId") Long receiverId);


        Message findByReceiverIdAndSenderId(Long receiverId, Long senderId);

        List<Message> findBySenderIdAndReceiverId(Long senderId, Long receiverId);

       List<Message> findByReceiverIdAndSenderId(long receiverId,long senderId);
}
