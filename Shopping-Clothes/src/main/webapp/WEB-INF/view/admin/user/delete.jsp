<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8">
                <meta content="width=device-width, initial-scale=1.0" name="viewport">

                <title>Tables / Data - NiceAdmin Bootstrap Template</title>
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
                <!-- Option 1: Include in HTML -->
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
                <link href="/css/boxicons.min.css" rel="stylesheet">
                <link href="/css/quill.snow.css" rel="stylesheet">
                <link href="/css/quill.bubble.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css">
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <link href="/css/style-data.css" rel="stylesheet">

                <!-- Template Main CSS File -->
                <link href="/css/style.css" rel="stylesheet">
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />
                <jsp:include page="../layout/sidebar.jsp" />

                <main id="main" class="main">
                    <div class="pagetitle">
                        <h1>Quản lý người dùng</h1>
                        <nav>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                                <li class="breadcrumb-item"><a href="index.html">Quản lý</a></li>
                                <li class="breadcrumb-item active">Quản lý người dùng</li>
                            </ol>
                        </nav>
                    </div>
                    <!-- End Page Title -->
                    <section class="section">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-12 mx-auto">
                                            <h1>Ấn xóa để xóa người dùng có id = ${id}</h1>
                                            <hr>
                                            <div class="alert alert-danger" role="alert">
                                                Bạn có chắc chắn xóa người dùng này không?
                                            </div>
                                            <form:form method="POST" action="/admin/user/delete"
                                                modelAttribute="newUser">
                                                <div class="mb-3" style="display: none;">
                                                    <label class="form-label">ID</label>
                                                    <form:input type="text" class="form-control" path="id"
                                                        value="${id}" />
                                                </div>
                                                <button type="submit" class="btn btn-primary">Xóa</button>
                                                <button class="btn btn-primary"><a class="text-white"
                                                        href="/admin/user">Trở
                                                        về</a></button>
                                            </form:form>
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