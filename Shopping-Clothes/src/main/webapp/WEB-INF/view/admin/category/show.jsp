<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta content="width=device-width, initial-scale=1.0" name="viewport">
            <title>Quản lý danh mục sản phẩm</title>
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

            <!-- Custom Styles -->
            <style>
                .search-container {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .search-input {
                    width: 300px;
                }

                .btn-search {
                    background-color: #007bff;
                    color: white;
                }

                .btn-search:hover {
                    background-color: #0056b3;
                }

                .btn-primary {
                    margin-left: 10px;
                }
            </style>
        </head>

        <body>
            <!-- Include Header and Sidebar -->
            <jsp:include page="../layout/header.jsp" />
            <jsp:include page="../layout/sidebar.jsp" />

            <main id="main" class="main">
                <div class="pagetitle">
                    <h1>Quản lý danh mục sản phẩm</h1>
                    <nav>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="/admin/category">Quản lý</a></li>
                            <li class="breadcrumb-item active">Danh mục sản phẩm</li>
                        </ol>
                    </nav>
                </div><!-- End Page Title -->

                <section class="section">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-body">
                                    <!-- Hiển thị thông báo lỗi nếu có -->
                                    <c:if test="${not empty error}">
                                        <div id="error-alert" class="alert alert-danger alert-dismissible fade show"
                                            role="alert">
                                            ${error}
                                            <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                aria-label="Close"></button>
                                        </div>
                                    </c:if>

                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h5 class="card-title">Danh sách danh mục sản phẩm</h5>
                                        <div class="search-container">
                                            <form action="/admin/category" method="get"
                                                class="d-flex align-items-center">
                                                <input type="text" name="search" value="${search}"
                                                    class="form-control search-input"
                                                    placeholder="Tìm kiếm danh mục..." />
                                                <button type="submit" class="btn btn-search ms-2">
                                                    <i class="bi bi-search"></i>
                                                </button>
                                            </form>
                                            <a class="btn btn-primary" href="/admin/category/create">Thêm danh mục
                                                mới</a>
                                        </div>
                                    </div>

                                    <!-- Table with stripped rows -->
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th class="col-1">ID</th>
                                                <th class="col-3">Tên danh mục</th>
                                                <th class="col-5">Mô tả</th>
                                                <th class="col-3">Chức năng</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="category" items="${categories}">
                                                <tr>
                                                    <td>${category.id}</td>
                                                    <td>${category.name}</td>
                                                    <td>${category.description}</td>
                                                    <td>
                                                        <a href="/admin/category/update/${category.id}"
                                                            class="btn btn-warning btn-sm">Sửa</a>
                                                        <a href="/admin/category/delete/${category.id}"
                                                            class="btn btn-danger btn-sm"
                                                            onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">Xóa</a>
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
                                            <!-- Pagination Links -->
                                            <c:forEach var="i" begin="0" end="${totalPages - 1}">
                                                <a class="btn btn-sm btn-outline-primary ${i == currentPage ? 'active' : ''}"
                                                    href="/admin/category?page=${i}">
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

            <!-- Include Footer -->
            <jsp:include page="../layout/footer.jsp" />

            <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
                    class="bi bi-arrow-up-short"></i></a>

            <!-- Vendor JS Files -->
            <script>
                // Tự động ẩn thông báo sau 3 giây
                const errorAlert = document.getElementById("error-alert");
                if (errorAlert) {
                    setTimeout(() => {
                        errorAlert.classList.remove("show");
                        errorAlert.classList.add("hide");
                    }, 2000); // 2000ms = 2giây
                }
            </script>

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