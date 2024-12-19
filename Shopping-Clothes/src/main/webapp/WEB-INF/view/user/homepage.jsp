<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <title>Steamen - Thời trang</title>
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <meta content="" name="keywords" />
            <meta content="" name="description" />

            <!-- Google Web Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com" />
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
            <link
                href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                rel="stylesheet" />

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
                .product-card {
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                    height: 100%;
                }

                .image-card-content {
                    height: 400px;
                    /* Cố định chiều cao của ảnh */
                    overflow: hidden;
                }

                .image-card-content img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

                .short-desc {
                    min-height: 50px;
                    /* Chiều cao tối thiểu cho mô tả ngắn */
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .card-body {
                    display: flex;
                    flex-direction: column;
                }

                .card-body h5,
                .card-body p {
                    margin-bottom: 10px;
                }

                .card-body .btn {
                    margin-top: 10px;
                }

                .pagination {
                    text-align: center;
                    margin-top: 20px;
                }

                .pagination a {
                    display: inline-block;
                    padding: 10px 15px;
                    margin: 0 5px;
                    border: 1px solid #ddd;
                    color: #4CAF50;
                    text-decoration: none;
                    border-radius: 5px;
                }

                .pagination a.active {
                    background-color: #4CAF50;
                    color: white;
                    border: none;
                }

                .pagination a:hover {
                    background-color: #ddd;
                }
            </style>



        </head>

        <body>
            <jsp:include page="/WEB-INF/view/user/layout/header.jsp" />
            <!-- Slider Section -->
            <div style="margin-top: 200px;">
                <div class="container-hompage mt-5 py-5">
                    <h2 class="text-center text-black mb-2">Ảnh nổi bật</h2>
                    <div class="owl-carousel owl-theme">
                        <div class="item">
                            <img src="${pageContext.request.contextPath}/images/slide-1.webp" class="img-fluid"
                                alt="Ảnh 1">
                        </div>
                        <div class="item">
                            <img src="${pageContext.request.contextPath}/images/slide-2.jpg" class="img-fluid"
                                alt="Ảnh 2">
                        </div>
                        <div class="item">
                            <img src="${pageContext.request.contextPath}/images/slide-3.webp" class="img-fluid"
                                alt="Ảnh 3">
                        </div>
                        <div class="item">
                            <img src="${pageContext.request.contextPath}/images/slide-4.webp" class="img-fluid"
                                alt="Ảnh 4">
                        </div>
                    </div>
                </div>
            </div>

            <!-- Homepage Content -->
            <div class="container py-5">
                <h2 class="text-center mb-4">Sản phẩm mới</h2>
                <div class="row">
                    <!-- Kiểm tra xem có sản phẩm nào không -->
                    <c:if test="${not empty products}">
                        <c:forEach var="product" items="${products}">
                            <div class="col-lg-3 col-md-6 mb-4">
                                <div class="card h-100 text-center border product-card">
                                    <div class="image-card-content">
                                        <img src="${pageContext.request.contextPath}/images/products/${product.image}"
                                            class="card-img-top" alt="${product.name}" />
                                    </div>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title">
                                            <c:out value="${product.name}" />
                                        </h5>
                                        <p class="card-text text-muted">
                                            <c:out value="${product.price}" /> đ
                                        </p>
                                        <p class="card-text short-desc">
                                            <c:out value="${product.shortDesc}" />
                                        </p>
                                        <div class="mt-auto">
                                            <a href="${pageContext.request.contextPath}/product/detail?id=${product.id}"
                                                class="btn btn-primary"><i class="fas fa-eye"></i>Xem chi tiết</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>

                    <!-- Nếu không có sản phẩm nào -->
                    <c:if test="${empty products}">
                        <p>Không có sản phẩm nào để hiển thị.</p>
                    </c:if>
                    <div class="pagination mt-4">
                        <c:forEach var="i" begin="0" end="${totalPages - 1}">
                            <a href="?page=${i}&size=8" class="${currentPage == i ? 'active' : ''}">${i + 1}</a>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <jsp:include page="/WEB-INF/view/user/layout/footer.jsp" />

            <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
                <i class="fa fa-arrow-up"></i>
            </a>

            <!-- JavaScript Libraries -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib-user/easing/easing.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib-user/waypoints/waypoints.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib-user/lightbox/js/lightbox.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib-user/owlcarousel/owl.carousel.min.js"></script>
            <script src="${pageContext.request.contextPath}/js-user/main.js"></script>

            <script>
                $(document).ready(function () {
                    $(".owl-carousel").owlCarousel({
                        loop: true,
                        margin: 10,
                        nav: true,
                        dots: true,
                        autoplay: true,
                        autoplayTimeout: 3000,
                        responsive: {
                            0: {
                                items: 1
                            },
                            576: {
                                items: 2
                            },
                            768: {
                                items: 3
                            },
                            992: {
                                items: 4
                            }
                        }
                    });
                });

                window.onload = function () {
                    var message = "${message}";
                    var alertType = "${alertType}";

                    if (message) {
                        if (alertType === "success") {
                            alert("✅ " + message);
                        } else if (alertType === "error") {
                            alert("❌ " + message);
                        } else if (alertType === "thank") {
                            alert(message);
                        }
                    }
                };
            </script>
        </body>

        </html>