<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <meta content="width=device-width, initial-scale=1.0" name="viewport">
            <title>Thêm Danh Mục Sản Phẩm</title>
            <meta content="" name="description">
            <meta content="" name="keywords">

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
                            <li class="breadcrumb-item active">Thêm danh mục sản phẩm</li>
                        </ol>
                    </nav>
                </div><!-- End Page Title -->

                <section class="section">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Thêm Danh Mục Sản Phẩm</h5>

                                    <!-- Hiển thị thông báo lỗi nếu có -->
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger" role="alert">
                                            ${error}
                                        </div>
                                    </c:if>

                                    <form action="/admin/category/create" method="POST">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <div class="mb-3">
                                            <label for="name" class="form-label">Tên danh mục</label>
                                            <input type="text" class="form-control" id="name" name="name"
                                                value="${param.name}">
                                            <!-- Hiển thị thông báo lỗi nếu trường tên danh mục trống -->
                                            <c:if test="${not empty nameError}">
                                                <div class="text-danger mt-2">${nameError}</div>
                                            </c:if>
                                        </div>

                                        <div class="mb-3">
                                            <label for="description" class="form-label">Mô tả</label>
                                            <textarea class="form-control" id="description"
                                                name="description">${param.description}</textarea>
                                        </div>

                                        <button type="submit" class="btn btn-primary">Thêm danh mục</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

            </main><!-- End #main -->

            <!-- Include Footer -->
            <jsp:include page="../layout/footer.jsp" />

            <script>
                // Nếu có thông báo lỗi, tự động ẩn sau 3 giây
                const errorAlert = document.querySelector('.alert');
                if (errorAlert) {
                    setTimeout(() => {
                        errorAlert.style.display = 'none';
                    }, 3000); // 3 giây
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