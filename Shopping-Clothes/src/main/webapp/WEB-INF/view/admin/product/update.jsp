<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Sửa Sản Phẩm</title>
            <link rel="stylesheet" href="/css/bootstrap.min.css">
            <style>
                .image-preview {
                    max-width: 300px;
                    max-height: 300px;
                    margin-top: 15px;
                    border: 1px solid #ddd;
                    padding: 10px;
                    display: none;
                }

                .form-actions {
                    display: flex;
                    justify-content: center;
                    gap: 20px;
                    margin-top: 20px;
                }

                .form-group label {
                    font-weight: bold;
                }

                .text-danger {
                    font-size: 0.9rem;
                }
            </style>
        </head>

        <body>
            <div class="container mt-5">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white text-center">
                        <h3>Sửa Sản Phẩm</h3>
                    </div>
                    <div class="card-body">
                        <form id="updateProductForm" action="/admin/product/update/${product.id}" method="post"
                            enctype="multipart/form-data">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <div class="form-group">
                                <label for="name">Tên sản phẩm</label>
                                <input type="text" name="name" id="name" class="form-control" value="${product.name}"
                                    required>
                                <div id="nameError" class="text-danger mt-2"></div>
                            </div>

                            <div class="form-group mt-3">
                                <label for="price">Giá sản phẩm</label>
                                <input type="number" name="price" id="price" class="form-control"
                                    value="${product.price}" required>
                                <div id="priceError" class="text-danger mt-2"></div>
                            </div>

                            <div class="form-group mt-3">
                                <label for="imageFile">Hình ảnh sản phẩm</label>
                                <input type="file" name="imageFile" id="imageFile" class="form-control"
                                    onchange="previewImage(event)">
                                <img id="imagePreview" class="image-preview" src="/images/${product.image}"
                                    alt="Xem trước hình ảnh">
                            </div>

                            <div class="form-group mt-3">
                                <label for="shortDesc">Mô tả ngắn</label>
                                <textarea name="shortDesc" id="shortDesc" class="form-control" rows="3"
                                    required>${product.shortDesc}</textarea>
                                <div id="shortDescError" class="text-danger mt-2"></div>
                            </div>

                            <div class="form-group mt-3">
                                <label for="detailDesc">Mô tả chi tiết</label>
                                <textarea name="detailDesc" id="detailDesc" class="form-control" rows="5"
                                    required>${product.detailDesc}</textarea>
                                <div id="detailDescError" class="text-danger mt-2"></div>
                            </div>

                            <div class="form-group mt-3">
                                <label for="category">Danh mục</label>
                                <select name="category.id" id="category" class="form-control">
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.id}" ${category.id==product.category.id ? 'selected'
                                            : '' }>
                                            ${category.name}</option>
                                    </c:forEach>
                                </select>
                                <div id="categoryError" class="text-danger mt-2"></div>
                            </div>

                            <div class="form-actions">
                                <a href="/admin/product" class="btn btn-secondary">Trở về</a>
                                <button type="submit" class="btn btn-success">Cập nhật sản phẩm</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Bootstrap JS -->
            <script src="/js/bootstrap.bundle.min.js"></script>

            <!-- JavaScript kiểm tra tính hợp lệ và xem trước hình ảnh -->
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const form = document.getElementById("updateProductForm");
                    const nameField = document.getElementById("name");
                    const priceField = document.getElementById("price");
                    const shortDescField = document.getElementById("shortDesc");
                    const detailDescField = document.getElementById("detailDesc");
                    const categoryField = document.getElementById("category");

                    // Kiểm tra và xóa thông báo lỗi khi nhập đúng
                    nameField.addEventListener("input", () => validateField(nameField, "nameError", "Tên sản phẩm không được để trống."));
                    priceField.addEventListener("input", () => validateFieldWithCondition(priceField, "priceError", "Giá sản phẩm phải lớn hơn 0.", (value) => value > 0));
                    shortDescField.addEventListener("input", () => validateField(shortDescField, "shortDescError", "Mô tả ngắn không được để trống."));
                    detailDescField.addEventListener("input", () => validateField(detailDescField, "detailDescError", "Mô tả chi tiết không được để trống."));

                    function validateField(field, errorId, errorMessage) {
                        const errorElement = document.getElementById(errorId);
                        if (!field.value.trim()) {
                            errorElement.innerText = errorMessage;
                        } else {
                            errorElement.innerText = ""; // Xóa thông báo lỗi khi hợp lệ
                        }
                    }

                    function validateFieldWithCondition(field, errorId, errorMessage, condition) {
                        const errorElement = document.getElementById(errorId);
                        const value = parseFloat(field.value);
                        if (isNaN(value) || !condition(value)) {
                            errorElement.innerText = errorMessage;
                        } else {
                            errorElement.innerText = ""; // Xóa thông báo lỗi khi hợp lệ
                        }
                    }

                    // Xử lý xem trước hình ảnh
                    function previewImage(event) {
                        const input = event.target;
                        const preview = document.getElementById("imagePreview");

                        if (input.files && input.files[0]) {
                            const reader = new FileReader();

                            reader.onload = function (e) {
                                preview.src = e.target.result;
                                preview.style.display = "block";
                            };

                            reader.readAsDataURL(input.files[0]);
                        } else {
                            preview.style.display = "none";
                        }
                    }

                    // Kiểm tra và gửi form
                    form.addEventListener("submit", function (event) {
                        let valid = true;

                        if (!nameField.value.trim()) {
                            document.getElementById("nameError").innerText = "Tên sản phẩm không được để trống.";
                            valid = false;
                        }

                        const priceValue = parseFloat(priceField.value);
                        if (isNaN(priceValue) || priceValue <= 0) {
                            document.getElementById("priceError").innerText = "Giá sản phẩm phải lớn hơn 0.";
                            valid = false;
                        }

                        if (!shortDescField.value.trim()) {
                            document.getElementById("shortDescError").innerText = "Mô tả ngắn không được để trống.";
                            valid = false;
                        }

                        if (!detailDescField.value.trim()) {
                            document.getElementById("detailDescError").innerText = "Mô tả chi tiết không được để trống.";
                            valid = false;
                        }

                        if (!valid) {
                            event.preventDefault(); // Dừng gửi form nếu có lỗi
                        }
                    });
                });
            </script>
        </body>

        </html>