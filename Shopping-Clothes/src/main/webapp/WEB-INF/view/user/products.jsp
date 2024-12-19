<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Sản phẩm</title>
            <!-- Google Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

            <!-- FontAwesome Icons -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
            <!-- Icon Font Stylesheet -->
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />

            <!-- Libraries Stylesheet -->
            <link href="${pageContext.request.contextPath}/lib-user/lightbox/css/lightbox.min.css" rel="stylesheet" />
            <link href="${pageContext.request.contextPath}/lib-user/owlcarousel/assets/owl.carousel.min.css"
                rel="stylesheet" />
            <link href="${pageContext.request.contextPath}/lib-user/owlcarousel/assets/owl.theme.default.min.css"
                rel="stylesheet">
            <!-- Customized Bootstrap Stylesheet -->
            <link href="${pageContext.request.contextPath}/css-user/bootstrap.min.css" rel="stylesheet" />

            <!-- Template Stylesheet -->
            <link href="${pageContext.request.contextPath}/css-user/style.css" rel="stylesheet" />
            <style>
                /* Căn chỉnh phần container */
                .container-products {
                    margin-top: 130px;
                }

                /* Sidebar Lọc sản phẩm */
                .sidebar {
                    background-color: #f8f9fa;
                    padding: 20px;
                    border-radius: 8px;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                }



                /* Pagination */
                .pagination {
                    margin-top: 20px;
                    display: flex;
                    justify-content: center;
                    list-style: none;
                }

                .pagination a {
                    padding: 10px 15px;
                    margin: 0 5px;
                    border: 1px solid #ddd;
                    color: #007bff;
                    text-decoration: none;
                    border-radius: 5px;
                    transition: background-color 0.3s ease;
                }

                .pagination a.active {
                    background-color: #007bff;
                    color: white;
                    border: none;
                }

                .pagination a:hover {
                    background-color: #ddd;
                }

                /* Danh sách sản phẩm */
                .row {
                    display: flex;
                    flex-wrap: wrap;
                    margin: 0;
                    /* Loại bỏ khoảng cách mặc định */
                }

                .col-md-3 {
                    flex: 0 0 25%;
                    /* Chiếm đúng 1/4 chiều rộng */
                    max-width: 25%;
                }

                .card {
                    display: flex;
                    flex-direction: column;
                    height: 100%;
                }

                .card-body {
                    display: flex;
                    flex-direction: column;
                    flex-grow: 1;
                }

                /* Căn chỉnh nút ở phía dưới card */
                .card-body .btn {
                    margin-top: auto;
                    /* Đẩy nút xuống phía dưới */
                    align-self: stretch;
                    /* Đảm bảo nút rộng theo toàn bộ card */
                }

                /* Đảm bảo nút chiếm toàn bộ chiều ngang */
                .card-body .btn-primary {
                    width: 100%;
                }

                .card-title {
                    font-size: 16px;
                    font-weight: 600;
                    margin-bottom: 10px;
                }

                .card-text {
                    font-size: 14px;
                    margin-bottom: 15px;
                    color: #6c757d;
                }

                .btn {
                    align-self: center;
                }

                .card-img-top {
                    height: 300px;
                }
            </style>

        </head>

        <body>
            <jsp:include page="/WEB-INF/view/user/layout/header.jsp" />

            <!-- Main Content -->
            <div class="container-products">
                <div class="container py-5">
                    <div class="row">
                        <!-- Sidebar Lọc sản phẩm -->
                        <div class="col-12 col-lg-3 mb-4">
                            <div class="sidebar">
                                <h5>Lọc theo giá</h5>
                                <form action="${pageContext.request.contextPath}/products" method="get">
                                    <div class="mb-3">
                                        <label for="minPrice" class="form-label">Giá từ</label>
                                        <input type="number" name="minPrice" class="form-control" id="minPrice"
                                            value="${param.minPrice}">
                                    </div>
                                    <div class="mb-3">
                                        <label for="maxPrice" class="form-label">Giá đến</label>
                                        <input type="number" name="maxPrice" class="form-control" id="maxPrice"
                                            value="${param.maxPrice}">
                                    </div>
                                    <div class="mb-3">
                                        <label for="priceSort" class="form-label">Sắp xếp theo giá</label>
                                        <select name="priceSort" class="form-select">
                                            <option value="asc" ${param.priceSort=='asc' ? 'selected' : '' }>Từ thấp đến
                                                cao</option>
                                            <option value="desc" ${param.priceSort=='desc' ? 'selected' : '' }>Từ cao
                                                đến thấp</option>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-filter"></i> Lọc
                                    </button>
                                </form>
                            </div>
                        </div>


                        <!-- Danh sách sản phẩm -->
                        <div class="col-12 col-lg-9">
                            <div class="mb-4 ">
                                <form action="${pageContext.request.contextPath}/products" method="get"
                                    class="d-flex align-items-center">
                                    <input type="text" name="keyword" class="form-control me-2"
                                        style="border-radius: 25px; padding: 10px 15px; font-size: 14px; width: 300px;"
                                        placeholder="Nhập tên sản phẩm..." value="${param.keyword}">
                                    <button type="submit" class="btn btn-primary"
                                        style="border-radius: 25px; padding: 6px 16px;">
                                        <i class="fas fa-search" style="font-size: 14px; margin-right: 5px;"></i>Tìm
                                        kiếm
                                    </button>
                                </form>
                            </div>

                            <h2 class="text-center mb-4">Danh sách Sản phẩm</h2>
                            <div class="row gx-3">
                                <c:forEach var="product" items="${products}">
                                    <div class="col-6 col-md-4 col-lg-3 mb-4">
                                        <div class="card">
                                            <img src="${pageContext.request.contextPath}/images/products/${product.image}"
                                                class="card-img-top" alt="${product.name}">
                                            <div class="card-body">
                                                <h5 class="card-title">${product.name}</h5>
                                                <p class="card-text">${product.shortDesc}</p>
                                                <p class="card-text"><strong>${product.price} đ</strong></p>
                                                <a href="${pageContext.request.contextPath}/product/detail?id=${product.id}"
                                                    class="btn btn-primary">
                                                    <i class="fas fa-eye"></i> Xem chi tiết
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- Pagination -->
                    <div class="pagination">
                        <c:forEach var="i" begin="0" end="${totalPages - 1}">
                            <a href="?page=${i}&size=9&minPrice=${param.minPrice}&maxPrice=${param.maxPrice}&priceSort=${param.priceSort}"
                                class="${currentPage == i ? 'active' : ''}">${i + 1}</a>
                        </c:forEach>
                    </div>
                </div>
            </div>



            <jsp:include page="/WEB-INF/view/user/layout/footer.jsp" />

            <!-- JavaScript Libraries -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib-user/easing/easing.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib-user/waypoints/waypoints.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib-user/lightbox/js/lightbox.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib-user/owlcarousel/owl.carousel.min.js"></script>
            <script src="${pageContext.request.contextPath}/js-user/main.js"></script>
        </body>

        </html>