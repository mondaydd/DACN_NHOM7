<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ page contentType="text/html" pageEncoding="UTF-8" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Chỉnh Sửa Mã Giảm Giá</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
                    rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
                <style>
                    body {
                        animation: fadeIn 1s ease-in-out;
                    }

                    @keyframes fadeIn {
                        from {
                            opacity: 0;
                        }

                        to {
                            opacity: 1;
                        }
                    }

                    .form-container {
                        max-width: 800px;
                        margin: 50px auto;
                        padding: 20px;
                        border: 1px solid #ddd;
                        border-radius: 8px;
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                        background-color: #f9f9f9;
                    }

                    .form-heading {
                        text-align: center;
                        margin-bottom: 20px;
                        font-size: 26px;
                        color: #007bff;
                    }

                    .form-group label {
                        font-weight: bold;
                    }

                    .btn-submit {
                        width: 100%;
                        font-size: 18px;
                    }

                    .btn:hover {
                        transform: scale(1.05);
                        transition: 0.3s ease;
                    }

                    .form-control:focus {
                        border-color: #007bff;
                        box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
                    }

                    .btn-back {
                        margin-top: 10px;
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <div class="form-container">
                        <div class="form-heading">
                            <i class="bi bi-pencil-square"></i> Chỉnh Sửa Mã Giảm Giá
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

                        <!-- Form chỉnh sửa mã giảm giá -->
                        <form:form method="POST" action="/admin/discount/edit" modelAttribute="discount"
                            class="bg-light p-4 border rounded shadow">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <form:input path="id" type="hidden" />
                            <div class="mb-3">
                                <label for="code" class="form-label">Mã Giảm Giá</label>
                                <form:input path="code" id="code" class="form-control" placeholder="Nhập mã giảm giá"
                                    required="true" readonly="true" />
                                <form:errors path="code" class="text-danger" />
                            </div>

                            <div class="mb-3">
                                <label for="discountPercent" class="form-label">Phần Trăm Giảm Giá (%)</label>
                                <form:input path="discountPercent" id="discountPercent" class="form-control"
                                    type="number" min="0" max="100" placeholder="Nhập phần trăm giảm giá"
                                    required="true" />
                                <form:errors path="discountPercent" class="text-danger" />
                            </div>

                            <div class="mb-3">
                                <label for="maxDiscount" class="form-label">Giảm Giá Tối Đa (VND)</label>
                                <form:input path="maxDiscount" id="maxDiscount" class="form-control" type="number"
                                    placeholder="Nhập giá trị giảm giá tối đa" required="true" />
                                <form:errors path="maxDiscount" class="text-danger" />
                            </div>

                            <div class="mb-3">
                                <label for="quantity" class="form-label">Số Lượng Mã Giảm Giá</label>
                                <form:input path="quantity" id="quantity" class="form-control" type="number" min="0"
                                    placeholder="Nhập số lượng mã giảm giá" required="true" />
                                <form:errors path="quantity" class="text-danger" />
                            </div>

                            <div class="mb-3">
                                <label for="startDate" class="form-label">Ngày Bắt Đầu</label>
                                <form:input path="startDate" id="startDate" class="form-control" type="datetime-local"
                                    required="true" />
                                <form:errors path="startDate" class="text-danger" />
                            </div>

                            <div class="mb-3">
                                <label for="endDate" class="form-label">Ngày Kết Thúc</label>
                                <form:input path="endDate" id="endDate" class="form-control" type="datetime-local"
                                    required="true" />
                                <form:errors path="endDate" class="text-danger" />
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Mô Tả</label>
                                <form:textarea path="description" id="description" class="form-control"
                                    placeholder="Nhập mô tả cho mã giảm giá"></form:textarea>
                            </div>

                            <div class="d-flex justify-content-between">
                                <button type="submit" class="btn btn-primary">Cập Nhật</button>
                                <a href="/admin/discount/manage" class="btn btn-secondary">Quay lại</a>
                            </div>
                        </form:form> <!-- Make sure this is properly closed -->

                    </div>
                </div>
            </body>

            </html>