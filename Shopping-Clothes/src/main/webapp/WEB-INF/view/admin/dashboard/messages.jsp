<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page contentType="text/html; charset=UTF-8" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Danh sách tin nhắn</title>
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
                rel="stylesheet" />
            <!-- Font Awesome for icons -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
                rel="stylesheet" />
            <style>
                body {
                    background-color: #f8f9fa;
                    font-family: 'Arial', sans-serif;
                }

                .list-group-item {
                    transition: transform 0.2s ease, box-shadow 0.2s ease;
                }

                .list-group-item:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                }

                .btn {
                    transition: background-color 0.3s ease, transform 0.3s ease;
                }

                .btn:hover {
                    transform: scale(1.05);
                }

                .btn-primary {
                    background-color: #007bff;
                    border-color: #007bff;
                }

                .btn-primary:hover {
                    background-color: #0056b3;
                    border-color: #0056b3;
                }

                .back-home-btn {
                    margin-top: 20px;
                }

                .message-avatar {
                    border-radius: 50%;
                    border: 2px solid #ddd;
                    padding: 5px;
                }

                .message-item {
                    border-radius: 10px;
                    padding: 15px;
                    background-color: #fff;
                    margin-bottom: 15px;
                    transition: all 0.3s ease;
                }

                .message-item:hover {
                    background-color: #f1f1f1;
                }
            </style>
        </head>

        <body>
            <div class="container mt-5">
                <h2 class="text-center mb-4">Danh sách tin nhắn của bạn</h2>

                <!-- List of messages -->
                <div class="list-group">
                    <c:forEach var="messageHistory" items="${recentMessages}">
                        <div class="list-group-item message-item d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center">
                                <!-- Avatar người gửi -->
                                <img src="/images/avatar/${messageHistory.sender.avatar}" alt="avatar"
                                    class="message-avatar" width="50" height="50">
                                <div class="ms-3">
                                    <h5>${messageHistory.sender.name}</h5>
                                    <p class="mb-0 text-muted">${messageHistory.content}</p>
                                </div>
                            </div>

                            <!-- Đường dẫn tới trang chi tiết tin nhắn của người gửi -->
                            <a href="/admin/dashboard/messages/${messageHistory.sender.id}"
                                class="btn btn-primary btn-sm">
                                <i class="fas fa-eye"></i> Xem chi tiết
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <!-- Xem tất cả tin nhắn -->
                <div class="mt-3 d-flex justify-content-between">

                    <a href="/admin" class="btn btn-info back-home-btn">
                        <i class="fas fa-home"></i> Quay về trang chủ
                    </a>
                </div>
            </div>

            <!-- Bootstrap JS and Popper.js -->
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
        </body>

        </html>