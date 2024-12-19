package vn.nhom18.shoppingclothes.controller.user;

import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.nhom18.shoppingclothes.domain.Message;
import vn.nhom18.shoppingclothes.domain.MessageHistory;
import vn.nhom18.shoppingclothes.domain.User;

import vn.nhom18.shoppingclothes.repository.MessageHistoryRepository;
import vn.nhom18.shoppingclothes.repository.MessageRepository;
import vn.nhom18.shoppingclothes.repository.UserRepository;

@Controller
public class ChatController {

    private final UserRepository userRepository;
    private final MessageRepository messageRepository;
    private final MessageHistoryRepository messageHistoryRepository;

    public ChatController(UserRepository userRepository, MessageRepository messageRepository,
            MessageHistoryRepository messageHistoryRepository) {
        this.userRepository = userRepository;
        this.messageRepository = messageRepository;
        this.messageHistoryRepository = messageHistoryRepository;
    }

    @GetMapping("/user/contact")
    public String showContactPage(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        long userId = (long) session.getAttribute("id");
        User user = userRepository.findById(userId);

        // Lấy tất cả tin nhắn của user
        List<MessageHistory> allMessages = messageHistoryRepository.findBySenderIdOrReceiverId(userId);

        // Lọc trùng lặp dựa trên content và thời gian (trong khoảng 5 giây)
        List<MessageHistory> distinctMessages = allMessages.stream()
                .sorted((m1, m2) -> m1.getTimestamp().compareTo(m2.getTimestamp())) // Sắp xếp theo thời gian
                .filter(new java.util.function.Predicate<MessageHistory>() {
                    private final List<MessageHistory> seenMessages = new ArrayList<>();

                    @Override
                    public boolean test(MessageHistory message) {
                        for (MessageHistory seenMessage : seenMessages) {
                            // Kiểm tra nếu cùng content và trong khoảng 5 giây
                            if (seenMessage.getContent().equals(message.getContent())
                                    && Math.abs(seenMessage.getTimestamp().toEpochSecond(ZoneOffset.UTC)
                                            - message.getTimestamp().toEpochSecond(ZoneOffset.UTC)) <= 5) {
                                return false; // Loại bỏ tin nhắn trùng
                            }
                        }

                        // Nếu không trùng lặp, thêm vào danh sách đã kiểm tra
                        seenMessages.add(message);
                        return true;
                    }
                })
                .collect(Collectors.toList());

        model.addAttribute("messages", distinctMessages);
        model.addAttribute("user", user);

        return "user/contact";
    }

    @PostMapping("/user/sendMessage")
    public String sendMessage(@RequestParam String content, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        long userId = (long) session.getAttribute("id");
        User sender = userRepository.findById(userId);

        // Lấy tất cả admin
        List<User> admins = userRepository.findAllByRole_Name("ADMIN");
        if (admins.isEmpty()) {
            // Xử lý nếu không có admin nào
            return "redirect:/user/contact?error=noAdmin";
        }

        // Tạo và lưu tin nhắn cho từng admin
        for (User admin : admins) {
            Message message = new Message();
            message.setSender(sender);
            message.setReceiver(admin); // Gửi tin nhắn đến từng admin
            message.setTimestamp(LocalDateTime.now());

            MessageHistory messageHistory = new MessageHistory();
            messageHistory.setSender(sender);
            messageHistory.setContent(content);
            messageHistory.setTimestamp(LocalDateTime.now());
            messageHistory.setMessage(message);

            messageRepository.save(message);
            messageHistoryRepository.save(messageHistory);
        }

        return "redirect:/user/contact";
    }

}
