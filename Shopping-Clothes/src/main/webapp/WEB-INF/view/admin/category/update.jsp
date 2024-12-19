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

            <style>
                body {
                    font-family: 'Poppins', sans-serif;
                    background-color: #f8f9fc;
                }

                .main {
                    margin-top: 30px;
                }

                .pagetitle {
                    margin-bottom: 20px;
                    font-size: 1.8rem;
                    font-weight: 600;
                    color: #495057;
                }

                .card {
                    border-radius: 10px;
                    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
                }

                .card-body {
                    padding: 30px;
                }

                .form-group {
                    margin-bottom: 20px;
                }

                .form-control {
                    border-radius: 10px;
                    border: 1px solid #ced4da;
                    padding: 12px;
                    font-size: 1rem;
                    width: 100%;
                }

                .form-control:focus {
                    border-color: #66afe9;
                    box-shadow: 0 0 8px rgba(0, 123, 255, 0.5);
                }

                .btn-primary {
                    background-color: #007bff;
                    border: none;
                    border-radius: 5px;
                    padding: 10px 20px;
                    font-size: 1rem;
                }

                .btn-primary:hover {
                    background-color: #0056b3;
                }

                .back-to-top {
                    position: fixed;
                    bottom: 20px;
                    right: 20px;
                    background-color: #007bff;
                    color: #fff;
                    border-radius: 50%;
                    padding: 15px;
                    text-align: center;
                    font-size: 20px;
                    cursor: pointer;
                }

                .back-to-top:hover {
                    background-color: #0056b3;
                }
            </style>
        </head>

        <body>

            <jsp:include page="../layout/header.jsp" />
            <jsp:include page="../layout/sidebar.jsp" />

            <main id="main" class="main">
                <div class="pagetitle">
                    <h1>Sửa danh mục sản phẩm</h1>
                </div>

                <section class="section">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title mb-4">Thông tin danh mục</h5>
                                        <form action="/admin/category/update/${category.id}" method="post">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <div class="form-group">
                                                <label for="name">Tên danh mục</label>
                                                <input type="text" class="form-control" id="name" name="name"
                                                    value="${category.name}" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="description">Mô tả</label>
                                                <textarea class="form-control" id="description" name="description"
                                                    rows="4">${category.description}</textarea>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </main>

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