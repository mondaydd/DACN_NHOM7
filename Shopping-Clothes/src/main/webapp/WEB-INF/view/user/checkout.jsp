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
                    <style>
                        .discount-table-wrapper {
                            max-height: 150px;

                            overflow-y: auto;

                        }

                        /* .remove-discount {
                            display: inline-block !important;
                        } */
                    </style>
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
                                                    <img src="/images/productDetails/${item.productDetail.imageDetail}"
                                                        alt="" style="width: 80px;">
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
                                                    <form
                                                        action="${pageContext.request.contextPath}/cart/delete-cart-product/${item.id}"
                                                        method="post" style="display:inline;">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <button type="submit" class="btn btn-danger btn-sm">
                                                            <i class="fas fa-trash-alt"></i> Xoá
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <!-- Danh sách mã giảm giá -->
                                <div class="mt-5">
                                    <h3 class="mb-3">Mã giảm giá</h3>
                                    <div class="discount-table-wrapper">
                                        <table class="table table-bordered text-center">
                                            <thead class="table-secondary">
                                                <tr>
                                                    <th>Mã</th>
                                                    <th>Phần trăm giảm</th>
                                                    <th>Giảm tối đa</th>
                                                    <th>Ngày bắt đầu</th>
                                                    <th>Ngày kết thúc</th>
                                                    <th>Áp dụng</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:choose>
                                                    <c:when test="${empty discounts}">
                                                        <tr>
                                                            <td colspan="6" class="text-center text-muted">
                                                                <i class="bi bi-info-circle"></i> Không có mã giảm giá
                                                                khả dụng
                                                            </td>
                                                        </tr>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach var="discount" items="${discounts}">
                                                            <tr>
                                                                <td>${discount.code}</td>
                                                                <td>${discount.discountPercent}%</td>
                                                                <td>${discount.maxDiscount} đ</td>
                                                                <td>${discount.startDate}</td>
                                                                <td>${discount.endDate}</td>
                                                                <td>
                                                                    <c:if test="${discount.quantity > 0}">
                                                                        <button type="button"
                                                                            class="btn btn-primary btn-sm apply-discount"
                                                                            data-discount-code="${discount.code}">
                                                                            <i class="fas fa-tag"></i> Áp dụng
                                                                        </button>
                                                                        <!-- Nút bỏ chọn mã giảm giá, ban đầu ẩn -->
                                                                        <button type="button"
                                                                            class="btn btn-danger btn-sm remove-discount"
                                                                            style="display:none;">
                                                                            <i class="fas fa-times-circle"></i> Bỏ chọn
                                                                            mã giảm giá
                                                                        </button>
                                                                    </c:if>
                                                                    <c:if test="${discount.quantity <= 0}">
                                                                        <span class="out-of-stock">Đã hết</span>
                                                                    </c:if>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <div class="text-end">
                                            <h5>Tổng tiền ban đầu: <strong>${totalPrice} đ</strong></h5>
                                            <h5 class="discount-amount">
                                                <c:if test="${not empty sessionScope.discountAmount}">
                                                    Giảm giá: <strong>- ${sessionScope.discountAmount} đ</strong>
                                                </c:if>
                                            </h5>
                                            <h4 class="final-price">
                                                <c:if test="${not empty sessionScope.finalPrice}">
                                                    Tổng thanh toán: <strong>${sessionScope.finalPrice} đ</strong>
                                                </c:if>
                                            </h4>


                                        </div>


                                        <c:if test="${not empty cartDetails}">
                                            <form:form action="/place-order" method="post" modelAttribute="cart">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <div class="mt-3 row g-4">
                                                    <!-- Cột bên trái -->
                                                    <div class="col-12 col-md-7">
                                                        <a href="/cart" class="btn btn-outline-secondary">
                                                            <i class="fas fa-arrow-left"></i> Quay lại giỏ hàng
                                                        </a>
                                                    </div>
                                                    <!-- Cột bên phải -->
                                                    <div class="col-12 col-md-5 d-flex justify-content-end">
                                                        <div class="row">
                                                            <div class="col-12 form-group mb-3">
                                                                <h5>Thông Tin Người Nhận</h5>
                                                            </div>
                                                            <div class="col-12 form-group mb-3">
                                                                <label>Tên người nhận</label>
                                                                <input class="form-control" name="receiverName"
                                                                    required />
                                                            </div>
                                                            <div class="col-12 form-group mb-3">
                                                                <label>Địa chỉ người nhận</label>
                                                                <input class="form-control" name="receiverAddress"
                                                                    required />
                                                            </div>
                                                            <div class="col-12 form-group mb-3">
                                                                <label>Số điện thoại</label>
                                                                <input class="form-control" name="receiverPhone"
                                                                    required />
                                                            </div>
                                                            <div class="col-12 form-group mb-3">
                                                                <label>Hình thức thanh toán</label>
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="radio"
                                                                        name="paymentMethod" value="COD" id="COD"
                                                                        checked>
                                                                    <label class="form-check-label" for="COD">
                                                                        Thanh toán khi nhận hàng
                                                                    </label>
                                                                </div>
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="radio"
                                                                        name="paymentMethod" value="BANKING"
                                                                        id="BANKING">
                                                                    <label class="form-check-label" for="BANKING">
                                                                        Thanh toán bằng ví VNPAY
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <c:if test="${empty sessionScope.finalPrice}">
                                                                <c:set var="finalPrice" value="${totalPrice}" scope="session" />
                                                            </c:if>
                                                            
                                                            <input style="display: none;"
                                                                value="${sessionScope.finalPrice}" name="totalPrice" />

                                                            <div class="col-12 form-group mb-3">
                                                                <button class="btn btn-success">
                                                                    <i class="fas fa-credit-card"></i> Thanh toán
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form:form>
                                        </c:if>
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
                    <script>
                        $(document).ready(function () {

                            $(".remove-discount").hide();

                            $(document).on("click", ".apply-discount", function () {
                                const discountCode = $(this).data("discount-code");
                                var $currentButton = $(this);

                                $.ajax({
                                    url: "/apply-discount",
                                    method: "POST",
                                    data: {
                                        discountCode: discountCode,
                                        _csrf: $('input[name="_csrf"]').val()
                                    },
                                    success: function (response) {

                                        if (response.discountAmount && response.finalPrice) {
                                            $(".discount-amount").text("- " + response.discountAmount + " đ");
                                            $(".final-price").text("Tổng thanh toán: " + response.finalPrice + " đ");

                                            $currentButton.hide();
                                            $currentButton.closest("td").find(".remove-discount").show();
                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        const errorMessage = xhr.responseJSON?.error || "Có lỗi xảy ra khi áp dụng mã giảm giá. Vui lòng thử lại!";
                                        alert(errorMessage);
                                    }
                                });
                            });

                            $(document).on("click", ".remove-discount", function () {
                                var $currentButton = $(this);

                                $.ajax({
                                    url: "/remove-discount",
                                    method: "POST",
                                    data: {
                                        _csrf: $('input[name="_csrf"]').val()
                                    },
                                    success: function (response) {

                                        if (response.finalPrice) {
                                            $(".discount-amount").text("");
                                            $(".final-price").text("Tổng thanh toán: " + response.finalPrice + " đ");
                                        }

                                        $currentButton.hide();
                                        $currentButton.closest("td").find(".apply-discount").show();

                                        alert(response.message);
                                    },
                                    error: function (xhr, status, error) {
                                        const errorMessage = xhr.responseJSON?.error || "Có lỗi xảy ra khi bỏ mã giảm giá. Vui lòng thử lại!";
                                        alert(errorMessage);
                                    }
                                });
                            });

                            // Khi rời khỏi trang, reset lại tổng thanh toán và bỏ mã giảm giá
                            window.onbeforeunload = function () {
                                $.ajax({
                                    url: "/reset-discount",
                                    method: "POST",
                                    data: {
                                        _csrf: $('input[name="_csrf"]').val()
                                    },
                                    success: function (response) {
                                        // Cập nhật lại giao diện nếu cần thiết
                                        $(".discount-amount").text("");
                                        $(".final-price").text("Tổng thanh toán: " + response.totalPrice + " đ");
                                    },
                                    error: function (xhr, status, error) {
                                        console.error("Có lỗi xảy ra khi reset mã giảm giá.");
                                    }
                                });
                            };
                        });
                    </script>




                    </script>
                </body>

                </html>