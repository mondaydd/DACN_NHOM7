<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Quản lý tài khoản</title>
            <!-- Thêm Font Awesome -->
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
            <style>
                body {
                    font-family: Arial, sans-serif;
                    margin: 20px;
                }

                .profile-container {
                    max-width: 600px;
                    margin: 0 auto;
                    text-align: center;
                }

                .profile-container img {
                    width: 150px;
                    height: 150px;
                    border-radius: 50%;
                    margin-bottom: 20px;
                }

                .profile-container p {
                    font-size: 16px;
                    line-height: 1.5;
                    margin-bottom: 10px;
                }

                .profile-container .btn {
                    padding: 10px 20px;
                    margin-top: 20px;
                    background-color: #007bff;
                    color: white;
                    border: none;
                    border-radius: 5px;
                    text-decoration: none;
                    display: inline-block;
                }

                .profile-container .btn:hover {
                    background-color: #0056b3;
                }

                .profile-container .btn i {
                    margin-right: 8px;
                }

                .back-btn {
                    background-color: #28a745;
                }

                .back-btn:hover {
                    background-color: #218838;
                }
            </style>
        </head>

        <body>
            <div class="profile-container">
                <h2>Thông tin tài khoản</h2>

                <!-- User Avatar -->
                <img src="/images/avatar/${sessionScope.avatar}" alt="Avatar">

                <!-- User Details -->
                <p><i class="fas fa-user"></i><strong>Tên:</strong> ${sessionScope.name}</p>
                <p><i class="fas fa-envelope"></i><strong>Email:</strong> ${sessionScope.email}</p>
                <p><i class="fas fa-map-marker-alt"></i><strong>Địa chỉ:</strong> ${sessionScope.address}</p>
                <p><i class="fas fa-phone-alt"></i><strong>Số điện thoại:</strong> ${sessionScope.phone}</p>

                <!-- You can add more user details as needed here -->

                <!-- Account Management Link (For Editing/Update) -->
                <a href="/user/edit-account" class="btn"><i class="fas fa-edit"></i>Chỉnh sửa thông tin</a>

                <!-- Logout Button -->
                <form method="post" action="/logout" style="margin-top: 20px;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button type="submit" class="btn"><i class="fas fa-sign-out-alt"></i>Đăng xuất</button>
                </form>

                <!-- Back to Home Button -->
                <a href="/" class="btn back-btn"><i class="fas fa-home"></i>Trở về trang chủ</a>
            </div>
        </body>

        </html>