<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Thêm Mã Giảm Giá</title>
                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
                    rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
                <style>
                    .form-container {
                        max-width: 800px;
                        margin: 50px auto;
                    }

                    .form-container .form-heading {
                        text-align: center;
                        margin-bottom: 30px;
                        font-size: 28px;
                        font-weight: bold;
                        color: #4CAF50;
                    }

                    .form-container .form-group label {
                        font-weight: bold;
                    }

                    .form-container .btn-submit {
                        width: 100%;
                        font-size: 18px;
                    }

                    .btn-back {
                        margin-top: 10px;
                    }

                    .alert-dismissible .btn-close {
                        padding: 0.3rem 0.5rem;
                    }

                    .form-control:invalid {
                        border-color: #dc3545;
                    }

                    .form-control:valid {
                        border-color: #28a745;
                    }

                    .error-message {
                        color: #dc3545;
                        font-size: 0.875rem;
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <div class="form-container">
                        <div class="form-heading">
                            <i class="bi bi-plus-circle"></i> Thêm Mã Giảm Giá
                        </div>

                        <!-- Hiển thị thông báo thành công nếu có -->
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${successMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"
                                    aria-label="Close"></button>
                            </div>
                        </c:if>

                        <!-- Hiển thị thông báo lỗi nếu có -->
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${errorMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"
                                    aria-label="Close"></button>
                            </div>
                        </c:if>

                        <!-- Form tạo mã giảm giá -->
                        <form:form method="POST" action="/admin/discount/create" modelAttribute="discount"
                            class="bg-light p-4 border rounded shadow">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <div class="mb-3">
                                <label for="code" class="form-label">Mã Giảm Giá</label>
                                <form:input path="code" id="code" class="form-control" placeholder="Nhập mã giảm giá"
                                    required="true" />
                                <form:errors path="code" class="error-message" />
                            </div>

                            <div class="mb-3">
                                <label for="discountPercent" class="form-label">Phần Trăm Giảm Giá (%)</label>
                                <form:input path="discountPercent" id="discountPercent" class="form-control"
                                    type="number" min="0" max="100" placeholder="Nhập phần trăm giảm giá"
                                    required="true" />
                                <form:errors path="discountPercent" class="error-message" />
                            </div>

                            <div class="mb-3">
                                <label for="maxDiscount" class="form-label">Giảm Giá Tối Đa (VND)</label>
                                <form:input path="maxDiscount" id="maxDiscount" class="form-control" type="number"
                                    placeholder="Nhập giá trị giảm giá tối đa" required="true" />
                                <form:errors path="maxDiscount" class="error-message" />
                            </div>

                            <div class="mb-3">
                                <label for="quantity" class="form-label">Số Lượng Mã Giảm Giá</label>
                                <form:input path="quantity" id="quantity" class="form-control" type="number" min="0"
                                    placeholder="Nhập số lượng mã giảm giá" required="true" />
                                <form:errors path="quantity" class="error-message" />
                            </div>

                            <div class="mb-3">
                                <label for="startDate" class="form-label">Ngày Bắt Đầu</label>
                                <form:input path="startDate" id="startDate" class="form-control" type="datetime-local"
                                    required="true" />
                                <form:errors path="startDate" class="error-message" />
                            </div>

                            <div class="mb-3">
                                <label for="endDate" class="form-label">Ngày Kết Thúc</label>
                                <form:input path="endDate" id="endDate" class="form-control" type="datetime-local"
                                    required="true" />
                                <form:errors path="endDate" class="error-message" />
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Mô Tả</label>
                                <form:textarea path="description" id="description" class="form-control" rows="4"
                                    placeholder="Nhập mô tả cho mã giảm giá"></form:textarea>
                                <form:errors path="description" class="error-message" />
                            </div>

                            <button type="submit" class="btn btn-success btn-submit">
                                <i class="bi bi-check-circle"></i> Tạo Mã Giảm Giá
                            </button>

                            <!-- Nút trở về trang quản lý -->
                            <a href="/admin/discount/manage" class="btn btn-secondary btn-back">
                                <i class="bi bi-arrow-left-circle"></i> Quay lại
                            </a>
                        </form:form>
                    </div>
                </div>

                <!-- Bootstrap JS & Dependencies -->
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
            </body>

            </html>