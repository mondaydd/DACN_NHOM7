<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Chi Tiết Sản Phẩm</title>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
                    rel="stylesheet">

                <style>
                    .product-image {
                        max-width: 100%;
                        height: auto;
                        border-radius: 5px;
                    }

                    .product-details {
                        background-color: #f8f9fa;
                        padding: 30px;
                        border-radius: 8px;
                        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                    }

                    .product-header {
                        background-color: #343a40;
                        color: white;
                        padding: 10px 20px;
                        border-radius: 5px;
                    }

                    .btn-primary {
                        background-color: #007bff;
                        border-color: #007bff;
                    }

                    .product-title {
                        font-size: 2rem;
                        font-weight: bold;
                        color: #333;
                    }

                    .product-price {
                        font-size: 1.5rem;
                        color: #e83e8c;
                        font-weight: bold;
                    }

                    .product-description {
                        font-size: 1.1rem;
                        color: #6c757d;
                        word-wrap: break-word;
                    }

                    .product-info p {
                        font-size: 1rem;
                        margin-bottom: 10px;
                    }

                    .back-btn {
                        margin-top: 20px;
                    }

                    .short-desc-container {
                        margin-top: 15px;
                        word-wrap: break-word;
                    }

                    .image-gallery {
                        display: flex;
                        gap: 10px;
                    }

                    .image-gallery img {
                        max-width: 80px;
                        max-height: 80px;
                        cursor: pointer;
                    }

                    .product-color-size {
                        margin-top: 20px;
                    }

                    .product-color-size label {
                        font-weight: bold;
                    }

                    /* Modal Styling */
                    .modal-content {
                        border-radius: 10px;
                    }

                    .modal-body img {
                        max-width: 100%;
                        height: auto;
                        border-radius: 10px;
                    }

                    /* Thu nhỏ ảnh trong bảng thông tin chi tiết */
                    .product-detail-image {
                        max-width: 60px;
                        /* Thu nhỏ kích thước hình ảnh */
                        max-height: 60px;
                        cursor: pointer;
                    }

                    .pagination .btn-pagination {
                        background-color: #007bff;
                        color: white;
                        padding: 10px 20px;
                        border-radius: 30px;
                        text-decoration: none;
                        font-size: 16px;
                        transition: background-color 0.3s ease, transform 0.2s ease;
                        display: inline-flex;
                        align-items: center;
                    }

                    .pagination .btn-pagination:hover {
                        background-color: #0056b3;
                        transform: scale(1.05);
                    }

                    .pagination .btn-prev {
                        margin-right: 15px;
                    }

                    .pagination .btn-next {
                        margin-left: 15px;
                    }

                    .pagination i {
                        margin: 0 5px;
                    }
                </style>
            </head>

            <body>
                <div class="container mt-5">
                    <h2 class="product-title mb-4">Chi Tiết Sản Phẩm</h2>
                    <div class="card product-details">
                        <div class="card-header product-header">
                            <h4>Thông tin sản phẩm</h4>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <!-- Hình ảnh sản phẩm chính to ra -->
                                    <img id="main-image" src="/images/products/${product.image}" class="product-image"
                                        alt="${product.name}">
                                </div>
                                <div class="col-md-6 product-info">
                                    <p><strong>ID:</strong> ${product.id}</p>
                                    <p><strong>Tên sản phẩm:</strong> ${product.name}</p>
                                    <p class="product-price"><strong>Giá:</strong> ${product.price} VND</p>
                                    <p><strong>Ngày tạo:</strong> ${product.createDate}</p>
                                    <p><strong>Danh mục:</strong> ${product.category.name}</p>
                                </div>
                            </div>

                            <div class="short-desc-container">
                                <h5><strong>Mô tả ngắn:</strong></h5>
                                <p>${product.shortDesc}</p>
                            </div>

                            <div class="mt-4">
                                <h5><strong>Mô tả chi tiết:</strong></h5>
                                <p class="product-description">${product.detailDesc}</p>
                            </div>

                            <!-- Phân trang thông tin chi tiết về sản phẩm -->
                            <h5 class="mt-4"><strong>Thông tin chi tiết về sản phẩm:</strong></h5>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Size</th>
                                        <th>Màu sắc</th>
                                        <th>Số lượng</th>
                                        <th>Hình ảnh</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="detail" items="${productDetailsPage.content}">
                                        <tr>
                                            <td>${detail.size.name}</td>
                                            <td>${detail.color.name}</td>
                                            <td>${detail.quantity}</td>
                                            <td><img src="/images/productDetails/${detail.imageDetail}" alt="Image"
                                                    class="product-detail-image"
                                                    onclick="showProductDetail('${detail.imageDetail}', '${detail.size.name}', '${detail.color.name}', ${detail.quantity})">
                                            </td>
                                            <td><button class="btn btn-info" data-toggle="modal"
                                                    data-target="#productDetailModal"
                                                    onclick="showModal('${detail.imageDetail}', '${detail.size.name}', '${detail.color.name}', ${detail.quantity})">Xem
                                                    chi tiết</button></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                            <!-- Phân trang -->
                            <div class="pagination text-center mt-4">
                                <c:if test="${productDetailsPage.hasPrevious()}">
                                    <a href="/admin/product/detail/${product.id}?page=${productDetailsPage.number - 1}&size=${productDetailsPage.size}"
                                        class="btn btn-pagination btn-prev">
                                        <i class="fas fa-chevron-left"></i> Trước
                                    </a>
                                </c:if>
                                <c:if test="${productDetailsPage.hasNext()}">
                                    <a href="/admin/product/detail/${product.id}?page=${productDetailsPage.number + 1}&size=${productDetailsPage.size}"
                                        class="btn btn-pagination btn-next">
                                        Sau <i class="fas fa-chevron-right"></i>
                                    </a>
                                </c:if>
                            </div>

                            <div class="back-btn text-center">
                                <a href="/admin/product" class="btn btn-primary btn-lg">Trở về danh sách sản phẩm</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal chi tiết sản phẩm -->
                <div class="modal fade" id="productDetailModal" tabindex="-1" aria-labelledby="productDetailModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="productDetailModalLabel">Chi tiết sản phẩm</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <img id="modal-image" src="" class="product-image" alt="Detail Image">
                                <p><strong>Size:</strong> <span id="modal-size"></span></p>
                                <p><strong>Màu sắc:</strong> <span id="modal-color"></span></p>
                                <p><strong>Số lượng:</strong> <span id="modal-quantity"></span></p>
                            </div>
                        </div>
                    </div>
                </div>

                <script>
                    function showProductDetail(imageUrl, size, color, quantity) {
                        document.getElementById("main-image").src = imageUrl;
                        document.getElementById("main-image").onclick = function () { showOriginalImage() };
                    }

                    // Show modal with product detail
                    function showModal(imageUrl, size, color, quantity) {
                        document.getElementById("modal-image").src = imageUrl;
                        document.getElementById("modal-size").innerText = size;
                        document.getElementById("modal-color").innerText = color;
                        document.getElementById("modal-quantity").innerText = quantity;
                    }

                    // Quay lại ảnh ban đầu
                    function showOriginalImage() {
                        document.getElementById("main-image").src = "${product.image}";
                        document.getElementById("main-image").onclick = function () { showOriginalImage() };
                    }
                </script>

                <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
            </body>

            </html>