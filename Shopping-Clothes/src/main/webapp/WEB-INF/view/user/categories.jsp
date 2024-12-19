<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Danh mục sản phẩm</title>

            <!-- Google Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

            <!-- FontAwesome Icons -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

            <!-- Libraries Stylesheet -->
            <link href="${pageContext.request.contextPath}/lib-user/lightbox/css/lightbox.min.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/lib-user/owlcarousel/assets/owl.carousel.min.css"
                rel="stylesheet">
            <link href="${pageContext.request.contextPath}/lib-user/owlcarousel/assets/owl.theme.default.min.css"
                rel="stylesheet">

            <!-- Customized Bootstrap Stylesheet -->
            <link href="${pageContext.request.contextPath}/css-user/bootstrap.min.css" rel="stylesheet">

            <!-- Template Stylesheet -->
            <link href="${pageContext.request.contextPath}/css-user/style.css" rel="stylesheet">

            <!-- Custom CSS -->
            <style>
                body {
                    font-family: 'Roboto', sans-serif;
                    background-color: #f8f9fa;
                    margin: 0;
                    padding: 0;
                }

                .container-category {
                    display: flex;
                    justify-content: space-between;
                    margin-top: 160px;
                }

                .content-category {
                    flex: 1;
                    margin-left: 20px;
                    padding: 20px;
                    background-color: #ffffff;
                    border-radius: 10px;
                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                }

                .sidebar {
                    flex: 0 0 250px;
                    background-color: #f8f9fa;
                    border: none;
                    padding: 20px;
                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
                    border-radius: 10px;
                    height: fit-content;
                    position: sticky;
                    top: 20px;
                    transition: all 0.3s ease;
                }

                .sidebar h3 {
                    font-size: 22px;
                    font-weight: bold;
                    color: #007bff;
                    text-align: center;
                    margin-bottom: 20px;
                }

                .sidebar .toggle-btn {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    margin-bottom: 15px;
                    cursor: pointer;
                    background-color: #007bff;
                    color: #fff;
                    padding: 10px;
                    border: none;
                    border-radius: 5px;
                    font-size: 16px;
                    font-weight: bold;
                    transition: background-color 0.3s ease;
                }

                .sidebar .toggle-btn:hover {
                    background-color: #0056b3;
                }

                .list-group {
                    padding: 0;
                    list-style: none;
                    margin: 0;
                }

                .list-group-item {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    background: #fff;
                    border: none;
                    border-radius: 8px;
                    margin-bottom: 10px;
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                    padding: 15px 20px;
                    color: #333;
                    font-size: 16px;
                    font-weight: 500;
                    text-decoration: none;
                    transition: transform 0.2s ease, box-shadow 0.2s ease;
                }

                .list-group-item i {
                    font-size: 1.5rem;
                    color: #007bff;
                    transition: color 0.3s ease;
                }

                .list-group-item:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
                    color: #fff;
                    background-color: #007bff;
                }

                .list-group-item:hover i {
                    color: #fff;
                }

                .list-group-item.active {
                    background-color: #0056b3;
                    color: white;
                }

                .list-group-item.active i {
                    color: white;
                }

                .list-group-item.active:hover {
                    background-color: #003f8a;
                }

                .sidebar .list-group {
                    max-height: 600px;
                    overflow-y: auto;
                    scrollbar-width: thin;
                    scrollbar-color: #007bff #f8f9fa;
                }

                .sidebar .list-group::-webkit-scrollbar {
                    width: 8px;
                }

                .sidebar .list-group::-webkit-scrollbar-thumb {
                    background-color: #007bff;
                    border-radius: 10px;
                }

                .sidebar .list-group::-webkit-scrollbar-track {
                    background-color: #f8f9fa;
                }

                .card {
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                    height: 100%;
                    border-radius: 8px;
                    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                }

                .card-img-top {
                    max-height: 300px;
                    object-fit: cover;
                    border-top-left-radius: 8px;
                    border-top-right-radius: 8px;
                }

                .card-body {
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                    flex-grow: 1;
                    text-align: center;
                }

                .row.equal-height .col-md-3 {
                    display: flex;
                    flex-direction: column;
                }

                .btn {
                    align-self: center;
                    margin-top: auto;
                }

                .pagination {
                    justify-content: center;
                }
            </style>
        </head>

        <body>
            <!-- Header Include -->
            <jsp:include page="/WEB-INF/view/user/layout/header.jsp" />

            <div class="container-category">
                <!-- Sidebar -->
                <div class="sidebar">
                    <button class="toggle-btn" id="toggle-btn">
                        <i class="fas fa-bars"></i> Thu gọn danh mục
                    </button>
                    <h3>Danh mục</h3>
                    <div class="list-group" id="category-list">
                        <c:forEach var="category" items="${categories}">
                            <a href="${pageContext.request.contextPath}/categories/${category.id}/products?page=0"
                                class="list-group-item ${category.id == category.id ? 'active' : ''}">
                                <i class="fas fa-tag"></i> ${category.name}
                            </a>
                        </c:forEach>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="content-category">
                    <h2>Sản phẩm trong danh mục: ${category.name}</h2>
                    <c:if test="${not empty products}">
                        <div class="row equal-height">
                            <c:forEach var="product" items="${products}">
                                <div class="col-md-3 mb-4">
                                    <div class="card">
                                        <img src="/images/products/${product.image}" class="card-img-top"
                                            alt="${product.name}">
                                        <div class="card-body">
                                            <h5 class="card-title">${product.name}</h5>
                                            <p class="card-text">${product.shortDesc}</p>
                                            <p class="card-text"><strong>${product.price} VNĐ</strong></p>
                                            <a href="${pageContext.request.contextPath}/products/${product.id}"
                                                class="btn btn-primary"><i class="fas fa-eye"></i>Xem chi tiết</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <nav aria-label="Page navigation" style="text-align: center;">
                            <ul class="pagination">
                                <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link"
                                            href="${pageContext.request.contextPath}/categories/${category.id}/products?page=${i}">${i
                                            + 1}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </nav>
                    </c:if>
                    <c:if test="${empty products}">
                        <p>Không có sản phẩm trong danh mục này.</p>
                    </c:if>
                </div>
            </div>

            <!-- Footer Include -->
            <jsp:include page="/WEB-INF/view/user/layout/footer.jsp" />

            <!-- JavaScript -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib-user/easing/easing.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib-user/waypoints/waypoints.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib-user/lightbox/js/lightbox.min.js"></script>
            <script src="${pageContext.request.contextPath}/lib-user/owlcarousel/owl.carousel.min.js"></script>
            <script src="${pageContext.request.contextPath}/js-user/main.js"></script>





            <script>
                const toggleBtn = document.getElementById('toggle-btn');
                const categoryList = document.getElementById('category-list');

                toggleBtn.addEventListener('click', () => {
                    if (categoryList.style.display === 'none') {
                        categoryList.style.display = 'block';
                        toggleBtn.innerHTML = '<i class="fas fa-bars" style="margin-top: 3px;"></i> Thu gọn';
                    } else {
                        categoryList.style.display = 'none';
                        toggleBtn.innerHTML = '<i class="fas fa-bars" style="margin-top: 3px;"></i> Hiện danh mục';
                    }
                });
            </script>
        </body>

        </html>