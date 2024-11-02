<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
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

                                            <li><a class="dropdown-item" href="#">Hôm nay</a></li>
                                            <li><a class="dropdown-item" href="#">Tháng</a></li>
                                            <li><a class="dropdown-item" href="#">Năm</a></li>
                                        </ul>
                                    </div>

                                    <div class="card-body">
                                        <h5 class="card-title">Đơn bán <span>| Hôm nay</span></h5>

                                        <div class="d-flex align-items-center">
                                            <div
                                                class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                <i class="bi bi-cart"></i>
                                            </div>
                                            <div class="ps-3">
                                                <h6>145</h6>
                                                <span class="text-muted small pt-2 ps-1">Tăng</span>
                                                <span class="text-success small pt-1 fw-bold">12%</span>
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

                                            <li><a class="dropdown-item" href="#">Hôn nay</a></li>
                                            <li><a class="dropdown-item" href="#">Tháng này</a></li>
                                            <li><a class="dropdown-item" href="#">Năm này</a></li>
                                        </ul>
                                    </div>

                                    <div class="card-body">
                                        <h5 class="card-title">Doanh số <span>| Tháng</span></h5>

                                        <div class="d-flex align-items-center">
                                            <div
                                                class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                <i class="bi bi-currency-dollar"></i>
                                            </div>
                                            <div class="ps-3">
                                                <h6>$3,264</h6>
                                                <span class="text-muted small pt-2 ps-1">Tăng</span>
                                                <span class="text-success small pt-1 fw-bold">8%</span>
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

                                            <li><a class="dropdown-item" href="#">Hôm nay</a></li>
                                            <li><a class="dropdown-item" href="#">Tháng</a></li>
                                            <li><a class="dropdown-item" href="#">Năm</a></li>
                                        </ul>
                                    </div>

                                    <div class="card-body">
                                        <h5 class="card-title">Khách hàng <span>| Năm</span></h5>

                                        <div class="d-flex align-items-center">
                                            <div
                                                class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                                <i class="bi bi-people"></i>
                                            </div>
                                            <div class="ps-3">
                                                <h6>1244</h6>
                                                <span class="text-muted small pt-2 ps-1">Giảm</span>
                                                <span class="text-danger small pt-1 fw-bold">12%</span>
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

                                            <li><a class="dropdown-item" href="#">Hôm nay</a></li>
                                            <li><a class="dropdown-item" href="#">Tháng</a></li>
                                            <li><a class="dropdown-item" href="#">Năm</a></li>
                                        </ul>
                                    </div>

                                    <div class="card-body">
                                        <h5 class="card-title">Báo cáo <span>/Hôm nay</span></h5>

                                        <!-- Line Chart -->
                                        <div id="reportsChart"></div>

                                        <script>
                                            document.addEventListener("DOMContentLoaded", () => {
                                                new ApexCharts(document.querySelector("#reportsChart"), {
                                                    series: [{
                                                        name: 'Đơn bán',
                                                        data: [31, 40, 28, 51, 42, 82, 56],
                                                    }, {
                                                        name: 'Doanh số',
                                                        data: [11, 32, 45, 32, 34, 52, 41]
                                                    }, {
                                                        name: 'Khách hàng',
                                                        data: [15, 11, 32, 18, 9, 24, 11]
                                                    }],
                                                    chart: {
                                                        height: 350,
                                                        type: 'area',
                                                        toolbar: {
                                                            show: false
                                                        },
                                                    },
                                                    markers: {
                                                        size: 4
                                                    },
                                                    colors: ['#4154f1', '#2eca6a', '#ff771d'],
                                                    fill: {
                                                        type: "gradient",
                                                        gradient: {
                                                            shadeIntensity: 1,
                                                            opacityFrom: 0.3,
                                                            opacityTo: 0.4,
                                                            stops: [0, 90, 100]
                                                        }
                                                    },
                                                    dataLabels: {
                                                        enabled: false
                                                    },
                                                    stroke: {
                                                        curve: 'smooth',
                                                        width: 2
                                                    },
                                                    xaxis: {
                                                        type: 'datetime',
                                                        categories: ["2018-09-19T00:00:00.000Z", "2018-09-19T01:30:00.000Z", "2018-09-19T02:30:00.000Z", "2018-09-19T03:30:00.000Z", "2018-09-19T04:30:00.000Z", "2018-09-19T05:30:00.000Z", "2018-09-19T06:30:00.000Z"]
                                                    },
                                                    tooltip: {
                                                        x: {
                                                            format: 'dd/MM/yy HH:mm'
                                                        },
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

                                            <li><a class="dropdown-item" href="#">Hôm nay</a></li>
                                            <li><a class="dropdown-item" href="#">Tháng</a></li>
                                            <li><a class="dropdown-item" href="#">Năm</a></li>
                                        </ul>
                                    </div>

                                    <div class="card-body">
                                        <h5 class="card-title">Đơn hàng gần đây <span>| Today</span></h5>

                                        <table class="table table-borderless">
                                            <thead>
                                                <tr>
                                                    <th scope="col">#</th>
                                                    <th scope="col">Customer</th>
                                                    <th scope="col">Product</th>
                                                    <th scope="col">Price</th>
                                                    <th scope="col">Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <th scope="row"><a href="#">#2457</a></th>
                                                    <td>Brandon Jacob</td>
                                                    <td><a href="#" class="text-primary">At praesentium minu</a></td>
                                                    <td>$64</td>
                                                    <td><span class="badge bg-success">Approved</span></td>
                                                </tr>
                                                <tr>
                                                    <th scope="row"><a href="#">#2147</a></th>
                                                    <td>Bridie Kessler</td>
                                                    <td><a href="#" class="text-primary">Blanditiis dolor omnis
                                                            similique</a></td>
                                                    <td>$47</td>
                                                    <td><span class="badge bg-warning">Pending</span></td>
                                                </tr>
                                                <tr>
                                                    <th scope="row"><a href="#">#2049</a></th>
                                                    <td>Ashleigh Langosh</td>
                                                    <td><a href="#" class="text-primary">At recusandae consectetur</a>
                                                    </td>
                                                    <td>$147</td>
                                                    <td><span class="badge bg-success">Approved</span></td>
                                                </tr>
                                                <tr>
                                                    <th scope="row"><a href="#">#2644</a></th>
                                                    <td>Angus Grady</td>
                                                    <td><a href="#" class="text-primar">Ut voluptatem id earum et</a>
                                                    </td>
                                                    <td>$67</td>
                                                    <td><span class="badge bg-danger">Rejected</span></td>
                                                </tr>
                                                <tr>
                                                    <th scope="row"><a href="#">#2644</a></th>
                                                    <td>Raheem Lehner</td>
                                                    <td><a href="#" class="text-primary">Sunt similique distinctio</a>
                                                    </td>
                                                    <td>$165</td>
                                                    <td><span class="badge bg-success">Approved</span></td>
                                                </tr>
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

                                            <li><a class="dropdown-item" href="#">Hôm nay</a></li>
                                            <li><a class="dropdown-item" href="#">Tháng</a></li>
                                            <li><a class="dropdown-item" href="#">Năm</a></li>
                                        </ul>
                                    </div>

                                    <div class="card-body pb-0">
                                        <h5 class="card-title">Tốp doanh thu <span>| Hôm nay</span></h5>

                                        <table class="table table-borderless">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Preview</th>
                                                    <th scope="col">Product</th>
                                                    <th scope="col">Price</th>
                                                    <th scope="col">Sold</th>
                                                    <th scope="col">Revenue</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <th scope="row"><a href="#"><img src="assets/img/product-1.jpg"
                                                                alt=""></a></th>
                                                    <td><a href="#" class="text-primary fw-bold">Ut inventore ipsa
                                                            voluptas
                                                            nulla</a></td>
                                                    <td>$64</td>
                                                    <td class="fw-bold">124</td>
                                                    <td>$5,828</td>
                                                </tr>
                                                <tr>
                                                    <th scope="row"><a href="#"><img src="assets/img/product-2.jpg"
                                                                alt=""></a></th>
                                                    <td><a href="#" class="text-primary fw-bold">Exercitationem
                                                            similique
                                                            doloremque</a></td>
                                                    <td>$46</td>
                                                    <td class="fw-bold">98</td>
                                                    <td>$4,508</td>
                                                </tr>
                                                <tr>
                                                    <th scope="row"><a href="#"><img src="assets/img/product-3.jpg"
                                                                alt=""></a></th>
                                                    <td><a href="#" class="text-primary fw-bold">Doloribus nisi
                                                            exercitationem</a></td>
                                                    <td>$59</td>
                                                    <td class="fw-bold">74</td>
                                                    <td>$4,366</td>
                                                </tr>
                                                <tr>
                                                    <th scope="row"><a href="#"><img src="assets/img/product-4.jpg"
                                                                alt=""></a></th>
                                                    <td><a href="#" class="text-primary fw-bold">Officiis quaerat sint
                                                            rerum
                                                            error</a></td>
                                                    <td>$32</td>
                                                    <td class="fw-bold">63</td>
                                                    <td>$2,016</td>
                                                </tr>
                                                <tr>
                                                    <th scope="row"><a href="#"><img src="assets/img/product-5.jpg"
                                                                alt=""></a></th>
                                                    <td><a href="#" class="text-primary fw-bold">Sit unde debitis
                                                            delectus
                                                            repellendus</a></td>
                                                    <td>$79</td>
                                                    <td class="fw-bold">41</td>
                                                    <td>$3,239</td>
                                                </tr>
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