package vn.nhom18.shoppingclothes.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.nhom18.shoppingclothes.domain.Message;
import vn.nhom18.shoppingclothes.domain.MessageHistory;

@Repository
public interface MessageHistoryRepository extends JpaRepository<MessageHistory, Long> {
    List<MessageHistory> findByMessageIn(List<Message> messages);

    @Query("SELECT mh FROM MessageHistory mh WHERE mh.message.sender.id = :userId OR mh.message.receiver.id = :userId")
    List<MessageHistory> findBySenderIdOrReceiverId(@Param("userId") long userId);

    List<MessageHistory> findTop5ByOrderByTimestampDesc();

    List<MessageHistory> findByMessageReceiverId(Long receiverId);

    // Lấy tất cả các tin nhắn từ một message cụ thể
    List<MessageHistory> findByMessageId(Long messageId);

    // Lấy tất cả tin nhắn từ một sender
    List<MessageHistory> findBySenderId(Long senderId);

    @Query("SELECT mh FROM MessageHistory mh WHERE mh.message.receiver.id = :adminId " +
            "AND mh.timestamp = (SELECT MAX(mh2.timestamp) FROM MessageHistory mh2 WHERE mh2.message.receiver.id = :adminId AND mh2.sender.id = mh.sender.id) ")
    List<MessageHistory> findLatestMessagesForAdmin(@Param("adminId") long adminId);

    List<MessageHistory> findByMessageIdAndSenderId(Long messageId, Long senderId);

    @Query("SELECT mh FROM MessageHistory mh " +
            "JOIN mh.message m " +
            "WHERE (m.sender.id = :userId AND m.receiver.id = :adminId) " +
            "OR (m.sender.id = :adminId AND m.receiver.id = :userId) " +
            "ORDER BY mh.timestamp ASC")
    List<MessageHistory> findMessagesBetweenUserAndAdmin(@Param("userId") Long userId, @Param("adminId") Long adminId);

}
