<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Register</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f4f6f9;
        }

        .card {
            border: none;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
        }

        .card-header {
            background-color: #007bff;
            color: #fff;
            border-radius: 15px 15px 0 0;
            text-align: center;
        }

        .form-floating label {
            font-size: 1.2rem;
            color: #495057;
        }

        .form-control {
            border-radius: 10px;
        }

        .form-control.is-invalid {
            border-color: #e74a3b;
        }

        .invalid-feedback {
            display: block;
            color: #e74a3b;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
            border-radius: 10px;
            font-size: 1.2rem;
            padding: 0.8rem;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            transform: translateY(-3px);
        }

        .small a {
            color: #007bff;
            font-weight: bold;
            transition: color 0.3s;
        }

        .small a:hover {
            color: #0056b3;
        }

        .card-footer {
            background-color: #f8f9fa;
            border-radius: 0 0 15px 15px;
        }

        .form-floating input:focus,
        .form-floating textarea:focus {
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            border-color: #007bff;
        }
    </style>
</head>

<body>
    <div id="layoutAuthentication">
        <div id="layoutAuthentication_content">
            <main>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-7">
                            <div class="card shadow-lg border-0 rounded-lg mt-5">
                                <div class="card-header">
                                    <h3 class="font-weight-light my-4">
                                        <i class="fas fa-user-plus"></i> Đăng ký tài khoản
                                    </h3>
                                </div>
                                <div class="card-body">
                                    <form:form method="post" action="/register" modelAttribute="registerUser">
                                        <c:set var="errorPassword">
                                            <form:errors path="confirmPassword" cssClass="invalid-feedback" />
                                        </c:set>
                                        <c:set var="errorEmail">
                                            <form:errors path="email" cssClass="invalid-feedback" />
                                        </c:set>
                                        <c:set var="errorFirstName">
                                            <form:errors path="firstName" cssClass="invalid-feedback" />
                                        </c:set>

                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <form:input
                                                        class="form-control ${not empty errorFirstName ? 'is-invalid' : ''}"
                                                        type="text" placeholder="Enter your first name" path="firstName" />
                                                    <label for="inputFirstName"><i class="fas fa-user"></i> Họ đệm</label>
                                                    ${errorFirstName}
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-floating">
                                                    <form:input class="form-control" type="text"
                                                        placeholder="Enter your last name" path="lastName" />
                                                    <label for="inputLastName"><i class="fas fa-user"></i> Tên</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-floating mb-3">
                                            <form:input
                                                class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                                type="email" placeholder="name@example.com" path="email" />
                                            <label><i class="fas fa-envelope"></i> Địa chỉ Email</label>
                                            ${errorEmail}
                                        </div>
                                        <div class="form-floating mb-3">
                                            <form:input
                                                class="form-control ${not empty errorAddress ? 'is-invalid' : ''}"
                                                type="text" placeholder="Nhập địa chỉ" path="address" />
                                            <label><i class="fas fa-home"></i> Địa chỉ</label>
                                            ${errorAddress}
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <form:input
                                                        class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                                        type="password" placeholder="Create a password" path="password" />
                                                    <label><i class="fas fa-lock"></i> Mật khẩu</label>
                                                    ${errorPassword}
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <form:input class="form-control" type="password"
                                                        placeholder="Confirm password" path="confirmPassword" />
                                                    <label><i class="fas fa-lock"></i> Xác nhận mật khẩu</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="mt-4 mb-0">
                                            <div class="d-grid">
                                                <button class="btn btn-primary btn-block">
                                                    <i class="fas fa-user-plus"></i> Tạo tài khoản
                                                </button>
                                            </div>
                                        </div>
                                    </form:form>
                                </div>
                                <div class="card-footer text-center py-3">
                                    <div class="small"><a href="/login"><i class="fas fa-sign-in-alt"></i> Bạn đã có tài
                                        khoản? Đăng nhập</a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="/js/scripts.js"></script>
</body>

</html>
