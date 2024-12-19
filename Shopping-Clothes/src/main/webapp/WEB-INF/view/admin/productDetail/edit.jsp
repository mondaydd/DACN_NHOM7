<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Chỉnh sửa chi tiết sản phẩm</title>
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
                    <h2 class="text-center">Chỉnh sửa chi tiết sản phẩm</h2>
                    <hr>

                    <!-- Hiển thị thông báo lỗi -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <!-- Hiển thị thông báo thành công -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>

                    <form action="/admin/productDetail/edit/${productDetail.id}" method="post"
                        enctype="multipart/form-data">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <!-- Chọn sản phẩm -->
                        <div class="mb-3">
                            <label for="product" class="form-label">Sản Phẩm</label>
                            <select id="product" name="product.id" class="form-control" required>
                                <c:forEach var="product" items="${products}">
                                    <option value="${product.id}" ${product.id==productDetail.product.id ? 'selected'
                                        : '' }>
                                        ${product.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Nhập số lượng -->
                        <div class="mb-3">
                            <label for="quantity" class="form-label">Số Lượng</label>
                            <input type="number" id="quantity" name="quantity" class="form-control" min="1" required
                                value="${productDetail.quantity}">
                        </div>

                        <!-- Chọn kích cỡ -->
                        <div class="mb-3">
                            <label for="size" class="form-label">Kích Cỡ</label>
                            <select id="size" name="size.id" class="form-control" required>
                                <c:forEach var="size" items="${sizes}">
                                    <option value="${size.id}" ${size.id==productDetail.size.id ? 'selected' : '' }>
                                        ${size.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Chọn màu sắc -->
                        <div class="mb-3">
                            <label for="color" class="form-label">Màu Sắc</label>
                            <select id="color" name="color.id" class="form-control" required>
                                <c:forEach var="color" items="${colors}">
                                    <option value="${color.id}" ${color.id==productDetail.color.id ? 'selected' : '' }>
                                        ${color.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Hình ảnh hiện tại -->
                        <div class="mb-3">
                            <label class="form-label">Hình Ảnh Hiện Tại</label>
                            <div class="preview-container">
                                <img src="${productDetail.imageDetail}" alt="Hình ảnh chi tiết">
                            </div>
                        </div>

                        <!-- Tải lên hình ảnh mới -->
                        <div class="mb-3">
                            <label for="imageFile" class="form-label">Hình Ảnh Mới (Tùy chọn)</label>
                            <input type="file" id="imageFile" name="imageFile" class="form-control" accept="image/*">
                        </div>

                        <!-- Nút hành động -->
                        <div class="d-flex justify-content-between">
                            <button type="submit" class="btn btn-primary">Cập Nhật</button>
                            <a href="/admin/productDetail" class="btn btn-secondary">Quay Lại</a>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                // Hiển thị preview hình ảnh mới
                document.getElementById('imageFile').addEventListener('change', function (event) {
                    const previewContainer = document.querySelector('.preview-container img');
                    const file = event.target.files[0];
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function (e) {
                            previewContainer.src = e.target.result;
                        };
                        reader.readAsDataURL(file);
                    }
                });
            </script>
        </body>

        </html>