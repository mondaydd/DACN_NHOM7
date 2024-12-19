<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Thêm sản phẩm</title>
            <link rel="stylesheet" href="/css/bootstrap.min.css">
            <style>
                .image-preview {
                    max-width: 300px;
                    max-height: 300px;
                    margin-top: 15px;
                    border: 1px solid #ddd;
                    padding: 10px;
                    display: none;
                    object-fit: contain;
                }

                .form-actions {
                    display: flex;
                    justify-content: center;
                    gap: 15px;
                    margin-top: 20px;
                }

                .text-danger {
                    color: red;
                }

                .select2-container {
                    width: 100% !important;
                }

                .select2-selection {
                    height: calc(2.25rem + 2px);
                    display: flex;
                    align-items: center;
                }
            </style>
        </head>

        <body>
            <div class="container mt-5">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white text-center">
                        <h3>Thêm sản phẩm mới</h3>
                    </div>
                    <div class="card-body">
                        <!-- Form thêm sản phẩm -->
                        <form action="/admin/product/create" method="post" enctype="multipart/form-data"
                            id="productForm">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <!-- Tên sản phẩm -->
                            <div class="form-group">
                                <label for="name"><strong>Tên sản phẩm</strong></label>
                                <input type="text" name="name" id="name" class="form-control"
                                    placeholder="Nhập tên sản phẩm" value="${product.name}">
                                <div id="nameError" class="text-danger mt-2"></div>
                            </div>

                            <!-- Giá sản phẩm -->
                            <div class="form-group mt-3">
                                <label for="price"><strong>Giá sản phẩm</strong></label>
                                <input type="number" name="price" id="price" class="form-control"
                                    placeholder="Nhập giá sản phẩm" value="${product.price}">
                                <div id="priceError" class="text-danger mt-2"></div>
                            </div>

                            <!-- Hình ảnh sản phẩm -->
                            <div class="form-group mt-3">
                                <label for="imageFile"><strong>Hình ảnh sản phẩm</strong></label>
                                <input type="file" name="imageFile" id="imageFile" class="form-control" accept="image/*"
                                    onchange="previewImage(event)">
                                <img id="imagePreview" class="image-preview" alt="Xem trước hình ảnh">
                            </div>

                            <!-- Mô tả ngắn -->
                            <div class="form-group mt-3">
                                <label for="shortDesc"><strong>Mô tả ngắn</strong></label>
                                <textarea name="shortDesc" id="shortDesc" class="form-control"
                                    placeholder="Nhập mô tả ngắn" rows="3">${product.shortDesc}</textarea>
                                <div id="shortDescError" class="text-danger mt-2"></div>
                            </div>

                            <!-- Mô tả chi tiết -->
                            <div class="form-group mt-3">
                                <label for="detailDesc"><strong>Mô tả chi tiết</strong></label>
                                <textarea name="detailDesc" id="detailDesc" class="form-control"
                                    placeholder="Nhập mô tả chi tiết" rows="5">${product.detailDesc}</textarea>
                                <div id="detailDescError" class="text-danger mt-2"></div>
                            </div>

                            <!-- Danh mục -->
                            <div class="form-group mt-3">
                                <label for="category"><strong>Danh mục</strong></label>
                                <select name="category.id" id="category" class="form-control">
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.id}">${category.name}</option>
                                    </c:forEach>
                                </select>
                                <div id="categoryError" class="text-danger mt-2"></div>
                            </div>

                            <!-- Nút hành động -->
                            <div class="form-actions">
                                <a href="/admin/product" class="btn btn-secondary">Trở về</a>
                                <button type="submit" class="btn btn-success">Lưu sản phẩm</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Bootstrap JS -->
            <script src="/js/bootstrap.bundle.min.js"></script>

            <!-- JavaScript xử lý form -->
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    const form = document.getElementById("productForm");
                    const nameField = document.getElementById("name");
                    const priceField = document.getElementById("price");
                    const shortDescField = document.getElementById("shortDesc");
                    const detailDescField = document.getElementById("detailDesc");

                    // Kiểm tra từng trường
                    nameField.addEventListener("input", () => validateField(nameField, "nameError", "Tên sản phẩm không được để trống."));
                    priceField.addEventListener("input", () => validateFieldWithCondition(priceField, "priceError", "Giá sản phẩm phải lớn hơn 0.", (value) => value > 0));
                    shortDescField.addEventListener("input", () => validateField(shortDescField, "shortDescError", "Mô tả ngắn không được để trống."));
                    detailDescField.addEventListener("input", () => validateField(detailDescField, "detailDescError", "Mô tả chi tiết không được để trống."));

                    function validateField(field, errorId, errorMessage) {
                        const errorElement = document.getElementById(errorId);
                        errorElement.innerText = field.value.trim() ? "" : errorMessage;
                    }

                    function validateFieldWithCondition(field, errorId, errorMessage, condition) {
                        const errorElement = document.getElementById(errorId);
                        const value = parseFloat(field.value);
                        errorElement.innerText = (isNaN(value) || !condition(value)) ? errorMessage : "";
                    }

                    // Hiển thị hình ảnh xem trước
                    window.previewImage = function (event) {
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
                            preview.src = "";
                            preview.style.display = "none";
                        }
                    };

                    // Xử lý gửi form
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
                            event.preventDefault(); // Ngừng gửi form nếu có lỗi
                        }
                    });
                });
            </script>
        </body>

        </html>