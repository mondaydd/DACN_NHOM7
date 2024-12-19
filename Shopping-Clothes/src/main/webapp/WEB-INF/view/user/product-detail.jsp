<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Product Detail</title>

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

            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
            <style>
                /* CSS Styles */
                body {
                    font-family: 'Roboto', sans-serif;
                    background-color: #f4f4f9;
                    margin: 0;
                    padding: 0;
                }

                .product-detail {
                    max-width: 1200px;
                    margin: 50px auto;
                    background-color: #fff;
                    padding: 30px;
                    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
                    border-radius: 10px;
                    display: flex;
                    gap: 30px;
                    flex-wrap: wrap;
                    margin-top: 80px;
                    /* Tạo khoảng cách với header */
                    margin-bottom: 80px;
                    /* Tạo khoảng cách với footer */
                }

                .product-image {
                    flex: 1;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    margin-bottom: 20px;
                }

                .product-image img {
                    width: 100%;
                    max-width: 500px;
                    border-radius: 10px;
                }

                .product-info {
                    flex: 1.5;
                    max-width: 500px;
                }

                .product-info h1 {
                    font-size: 2.5rem;
                    color: #333;
                    margin-bottom: 10px;
                }

                .product-info p {
                    font-size: 1.2rem;
                    color: #555;
                }

                .product-price {
                    font-size: 1.5rem;
                    color: #28a745;
                    font-weight: bold;
                    margin: 20px 0;
                }

                .size-selection,
                .color-selection {
                    margin-bottom: 20px;
                }

                select {
                    padding: 8px;
                    font-size: 1.1rem;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                    width: 150px;
                }

                .quantity-controls {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                .quantity-controls button {
                    padding: 10px;
                    background-color: #007bff;
                    color: white;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    font-size: 1.2rem;
                }

                .quantity-controls button:hover {
                    background-color: #0056b3;
                }

                .quantity-controls input {
                    width: 60px;
                    padding: 8px;
                    font-size: 1rem;
                    text-align: center;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                    pointer-events: none;
                    /* Disable direct input */
                }

                .add-to-cart-btn {
                    padding: 12px 25px;
                    background-color: #28a745;
                    color: white;
                    border: none;
                    border-radius: 5px;
                    font-size: 1.2rem;
                    cursor: pointer;
                    width: 200px;
                    margin-top: 20px;
                    transition: background-color 0.3s ease;
                }

                .add-to-cart-btn:hover {
                    background-color: #218838;
                }

                /* Image Gallery */
                .image-gallery {
                    display: flex;
                    gap: 10px;
                    justify-content: center;
                    flex-wrap: wrap;
                    margin-top: 20px;
                }

                .image-gallery img {
                    width: 100px;
                    height: 100px;
                    object-fit: cover;
                    border-radius: 10px;
                    cursor: pointer;
                    transition: transform 0.2s;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                }

                .image-gallery img:hover {
                    transform: scale(1.1);
                }

                /* Popup Image */
                .popup-img {
                    display: none;
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background-color: rgba(0, 0, 0, 0.7);
                    justify-content: center;
                    align-items: center;
                    z-index: 1050;
                    /* Đảm bảo pop-up hiển thị trên tất cả các phần tử */
                }

                .popup-img img {
                    max-width: 80%;
                    max-height: 80%;
                    border-radius: 10px;
                }

                .popup-img .close-btn {
                    position: absolute;
                    top: 20px;
                    right: 20px;
                    font-size: 30px;
                    color: white;
                    cursor: pointer;
                }

                /* Product Detail Description */
                .product-detail-description {
                    font-size: 1.1rem;
                    color: #555;
                    white-space: normal;
                    word-wrap: break-word;
                    line-height: 1.6;
                    margin-top: 20px;

                }

                .product-detail {
                    margin-top: 200px;
                }

                .add-to-cart-btn {
                    display: flex;
                    align-items: center;
                    background-color: #28a745;
                    /* Màu xanh lá cây */
                    color: white;
                    padding: 10px 20px;
                    font-size: 16px;
                    border: none;
                    border-radius: 8px;
                    transition: background-color 0.3s ease, transform 0.3s ease;
                    cursor: pointer;
                }

                .add-to-cart-btn i {
                    margin-right: 8px;
                    /* Khoảng cách giữa icon và text */
                    font-size: 20px;
                    /* Kích thước icon */
                }

                .add-to-cart-btn:hover {
                    background-color: #218838;
                    /* Màu khi hover */
                    transform: translateY(-3px);
                    /* Hiệu ứng nổi lên khi hover */
                }

                .add-to-cart-btn:active {
                    transform: translateY(1px);
                    /* Hiệu ứng khi click */
                }
            </style>
        </head>

        <body>
            <jsp:include page="/WEB-INF/view/user/layout/header.jsp" />
            <form action="/add-to-cart" method="POST" id="addToCartForm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <div class="product-detail">
                    <div class="product-image">
                        <img id="mainImage" src="/images/products/${product.image}" alt="${product.name}">
                    </div>
                    <div class="product-info">
                        <h1>${product.name}</h1>
                        <p>Mô tả ngắn: ${product.shortDesc}</p>
                        <div class="product-price" id="productPrice">Giá: ${product.price} VND</div>
                        <div class="size-selection">
                            <label for="size">Kích cỡ:</label>
                            <select id="size" name="size">
                                <c:forEach var="size" items="${sizes}">
                                    <option value="${size.id}">${size.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="color-selection">
                            <label for="color">Màu sắc:</label>
                            <select id="color" name="color">
                                <c:forEach var="color" items="${colors}">
                                    <option value="${color.id}">${color.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <p>Số lượng còn lại trong kho: <span id="availableQuantity">0</span></p>

                        <div class="quantity-controls">
                            <button type="button" id="decreaseQuantity"><i class="fas fa-minus"></i></button>
                            <input type="text" id="quantity" name="quantity" value="0" readonly>
                            <button type="button" id="increaseQuantity"><i class="fas fa-plus"></i></button>
                        </div>

                        <!-- Thêm các trường hidden để gửi thông tin cần thiết khi submit -->
                        <input type="hidden" id="productId" name="id" value="${product.id}">
                        <button type="submit" class="add-to-cart-btn" id="addToCart">
                            <i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng
                        </button>

                        <p class="product-detail-description">Mô tả chi tiết: ${product.detailDesc}</p>

                        <!-- Image Gallery moved here -->
                        <p style="font-weight: bold;">Hình ảnh chi tiết</p>
                        <div class="image-gallery">
                            <c:forEach var="detail" items="${product.productDetails}">
                                <img src="/images/productDetails/${detail.imageDetail}" alt="Product Detail"
                                    class="gallery-image">
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </form>
            <!-- Popup Image -->
            <div class="popup-img" id="popupImg">
                <span class="close-btn" id="closePopup">&times;</span>
                <img id="popupImage" src="" alt="Product Detail Image">
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


            <script>
                var stockMap = JSON.parse('${stockMap}');

                // Cập nhật số lượng tồn kho khi chọn size và color
                function updateAvailableQuantity() {
                    var sizeId = document.getElementById("size").value;
                    var colorId = document.getElementById("color").value;

                    if (sizeId && colorId) {
                        var key = sizeId + "_" + colorId;
                        var availableQuantity = stockMap[key] || 0;
                        document.getElementById("availableQuantity").textContent = availableQuantity;

                        var quantityInput = document.getElementById("quantity");
                        quantityInput.max = availableQuantity;

                        // Reset quantity input to 0 when size/color change
                        quantityInput.value = 0;
                        updatePrice();
                    }
                }

                // Lắng nghe thay đổi của size và color
                document.getElementById("size").addEventListener("change", updateAvailableQuantity);
                document.getElementById("color").addEventListener("change", updateAvailableQuantity);
                updateAvailableQuantity(); // Khởi tạo ngay khi trang tải

                // Tăng giảm số lượng
                document.getElementById("increaseQuantity").addEventListener("click", function () {
                    var quantityInput = document.getElementById("quantity");
                    var maxQuantity = parseInt(quantityInput.max);
                    var currentQuantity = parseInt(quantityInput.value);
                    if (currentQuantity < maxQuantity) {
                        quantityInput.value = currentQuantity + 1;
                        updatePrice();
                    }
                });

                document.getElementById("decreaseQuantity").addEventListener("click", function () {
                    var quantityInput = document.getElementById("quantity");
                    var currentQuantity = parseInt(quantityInput.value);
                    if (currentQuantity > 1) {
                        quantityInput.value = currentQuantity - 1;
                        updatePrice();
                    }
                });

                // Cập nhật giá khi thay đổi số lượng
                function updatePrice() {
                    var price = ${ product.price };
                    var quantity = document.getElementById("quantity").value;
                    var newPrice = price * quantity;
                    document.getElementById("productPrice").textContent = newPrice + " VND";
                }

                // Xử lý pop-up hình ảnh
                document.querySelectorAll(".gallery-image").forEach(function (image) {
                    image.addEventListener("click", function () {
                        var popupImg = document.getElementById("popupImg");
                        var popupImage = document.getElementById("popupImage");
                        popupImage.src = this.src;
                        popupImg.style.display = "flex";
                    });
                });

                document.getElementById("closePopup").addEventListener("click", function () {
                    document.getElementById("popupImg").style.display = "none";
                });

                document.getElementById('addToCartForm').addEventListener('submit', function (event) {
                    event.preventDefault();

                    var productId = document.getElementById('productId').value;
                    var size = document.getElementById('size').value;
                    var color = document.getElementById('color').value;
                    var quantity = document.getElementById('quantity').value;

                    document.getElementById('productId').value = productId;
                    document.getElementById('size').value = size;
                    document.getElementById('color').value = color;

                    this.submit();
                });

                // Hàm để cập nhật trạng thái nút Thêm vào giỏ hàng
                function updateAddToCartButtonState() {
                    var quantityInput = document.getElementById("quantity");
                    var addToCartButton = document.getElementById("addToCart");

                    if (parseInt(quantityInput.value) === 0) {
                        addToCartButton.disabled = true;
                        addToCartButton.style.opacity = "0.5"; // Thêm hiệu ứng mờ để báo hiệu nút bị vô hiệu hóa
                        addToCartButton.style.cursor = "not-allowed"; // Thay đổi con trỏ chuột
                    } else {
                        addToCartButton.disabled = false;
                        addToCartButton.style.opacity = "1";
                        addToCartButton.style.cursor = "pointer";
                    }
                }

                // Lắng nghe sự kiện thay đổi của trường số lượng
                document.getElementById("quantity").addEventListener("input", updateAddToCartButtonState);

                // Gọi hàm để cập nhật trạng thái nút ngay khi trang tải
                updateAddToCartButtonState();

                // Đảm bảo các hàm như tăng/giảm số lượng cũng gọi `updateAddToCartButtonState`
                document.getElementById("increaseQuantity").addEventListener("click", updateAddToCartButtonState);
                document.getElementById("decreaseQuantity").addEventListener("click", updateAddToCartButtonState);

                // Cập nhật trạng thái nút khi size/color thay đổi (vì giá trị quantity sẽ reset về 0)
                document.getElementById("size").addEventListener("change", updateAddToCartButtonState);
                document.getElementById("color").addEventListener("change", updateAddToCartButtonState);

            </script>

        </body>

        </html>