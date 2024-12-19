<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <!-- Added this line -->
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Liên Hệ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }

        .chat-box {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .message {
            display: flex;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .message .message-content {
            max-width: 70%;
            background-color: #f1f1f1;
            padding: 10px;
            border-radius: 10px;
            font-size: 16px;
            line-height: 1.5;
        }

        .message .message-time {
            font-size: 12px;
            color: #aaa;
            margin-left: 10px;
        }

        .message.user {
            justify-content: flex-end;
        }

        .message.admin .message-content {
            background-color: #e2f7d1;
        }

        .message.user .message-content {
            background-color: #d1f7f1;
        }

        .message .sender-name {
            font-weight: bold;
            color: #007bff;
            margin-right: 10px;
        }

        .form-container {
            display: flex;
            flex-direction: column;
            margin-top: 20px;
        }

        .form-container textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 16px;
            margin-bottom: 10px;
            resize: none;
        }

        .form-container button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .form-container button:hover {
            background-color: #0056b3;
        }

        .chat-history-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .chat-history {
            max-height: 400px;
            overflow-y: auto;
            padding-right: 20px;
        }

        .message-icon {
            font-size: 18px;
            margin-right: 10px;
        }

        .back-home-button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
        }

        .back-home-button:hover {
            background-color: #218838;
        }
    </style>
</head>

<body>
    <div class="chat-box">
        <h1>Chào mừng, ${user.name}</h1>

        <!-- Nút quay về trang chủ -->
        <a href="${pageContext.request.contextPath}/" class="back-home-button">
            <i class="fas fa-home"></i> Quay về Trang Chủ
        </a>

        <!-- Form to send a message -->
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/user/sendMessage" method="POST">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <textarea name="content" required placeholder="Nhập tin nhắn của bạn..."></textarea>
                <button type="submit">
                    <i class="fas fa-paper-plane"></i> Gửi tin nhắn
                </button>
            </form>
        </div>

        <!-- Display chat history -->
        <div class="chat-history">
            <div class="chat-history-title">Lịch sử trò chuyện</div>
            <c:forEach var="messageHistory" items="${messages}">
                <div class="message ${messageHistory.sender.id == user.id ? 'user' : 'admin'}">
                    <c:choose>
                        <c:when test="${messageHistory.sender.id == user.id}">
                            <div class="message-content">
                                <span class="sender-name">Bạn:</span>
                                ${messageHistory.content}
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="message-content">
                                <span class="sender-name">Quản lý:</span>
                                ${messageHistory.content}
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <div class="message-time">
                        <i class="fas fa-clock message-icon"></i>
                        <!-- Định dạng lại thời gian hiển thị -->
                        ${fn:substring(messageHistory.timestamp, 0, 10)}
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
