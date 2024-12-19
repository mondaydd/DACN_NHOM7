<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Giỏ hàng</title>

                    <!-- Google Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com" />
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet" />

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet" />

                    <!-- Libraries Stylesheet -->
                    <link href="${pageContext.request.contextPath}/lib-user/lightbox/css/lightbox.min.css"
                        rel="stylesheet" />
                    <link href="${pageContext.request.contextPath}/lib-user/owlcarousel/assets/owl.carousel.min.css"
                        rel="stylesheet" />
                    <link
                        href="${pageContext.request.contextPath}/lib-user/owlcarousel/assets/owl.theme.default.min.css"
                        rel="stylesheet">
                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="${pageContext.request.contextPath}/css-user/bootstrap.min.css" rel="stylesheet" />

                    <!-- Template Stylesheet -->
                    <link href="${pageContext.request.contextPath}/css-user/style.css" rel="stylesheet" />
                </head>

                <body>
                    <!-- Include header -->
                    <jsp:include page="/WEB-INF/view/user/layout/header.jsp" />

                    <div class="container py-5" style="margin-top: 130px;">
                        <h2 class="text-center mb-4">Giỏ hàng của bạn</h2>

                        <c:choose>
                            <c:when test="${empty cartDetails}">
                                <div class="alert alert-warning text-center">
                                    <i class="fas fa-shopping-cart"></i> Giỏ hàng của bạn đang trống.
                                    <br>
                                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-3">
                                        <i class="fas fa-arrow-left"></i> Tiếp tục mua sắm
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <table class="table table-bordered">
                                    <thead class="table-dark text-center">
                                        <tr>
                                            <th>Hình ảnh</th>
                                            <th>Sản phẩm</th>
                                            <th>Kích thước</th>
                                            <th>Màu sắc</th>
                                            <th>Giá</th>
                                            <th>Số lượng</th>
                                            <th>Tổng</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${cartDetails}">
                                            <tr>
                                                <td class="text-center">
                                                    <img src="/images/productDetails/${item.productDetail.imageDetail}" alt=""
                                                        style="width: 80px;">
                                                </td>
                                                <td>${item.productDetail.product.name}</td>
                                                <td>${item.size}</td>
                                                <td>${item.color}</td>
                                                <td>${item.productDetail.product.price}</td>
                                                <td>
                                                    <div class="input-group quantity1" style="width: 100px;">
                                                        <div class="input-group-btn">
                                                            <button
                                                                class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                                <i class="fa fa-minus"></i>
                                                            </button>
                                                        </div>
                                                        <input type="text"
                                                            class="form-control form-control-sm text-center border-0"
                                                            value="${item.quantity}" data-cart-detail-id="${item.id}"
                                                            data-cart-detail-store="${item.productDetail.quantity}"
                                                            data-cart-detail-price="${item.price}"
                                                            data-cart-detail-index="${status.index}">
                                                        <div class="input-group-btn">
                                                            <button
                                                                class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                                <i class="fa fa-plus"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <p data-cart-detail-id="${item.id}">
                                                        ${item.productDetail.product.price * item.quantity} đ
                                                    </p>
                                                </td>
                                                <td class="text-center">
                                                    <form method="post" action="/delete-cart-product/${item.id}">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <button class="btn btn-danger btn-sm">
                                                            <i class="fas fa-trash-alt"></i> Xoá
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <div class="d-flex justify-content-between align-items-center mt-4">
                                    <a href="${pageContext.request.contextPath}/products"
                                        class="btn btn-outline-secondary">
                                        <i class="fas fa-arrow-left"></i> Tiếp tục mua sắm
                                    </a>
                                    <div class="text-end">
                                        <h5>
                                            Tổng tiền:
                                            <p class="mb-0 pe-4" data-cart-total-price="${totalPrice}"
                                                style="display: inline-block;">
                                                <input type="number" class="h5" value="${totalPrice}"
                                                    style="display: none;" />
                                                ${totalPrice} đ
                                            </p>
                                        </h5>

                                        <form:form action="/confirm-checkout" method="post" modelAttribute="cart">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <div style="display: none;">
                                                <c:forEach var="cartDetail" items="${cart.cartDetails}"
                                                    varStatus="status">
                                                    <div class="mb-3">
                                                        <div class="form-group">
                                                            <label>Id:</label>
                                                            <form:input class="form-control" type="text"
                                                                value="${cartDetail.id}"
                                                                path="cartDetails[${status.index}].id" />
                                                        </div>
                                                        <div class="form-group">
                                                            <label>Quantity:</label>
                                                            <form:input class="form-control" type="text"
                                                                value="${cartDetail.quantity}"
                                                                path="cartDetails[${status.index}].quantity" />
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <button class="btn btn-success mt-2">
                                                <i class="fas fa-credit-card"></i> Thanh toán
                                            </button>
                                        </form:form>

                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Include footer -->
                    <jsp:include page="/WEB-INF/view/user/layout/footer.jsp" />

                    <!-- Scripts -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="${pageContext.request.contextPath}/lib-user/easing/easing.min.js"></script>
                    <script src="${pageContext.request.contextPath}/lib-user/waypoints/waypoints.min.js"></script>
                    <script src="${pageContext.request.contextPath}/lib-user/lightbox/js/lightbox.min.js"></script>
                    <script src="${pageContext.request.contextPath}/lib-user/owlcarousel/owl.carousel.min.js"></script>
                    <script src="${pageContext.request.contextPath}/js-user/main.js"></script>
                </body>

                </html>