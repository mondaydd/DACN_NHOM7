package vn.nhom18.shoppingclothes.domain.dto;

import java.time.LocalDateTime;

public class ChatMessage {
    private long senderId; // ID của người gửi
    private long receiverId; // ID của người nhận
    private String content; // Nội dung tin nhắn
    private String timestampString;

    public ChatMessage(long senderId, long receiverId, String content) {
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.content = content;
        this.timestampString = LocalDateTime.now().toString(); // Set timestamp automatically
    }

    // Getters và Setters
    public long getSenderId() {
        return senderId;
    }

    public void setSenderId(long senderId) {
        this.senderId = senderId;
    }

    public long getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(long receiverId) {
        this.receiverId = receiverId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTimestampString() {
        return timestampString;
    }

    public void setTimestampString(String timestampString) {
        this.timestampString = timestampString;
    }
}
