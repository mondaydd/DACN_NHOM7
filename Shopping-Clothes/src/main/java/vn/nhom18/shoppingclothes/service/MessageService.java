package vn.nhom18.shoppingclothes.service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import vn.nhom18.shoppingclothes.domain.Message;
import vn.nhom18.shoppingclothes.domain.MessageHistory;
import vn.nhom18.shoppingclothes.domain.User;
import vn.nhom18.shoppingclothes.repository.MessageHistoryRepository;
import vn.nhom18.shoppingclothes.repository.MessageRepository;
import vn.nhom18.shoppingclothes.repository.UserRepository;

@Service
public class MessageService {

    private final MessageHistoryRepository messageHistoryRepository;
    private final MessageRepository messageRepository;
    private final UserRepository userRepository;

    public MessageService(MessageHistoryRepository messageHistoryRepository, MessageRepository messageRepository,
            UserRepository userRepository) {
        this.messageHistoryRepository = messageHistoryRepository;
        this.messageRepository = messageRepository;
        this.userRepository = userRepository;
    }

    public long countMessagesForUser(Long userId) {
        return messageRepository.countByReceiverId(userId); // Đếm số tin nhắn gửi đến admin
    }

    // Lấy các tin nhắn lịch sử (chỉ cần lấy 5 tin nhắn gần nhất)
    public List<MessageHistory> getRecentMessagesForUser(Long receiverId) {
        List<MessageHistory> recentMessages = messageHistoryRepository.findByMessageReceiverId(receiverId);
        return recentMessages.stream()
                .sorted(Comparator.comparing(MessageHistory::getTimestamp).reversed()) // Sắp xếp tin nhắn mới nhất lên
                                                                                       // đầu
                .limit(5) // Lấy tối đa 5 tin nhắn
                .collect(Collectors.toList());
    }

    public List<MessageHistory> getRecentMessagesForAdmin(long adminId) {
        // Truy vấn để lấy tin nhắn mới nhất của từng người gửi đến adminId
        List<MessageHistory> messages = messageHistoryRepository.findLatestMessagesForAdmin(adminId);

        // Kiểm tra xem messages có rỗng không
        if (messages.isEmpty()) {
            System.out.println("No messages found for adminId: " + adminId);
        }

        return messages;
    }

    public List<MessageHistory> getMessagesForUser(Long userId) {
        // Lấy danh sách các user gửi tin nhắn đến admin
        List<Message> messages = messageRepository.findMessagesByReceiverId(userId);

        List<MessageHistory> recentMessages = new ArrayList<>();

        // Lặp qua các tin nhắn của từng người gửi và lấy tin nhắn mới nhất
        for (Message message : messages) {
            // Lấy tất cả MessageHistory của một tin nhắn
            List<MessageHistory> histories = messageHistoryRepository.findByMessageId(message.getId());

            // Sắp xếp theo timestamp và lấy tin nhắn mới nhất
            MessageHistory latestMessage = histories.stream()
                    .max(Comparator.comparing(MessageHistory::getTimestamp))
                    .orElse(null);

            if (latestMessage != null) {
                recentMessages.add(latestMessage);
            }
        }

        return recentMessages;
    }

    // Lấy tất cả tin nhắn của một user
    public List<MessageHistory> getAllMessagesFromUser(Long userId, Long adminId) {
        // Lấy tất cả các Message mà admin và user đã trao đổi
        List<Message> messages = messageRepository.findBySenderIdAndReceiverId(userId, adminId);
    
        // Lấy tất cả lịch sử tin nhắn từ các message này
        List<MessageHistory> messageHistories = new ArrayList<>();
        for (Message message : messages) {
            messageHistories.addAll(messageHistoryRepository.findByMessageId(message.getId()));
        }
    
        return messageHistories;
    }
    

    // Phản hồi tin nhắn
    public void replyToMessage(Long userId, Long adminId, String content) {
        // Lấy user và admin từ cơ sở dữ liệu
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        User admin = userRepository.findById(adminId).orElseThrow(() -> new RuntimeException("Admin not found"));

        // Tạo hoặc tìm Message giữa user và admin
        Message message = messageRepository.findByReceiverIdAndSenderId(userId, adminId);

        // Nếu chưa có tin nhắn giữa user và admin, tạo một tin nhắn mới
        if (message == null) {
            message = new Message();
            message.setSender(admin); // Admin gửi tin nhắn
            message.setReceiver(user); // User nhận tin nhắn
            message.setTimestamp(LocalDateTime.now());
            message.setIsRead(false);
            messageRepository.save(message); // Lưu tin nhắn mới vào cơ sở dữ liệu
        }

        // Tạo bản ghi tin nhắn mới (MessageHistory)
        MessageHistory messageHistory = new MessageHistory();
        messageHistory.setMessage(message); // Liên kết với Message
        messageHistory.setSender(admin); // Admin gửi phản hồi
        messageHistory.setContent(content);
        messageHistory.setTimestamp(LocalDateTime.now());
        messageHistory.setIsRead(false);

        // Lưu vào bảng MessageHistory
        messageHistoryRepository.save(messageHistory);
    }

    public List<MessageHistory> getAllMessagesFromAdmin(Long userId, Long adminId) {
        // Tìm tất cả tin nhắn mà admin đã gửi cho user
        List<Message> messages = messageRepository.findBySenderIdAndReceiverId(adminId, userId);

        // Lấy lịch sử tin nhắn từ các message_id
        List<MessageHistory> messageHistories = messageHistoryRepository.findByMessageId(messages.get(0).getId());

        return messageHistories;
    }

  
}
