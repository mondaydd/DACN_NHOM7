<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8">
                <meta content="width=device-width, initial-scale=1.0" name="viewport">

                <title>Dashboard - NiceAdmin Bootstrap Template</title>
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
                <link href="css/bootstrap.min.css" rel="stylesheet">
                <!-- Option 1: Include in HTML -->
                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css">
                <link href="css/boxicons.min.css" rel="stylesheet">
                <link href="css/quill.snow.css" rel="stylesheet">
                <link href="css/quill.bubble.css" rel="stylesheet">
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css">
                <link href="css/style-data.css" rel="stylesheet">

                <!-- Template Main CSS File -->
                <link href="css/style.css" rel="stylesheet">

            </head>

            <body>

                <jsp:include page="../layout/header.jsp" />
                <jsp:include page="../layout/sidebar.jsp" />


                <main id="main" class="main">

                    <div class="pagetitle">
                        <h1>Dashboard</h1>
                        <nav>
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                                <li class="breadcrumb-item active">Thống kê</li>
                            </ol>
                        </nav>
                    </div><!-- End Page Title -->

                    <section class="section dashboard">
                        <div class="row">
                            <!-- Left side columns -->
                            <div class="col-12">
                                <div class="row">

                                    <!-- Sales Card -->
                                    <div class="col-xxl-4 col-md-6">
                                        <div class="card info-card sales-card">

                                            <div class="filter">
                                                <a class="icon" href="#" data-bs-toggle="dropdown"><i
                                                        class="bi bi-three-dots"></i></a>
                                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                                    <li class="dropdown-header text-start">
                                                        <h6>Theo</h6>
                                                    </li>
                                                    <li><a class="dropdown-item" href="/admin?date=1">Ngày</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=2">Tháng</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=3">Năm</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=4">Tuần</a></li>
                                                </ul>
                                            </div>

                                            <div class="card-body">
                                                <h5 class="card-title">Đơn bán <span>| ${Date}</span></h5>

                                                <div class="d-flex align-items-center">
                                                    <div
                                                        class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                        <i class="bi bi-cart"></i>
                                                    </div>
                                                    <div class="ps-3">
                                                        <h6>${quantityByDay}</h6>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div><!-- End Sales Card -->

                                    <!-- Revenue Card -->
                                    <div class="col-xxl-4 col-md-6">
                                        <div class="card info-card revenue-card">

                                            <div class="filter">
                                                <a class="icon" href="#" data-bs-toggle="dropdown"><i
                                                        class="bi bi-three-dots"></i></a>
                                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                                    <li class="dropdown-header text-start">
                                                        <h6>Theo</h6>
                                                    </li>
                                                    <li><a class="dropdown-item" href="/admin?date=1">Ngày</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=2">Tháng</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=3">Năm</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=4">Tuần</a></li>
                                                </ul>
                                            </div>

                                            <div class="card-body">
                                                <h5 class="card-title">Doanh số <span>| ${Date}</span></h5>

                                                <div class="d-flex align-items-center">
                                                    <div
                                                        class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                        <i class="bi bi-currency-dollar text-success"></i>
                                                    </div>
                                                    <div class="ps-3">
                                                        <h6>
                                                            <fmt:formatNumber type="number" value="${priceByDay}" />
                                                            Triệu
                                                            VND
                                                        </h6>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div><!-- End Revenue Card -->

                                    <!-- Customers Card -->
                                    <div class="col-xxl-4 col-xl-12">

                                        <div class="card info-card customers-card">

                                            <div class="filter">
                                                <a class="icon" href="#" data-bs-toggle="dropdown"><i
                                                        class="bi bi-three-dots"></i></a>
                                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                                    <li class="dropdown-header text-start">
                                                        <h6>Theo</h6>
                                                    </li>
                                                    <li><a class="dropdown-item" href="/admin?date=1">Ngày</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=2">Tháng</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=3">Năm</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=4">Tuần</a></li>
                                                </ul>
                                            </div>

                                            <div class="card-body">
                                                <h5 class="card-title">Khách hàng <span>| ${Date}</span></h5>

                                                <div class="d-flex align-items-center">
                                                    <div
                                                        class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                        <i class="bi bi-people"></i>
                                                    </div>
                                                    <div class="ps-3">
                                                        <h6>${userByDay}</h6>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                    </div><!-- End Customers Card -->

                                    <!-- Reports -->
                                    <div class="col-12">
                                        <div class="card">

                                            <div class="filter">
                                                <a class="icon" href="#" data-bs-toggle="dropdown"><i
                                                        class="bi bi-three-dots"></i></a>
                                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                                    <li class="dropdown-header text-start">
                                                        <h6>Theo</h6>
                                                    </li>
                                                    <li><a class="dropdown-item" href="/admin?date=1">Ngày</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=2">Tháng</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=3">Năm</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=4">Tuần</a></li>
                                                </ul>
                                            </div>

                                            <div class="card-body">
                                                <h5 class="card-title">Báo cáo <span>/${Date}</span></h5>

                                                <!-- Line Chart -->
                                                <div id="reportsChart"></div>
                                                <script>
                                                    document.addEventListener("DOMContentLoaded", () => {
                                                        const xAxisLabels = JSON.parse('${xAxisLabelsJson}');
                                                        const userCountByDay = JSON.parse('${userCountByDayJson}');
                                                        const totalPrice = JSON.parse('${totalPrice}');
                                                        const totalQuantity = JSON.parse('${totalQuantity}');
                                                        const formattedTotalPrice = totalPrice.map(price => parseFloat(price.toFixed(3)));

                                                        new ApexCharts(document.querySelector("#reportsChart"), {
                                                            series: [{
                                                                name: 'Đơn bán',
                                                                data: totalQuantity, // Thay bằng dữ liệu thực tế
                                                            }, {
                                                                name: 'Doanh số',
                                                                data: formattedTotalPrice,// Thay bằng dữ liệu thực tế
                                                            }, {
                                                                name: 'Khách hàng',
                                                                data: userCountByDay, // Thay bằng dữ liệu thực tế
                                                            }],
                                                            chart: {
                                                                height: 350,
                                                                type: 'area',
                                                                toolbar: {
                                                                    show: false
                                                                }
                                                            },
                                                            xaxis: {
                                                                categories: xAxisLabels, // Sử dụng dữ liệu JSON
                                                            },
                                                            dataLabels: {
                                                                enabled: false
                                                            },
                                                            markers: {
                                                                size: 4
                                                            },
                                                            colors: ['#4154f1', '#2eca6a', '#ff4560'],
                                                            fill: {
                                                                type: "gradient",
                                                                gradient: {
                                                                    shadeIntensity: 1,
                                                                    opacityFrom: 0.3,
                                                                    opacityTo: 0.4,
                                                                    stops: [0, 90, 100]
                                                                }
                                                            },
                                                            stroke: {
                                                                curve: 'smooth',
                                                                width: 2
                                                            },
                                                            tooltip: {
                                                                x: {
                                                                    format: 'dd/MM/yy'
                                                                }
                                                            }
                                                        }).render();
                                                    });
                                                </script>


                                                <!-- End Line Chart -->

                                            </div>

                                        </div>
                                    </div><!-- End Reports -->

                                    <!-- Recent Sales -->
                                    <div class="col-12">
                                        <div class="card recent-sales overflow-auto">

                                            <div class="filter">
                                                <a class="icon" href="#" data-bs-toggle="dropdown"><i
                                                        class="bi bi-three-dots"></i></a>
                                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                                    <li class="dropdown-header text-start">
                                                        <h6>Theo</h6>
                                                    </li>
                                                    <li><a class="dropdown-item" href="/admin?date=1">Ngày</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=2">Tháng</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=3">Năm</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=4">Tuần</a></li>
                                                </ul>
                                            </div>

                                            <div class="card-body">
                                                <h5 class="card-title">Đơn hàng gần đây <span>| ${Date}</span></h5>

                                                <table class="table table-borderless">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">ID</th>
                                                            <th scope="col">Khách hàng</th>
                                                            <th scope="col">Giá(VNĐ)</th>
                                                            <th scope="col">Ngày đặt</th>
                                                            <th scope="col">Trạng thái</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="items" items="${currentOrder}">
                                                            <tr>
                                                                <td>${items.id}</td>
                                                                <td>${items.user.name}</td>
                                                                <td>${items.totalPrice}</td>
                                                                <td>${items.orderDate}</td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when
                                                                            test="${items.status.toString() == 'Đã giao'}">
                                                                            <span class="badge bg-success">Đã
                                                                                giao</span>
                                                                        </c:when>
                                                                        <c:when
                                                                            test="${items.status.toString() == 'Đang xử lý'}">
                                                                            <span class="badge bg-warning">Đang xử
                                                                                lý</span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span class="badge bg-danger">Đã
                                                                                hủy</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>

                                            </div>

                                        </div>
                                    </div><!-- End Recent Sales -->

                                    <!-- Top Selling -->
                                    <div class="col-12">
                                        <div class="card top-selling overflow-auto">

                                            <div class="filter">
                                                <a class="icon" href="#" data-bs-toggle="dropdown"><i
                                                        class="bi bi-three-dots"></i></a>
                                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                                    <li class="dropdown-header text-start">
                                                        <h6>Theo</h6>
                                                    </li>
                                                    <li><a class="dropdown-item" href="/admin?date=1">Ngày</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=2">Tháng</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=3">Năm</a></li>
                                                    <li><a class="dropdown-item" href="/admin?date=4">Tuần</a></li>
                                                </ul>
                                            </div>

                                            <div class="card-body pb-0">
                                                <h5 class="card-title">Tốp sản phẩm bán chạy<span>| ${Date}</span>
                                                </h5>

                                                <table class="table table-borderless">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">STT</th>
                                                            <th scope="col">Sản phẩm</th>
                                                            <th scope="col">Giá(VNĐ)</th>
                                                            <th scope="col">Số lượng</th>
                                                            <th scope="col">Tổng giá(VNĐ)</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="items" items="${bestSale}" varStatus="status">
                                                            <tr>
                                                                <td>${status.index + 1}</td>
                                                                <td>${items.proName}</td>
                                                                <td>${items.price}</td>
                                                                <td>${items.sumQuantity}</td>
                                                                <td>${items.sumPrice}</td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>

                                            </div>

                                        </div>
                                    </div><!-- End Top Selling -->

                                </div>
                            </div><!-- End Left side columns -->

                        </div>
                    </section>
                </main><!-- End #main -->

                <jsp:include page="../layout/footer.jsp" />

                <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
                        class="bi bi-arrow-up-short"></i></a>

                <!-- Vendor JS Files -->

                <script src="js/apexcharts.min.js"></script>
                <script src="js/bootstrap.bundle.min.js"></script>
                <script src="js/chart.umd.js"></script>
                <script src="js/echarts.min.js"></script>
                <script src="js/quill.js"></script>
                <script src="js/simple-datatables.js"></script>
                <script src="js/tinymce.min.js"></script>
                <script src="js/validate.js"></script>

                <!-- Template Main JS File -->
                <script src="js/main.js"></script>



            </body>

            </html>