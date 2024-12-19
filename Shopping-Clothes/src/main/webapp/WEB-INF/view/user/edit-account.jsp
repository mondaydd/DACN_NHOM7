<%@ page contentType="text/html; charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <title>Chỉnh sửa tài khoản</title>
            <!-- Thêm Font Awesome để sử dụng các icon -->
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
            <style>
                body {
                    font-family: Arial, sans-serif;
                    margin: 20px;
                }

                .edit-form-container {
                    max-width: 600px;
                    margin: 0 auto;
                    padding: 20px;
                    background-color: #f9f9f9;
                    border-radius: 5px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                }

                .edit-form-container input {
                    width: 100%;
                    padding: 10px;
                    margin: 10px 0;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                }

                .edit-form-container .btn {
                    padding: 10px 20px;
                    background-color: #007bff;
                    color: white;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                }

                .edit-form-container .btn:hover {
                    background-color: #0056b3;
                }

                .avatar-preview {
                    width: 100px;
                    height: 100px;
                    border-radius: 50%;
                    margin-bottom: 20px;
                    object-fit: cover;
                }

                .back-btn {
                    background-color: #28a745;
                    margin-top: 20px;
                }

                .back-btn:hover {
                    background-color: #218838;
                }

                .edit-form-container .btn i {
                    margin-right: 8px;
                }
            </style>
        </head>

        <body>
            <div class="edit-form-container">
                <h2>Chỉnh sửa thông tin tài khoản</h2>
                <form action="/user/update-account" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="hidden" name="userId" value="${userId}" />

                    <!-- Tên -->
                    <div>
                        <label for="name"><i class="fas fa-user"></i> Tên:</label>
                        <input type="text" id="name" name="name" value="${name}" required />
                    </div>

                    <!-- Email -->
                    <div>
                        <label for="email"><i class="fas fa-envelope"></i> Email:</label>
                        <input type="email" id="email" name="email" value="${email}" readonly required />
                    </div>

                    <!-- Địa chỉ -->
                    <div>
                        <label for="address"><i class="fas fa-map-marker-alt"></i> Địa chỉ:</label>
                        <input type="text" id="address" name="address" value="${address}" required />
                    </div>

                    <!-- Số điện thoại -->
                    <div>
                        <label for="phone"><i class="fas fa-phone-alt"></i> Số điện thoại:</label>
                        <input type="text" id="phone" name="phone" value="${phone}" required />
                    </div>

                    <!-- Avatar -->
                    <div>
                        <label for="avatar"><i class="fas fa-image"></i> Avatar:</label>
                        <!-- Hiển thị ảnh avatar hiện tại nếu có -->
                        <img src="${avatar != null ? avatar : '/images/default-avatar.jpg'}" class="avatar-preview"
                            alt="Avatar Preview" id="avatarPreview" />
                        <input type="file" id="avatar" name="avatar" accept="image/*" onchange="previewAvatar(event)" />
                    </div>

                    <!-- Mật khẩu cũ -->
                    <div>
                        <label for="oldPassword"><i class="fas fa-key"></i> Mật khẩu cũ:</label>
                        <input type="password" id="oldPassword" name="oldPassword" placeholder="Nhập mật khẩu cũ" />
                    </div>

                    <!-- Mật khẩu mới -->
                    <div>
                        <label for="newPassword"><i class="fas fa-key"></i> Mật khẩu mới:</label>
                        <input type="password" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới" />
                    </div>

                    <button type="submit" class="btn"><i class="fas fa-save"></i> Lưu thay đổi</button>
                </form>

                <!-- Nút "Trở về trang trước" -->
                <a href="javascript:history.back()" class="btn back-btn"><i class="fas fa-arrow-left"></i> Trở về trang
                    trước</a>
            </div>

            <!-- Script để hiển thị ảnh avatar khi chọn file -->
            <script>
                function previewAvatar(event) {
                    const file = event.target.files[0];
                    const reader = new FileReader();

                    reader.onload = function () {
                        const avatarPreview = document.getElementById('avatarPreview');
                        avatarPreview.src = reader.result;
                    }

                    if (file) {
                        reader.readAsDataURL(file);
                    }
                }
            </script>
        </body>

        </html>