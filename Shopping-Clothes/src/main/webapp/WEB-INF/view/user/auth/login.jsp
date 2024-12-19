<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        body {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            /* Gradient background */
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

        .form-container {
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 420px;
            transition: transform 0.3s ease-in-out;
        }

        .form-container:hover {
            transform: translateY(-10px);
            /* Hover effect */
        }

        .form-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            justify-content: center;
        }

        .form-header h2 {
            margin-left: 15px;
            color: #333;
            font-size: 28px;
            text-transform: uppercase;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .form-header img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            /* Logo hình tròn */
            border: 2px solid #2575fc;
        }

        .btn-primary {
            background-color: #2575fc;
            border: none;
            padding: 12px 24px;
            width: 100%;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .btn-primary:hover {
            background-color: #6a11cb;
        }

        .form-footer {
            text-align: center;
            margin-top: 15px;
        }

        .form-footer a {
            text-decoration: none;
            color: #2575fc;
        }

        .form-footer a:hover {
            text-decoration: underline;
        }

        .form-container .form-control {
            border-radius: 10px;
        }

        /* Error messages */
        .my-2 {
            font-size: 14px;
            font-weight: bold;
        }

        .form-control:focus {
            box-shadow: 0 0 10px rgba(37, 117, 252, 0.6);
            border-color: #2575fc;
        }

        .form-container .form-control.is-invalid {
            border-color: #e74a3b;
        }

        .form-container .invalid-feedback {
            display: block;
            color: #e74a3b;
            font-size: 13px;
        }

    </style>
</head>

<body>
    <div class="form-container">
        <div class="form-header">
            <!-- Logo hình tròn -->
            <img src="/images/products/steaven_logo.webp" alt="Logo">
            <h2>Steaven</h2>
        </div>

        <form method="post" action="/login">
            <c:if test="${param.error != null}">
                <div class="my-2" style="color: red;">
                    <i class="fas fa-exclamation-circle"></i> Thông tin email hoặc mật khẩu không chính xác.
                </div>
            </c:if>
            <c:if test="${param.logout != null}">
                <div class="my-2" style="color: rgb(0, 255, 94);">
                    <i class="fas fa-check-circle"></i> Bạn đã đăng xuất thành công.
                </div>
            </c:if>
            <!-- Email -->
            <div class="mb-3">
                <label for="email" class="form-label"><i class="fas fa-envelope"></i> Email</label>
                <input type="email" name="username" id="email" class="form-control" required placeholder="Nhập email của bạn">
            </div>
            <!-- Password -->
            <div class="mb-3">
                <label for="password" class="form-label"><i class="fas fa-lock"></i> Mật khẩu</label>
                <input type="password" name="password" id="password" class="form-control" required placeholder="Nhập mật khẩu">
            </div>
            <div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </div>
            <!-- Login Button -->
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-sign-in-alt"></i> Đăng nhập
                </button>
            </div>
        </form>

        <!-- Registration Link -->
        <div class="form-footer">
            <p>Bạn chưa có tài khoản? <a href="/register"><i class="fas fa-user-plus"></i> Đăng ký</a></p>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
