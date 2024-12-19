<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Thêm Chi Tiết Sản Phẩm</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <style>
                body {
                    background-color: #f8f9fa;
                }

                .form-container {
                    background-color: #ffffff;
                    padding: 2rem;
                    border-radius: 10px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                }

                .preview-container img {
                    max-width: 300px;
                    max-height: 300px;
                    object-fit: cover;
                    border: 1px solid #ddd;
                    border-radius: 10px;
                }
            </style>
        </head>

        <body>
            <div class="container mt-5">
                <div class="form-container">
                    <h2 class="text-center">Thêm Chi Tiết Sản Phẩm</h2>
                    <hr>

                    <!-- Hiển thị thông báo lỗi -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <!-- Hiển thị thông báo thành công -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>

                    <form action="/admin/productDetail/create" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <!-- Chọn sản phẩm -->
                        <div class="mb-3">
                            <label for="product" class="form-label">Sản Phẩm</label>
                            <select id="product" name="product.id" class="form-control" required>
                                <option value="">Chọn sản phẩm</option>
                                <c:forEach var="product" items="${products}">
                                    <option value="${product.id}">
                                        ${product.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Nhập số lượng -->
                        <div class="mb-3">
                            <label for="quantity" class="form-label">Số Lượng Chi Tiết</label>
                            <input type="number" id="quantity" name="quantity" class="form-control" min="1" required>
                        </div>

                        <!-- Chọn kích cỡ -->
                        <div class="mb-3">
                            <label for="size" class="form-label">Kích Cỡ</label>
                            <select id="size" name="size.id" class="form-control" required>
                                <option value="">Chọn kích cỡ</option>
                                <c:forEach var="size" items="${sizes}">
                                    <option value="${size.id}">
                                        ${size.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Chọn màu sắc -->
                        <div class="mb-3">
                            <label for="color" class="form-label">Màu Sắc</label>
                            <select id="color" name="color.id" class="form-control" required>
                                <option value="">Chọn màu sắc</option>
                                <c:forEach var="color" items="${colors}">
                                    <option value="${color.id}">
                                        ${color.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Chọn hình ảnh -->
                        <div class="mb-3">
                            <label for="imageFile" class="form-label">Hình Ảnh Chi Tiết</label>
                            <input type="file" id="imageFile" name="imageFile" class="form-control" accept="image/*"
                                onchange="previewImage(event)">
                            <div class="preview-container">
                                <img id="preview" src="" alt="Hình ảnh chi tiết" style="display: none;">
                            </div>
                        </div>

                        <!-- Nút thêm chi tiết -->
                        <div class="d-flex justify-content-between">
                            <button type="submit" class="btn btn-primary">Thêm Chi Tiết</button>
                            <a href="/admin/productDetail" class="btn btn-secondary">Quay lại</a>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                function previewImage(event) {
                    const preview = document.getElementById('preview');
                    const file = event.target.files[0];
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            preview.src = e.target.result;
                            preview.style.display = 'block';
                        };
                        reader.readAsDataURL(file);
                    } else {
                        preview.src = '';
                        preview.style.display = 'none';
                    }
                }
            </script>
        </body>

        </html>