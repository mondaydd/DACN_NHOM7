<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Quản lý mã giảm giá</title>

            <!-- Favicons -->
            <link href="assets/img/favicon.png" rel="icon">
            <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

            <!-- Google Fonts -->
            <link href="https://fonts.gstatic.com" rel="preconnect">
            <link
                href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
                rel="stylesheet">

            <!-- Vendor CSS Files -->
            <link href="/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
            <link href="/css/boxicons.min.css" rel="stylesheet">
            <link href="/css/style-data.css" rel="stylesheet">
            <link href="/css/style.css" rel="stylesheet">

            <!-- Custom CSS -->
            <style>
                body {
                    background-color: #f8f9fa;
                    font-family: 'Nunito', sans-serif;
                }

                .container {
                    margin-top: 50px;
                    background-color: white;
                    padding: 20px;
                    border-radius: 8px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                }

                .table thead th {
                    background-color: #343a40;
                    color: white;
                }

                .btn-create {
                    margin-bottom: 20px;
                }

                .text-muted {
                    font-size: 0.9rem;
                }

                h1 {
                    font-weight: 700;
                }

                .pagination {
                    margin-top: 20px;
                    justify-content: center;
                }

                .action-buttons a {
                    transition: transform 0.2s ease-in-out;
                }

                .action-buttons a:hover {
                    transform: scale(1.1);
                }
            </style>
        </head>

        <body>
            <!-- Header và Sidebar -->
            <jsp:include page="../layout/header.jsp" />
            <jsp:include page="../layout/sidebar.jsp" />

            <main>
                <div class="container">
                    <h1 class="text-center mb-4">Quản lý mã giảm giá</h1>

                    <!-- Nút thêm mã giảm giá -->
                    <div class="text-end">
                        <a href="/admin/discount/create" class="btn btn-success btn-create">
                            <i class="bi bi-plus-circle"></i> Thêm mã giảm giá
                        </a>
                    </div>

                    <!-- Bảng quản lý -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Mã giảm giá</th>
                                    <th>Phần trăm giảm</th>
                                    <th>Giảm giá tối đa</th>
                                    <th>Số lượng</th>
                                    <th>Ngày bắt đầu</th>
                                    <th>Ngày kết thúc</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Kiểm tra danh sách -->
                                <c:choose>
                                    <c:when test="${discounts.isEmpty()}">
                                        <tr>
                                            <td colspan="8" class="text-center text-muted">
                                                <i class="bi bi-info-circle"></i> Không có mã giảm giá nào
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="discount" items="${discounts}">
                                            <tr>
                                                <td>${discount.id}</td>
                                                <td>${discount.code}</td>
                                                <td>${discount.discountPercent}%</td>
                                                <td>${discount.maxDiscount}</td>
                                                <td>${discount.quantity}</td>
                                                <td>${discount.startDate}</td>
                                                <td>${discount.endDate}</td>
                                                <td class="action-buttons">
                                                    <a href="/admin/discount/edit/${discount.id}"
                                                        class="btn btn-primary btn-sm" title="Sửa"><i
                                                            class="bi bi-pencil-square"></i></a>
                                                    <a href="/admin/discount/delete/${discount.id}"
                                                        class="btn btn-danger btn-sm" title="Xóa"
                                                        onclick="return confirm('Bạn có chắc chắn muốn xóa mã này?')"><i
                                                            class="bi bi-trash"></i></a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>

                    <!-- Phân trang -->
                    <nav>
                        <ul class="pagination">
                            <c:forEach var="i" begin="0" end="${totalPages - 1}">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="/admin/discount/manage?page=${i}">${i + 1}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </main>

            <!-- Footer -->
            <jsp:include page="../layout/footer.jsp" />

            <script src="/js/bootstrap.bundle.min.js"></script>
            <script src="/js/main.js"></script>
        </body>

        </html>