<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page contentType="text/html; charset=UTF-8" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Chi tiết tin nhắn</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
                rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
                rel="stylesheet">
            <style>
                .message-admin {
                    background-color: #d1e7dd;
                    color: black;
                    border-radius: 10px;
                    padding: 10px;
                    margin-bottom: 10px;
                    text-align: left;
                }

                .message-user {
                    background-color: #f8d7da;
                    color: black;
                    border-radius: 10px;
                    padding: 10px;
                    margin-bottom: 10px;
                    text-align: right;
                }
            </style>
            <script>
                function validateForm() {
                    const textarea = document.querySelector("textarea[name='content']");
                    if (!textarea.value.trim()) {
                        alert("Nội dung phản hồi không được để trống!");
                        return false;
                    }
                    return true;
                }
            </script>
        </head>

        <body>
            <div class="container mt-5">
                <h2>Chi tiết tin nhắn với khách hàng: ${user.name}</h2>

                <!-- Hiển thị tin nhắn -->
                <div class="list-group">
                    <c:forEach var="message" items="${userMessages}">
                        <div class="list-group-item ${message.sender.id == adminId ? 'message-admin' : 'message-user'}">
                            <div>
                                <strong>${message.sender.id == adminId ? "Bạn" : user.name }:</strong>
                                <p>${message.content}</p>
                                <small>${message.timestamp}</small>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Form phản hồi -->
                <form action="/admin/dashboard/messages/${user.id}/reply" method="POST" class="mt-4"
                    onsubmit="return validateForm()">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <textarea name="content" rows="3" class="form-control" placeholder="Nhập phản hồi..."></textarea>
                    <button type="submit" class="btn btn-primary mt-2">
                        <i class="fas fa-paper-plane"></i> Gửi phản hồi
                    </button>
                </form>

                <a href="/admin/dashboard/messages" class="btn btn-secondary mt-3">
                    <i class="fas fa-arrow-left"></i> Quay lại danh sách
                </a>
            </div>
        </body>

        </html>