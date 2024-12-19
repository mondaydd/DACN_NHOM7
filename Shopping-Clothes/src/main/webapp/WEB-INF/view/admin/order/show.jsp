<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta content="width=device-width, initial-scale=1.0" name="viewport">
            <title>Danh sách người dùng</title>
            <meta content="" name="description">
            <meta content="" name="keywords">

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
            <link href="/css/quill.snow.css" rel="stylesheet">
            <link href="/css/quill.bubble.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css">
            <link href="/css/style-data.css" rel="stylesheet">
            <link href="/css/style.css" rel="stylesheet">

            <style>
                /* Cải thiện kiểu dáng cho form tìm kiếm */
                .form-inline {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                .search-input {
                    border-radius: 25px;
                    padding: 10px;
                    font-size: 14px;
                    border: 1px solid #ccc;
                    transition: all 0.3s ease;
                    width: 300px;
                    /* Chiếm toàn bộ không gian có sẵn */
                }

                /* Nút tìm kiếm */
                .btn-search {
                    background-color: #007bff;
                    color: white;
                    border: none;
                    border-radius: 25px;
                    padding: 10px 20px;
                    font-size: 14px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    transition: background-color 0.3s ease;
                }

                /* Hiệu ứng hover cho nút */
                .btn-search:hover {
                    background-color: #0056b3;
                    cursor: pointer;
                }

                /* Hiệu ứng focus cho input */
                .search-input:focus {
                    outline: none;
                    border-color: #007bff;
                    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
                }
            </style>
        </head>

        <body>
            <jsp:include page="../layout/header.jsp" />
            <jsp:include page="../layout/sidebar.jsp" />

            <main id="main" class="main">
                <div class="pagetitle">
                    <h1>Quản lý đơn hàng</h1>
                    <nav>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="/admin/order">Quản lý</a></li>
                            <li class="breadcrumb-item active">Quản lý đơn hàng</li>
                        </ol>
                    </nav>
                </div><!-- End Page Title -->

                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>

                <section class="section">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between mb-3">
                                        <h5 class="card-title">Danh sách đơn hàng</h5>
                                        <form action="/admin/order" method="get"
                                            class="d-flex align-items-center form-inline">
                                            <input type="text" id="search" name="search" value="${search}"
                                                class="form-control search-input"
                                                placeholder="Tìm kiếm đơn hàng (ví dụ: 'Đang giao')">
                                            <button type="submit" class="btn btn-search ms-2">
                                                <i class="bi bi-search"></i>
                                            </button>
                                        </form>
                                    </div>

                                    <!-- Table with stripped rows -->
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th class="col-1">STT</th>
                                                <th class="col-2">Họ tên</th>
                                                <th class="col-1">Điện thoại</th>
                                                <th class="col-1">Tổng giá</th>
                                                <th class="col-1 text-center">Ngày tạo</th>
                                                <th class="col-1 text-center">Trạng thái</th>
                                                <th class="col-1 text-center">Thanh toán</th>
                                                <th class="col-3 text-center">Chức năng</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${orders}" varStatus="loop">
                                                <tr>
                                                    <td class="col-1">${loop.index + 1}</td>
                                                    <td class="col-2">${item.receiverName}</td>
                                                    <td class="col-1">${item.receiverPhone}</td>
                                                    <td class="col-1">${item.totalPrice}</td>
                                                    <td class="col-1">${item.orderDate}</td>
                                                    <td class="text-center">${item.status}</td>
                                                    <td>
                                                        <div>${item.paymentMethod}</div>
                                                    </td>
                                                    <td class="col-3 text-center">
                                                        <a class="btn btn-success"
                                                            href="/admin/order/${item.id}">Xem</a>
                                                        <a class="btn btn-warning"
                                                            href="/admin/order/update/${item.id}">Sửa</a>
                                                        <a class="btn btn-danger"
                                                            href="/admin/order/delete/${item.id}">Xóa</a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <!-- End Table with stripped rows -->

                                    <!-- Pagination Controls -->
                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                        <div>
                                            <span>Trang hiện tại: ${currentPage + 1} / ${totalPages}</span>
                                        </div>
                                        <div>
                                            <c:forEach var="i" begin="0" end="${totalPages - 1}">
                                                <a class="btn btn-sm btn-outline-primary ${i == currentPage ? 'active' : ''}"
                                                    href="/admin/order?page=${i}">
                                                    ${i + 1}
                                                </a>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </main><!-- End #main -->

            <jsp:include page="../layout/footer.jsp" />

            <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
                    class="bi bi-arrow-up-short"></i></a>

            <!-- Vendor JS Files -->
            <script src="/js/apexcharts.min.js"></script>
            <script src="/js/bootstrap.bundle.min.js"></script>
            <script src="/js/chart.umd.js"></script>
            <script src="/js/echarts.min.js"></script>
            <script src="/js/quill.js"></script>
            <script src="/js/simple-datatables.js"></script>
            <script src="/js/tinymce.min.js"></script>
            <script src="/js/validate.js"></script>

            <!-- Template Main JS File -->
            <script src="/js/main.js"></script>

        </body>

        </html>