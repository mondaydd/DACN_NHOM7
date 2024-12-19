<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Lịch sử Mua Hàng</title>
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
            <style>
                body {
                    font-family: 'Arial', sans-serif;
                    background: url('/images/nen-dathang.jpg') no-repeat center center fixed;
                    background-size: cover;
                    margin: 0;
                    padding: 0;
                }

                .container {
                    width: 80%;
                    margin: 50px auto;
                    background: rgba(255, 255, 255, 0.9);
                    border-radius: 10px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    overflow: hidden;
                    padding: 20px;
                }

                h1 {
                    text-align: center;
                    color: #333;
                    margin-bottom: 30px;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 20px;
                }

                th,
                td {
                    padding: 15px;
                    text-align: left;
                    border-bottom: 1px solid #ddd;
                }

                th {
                    background-color: #4CAF50;
                    color: white;
                }

                tbody tr {
                    transition: background-color 0.3s ease;
                }

                tbody tr:hover {
                    background-color: #f1f1f1;
                }

                td {
                    color: #555;
                }

                a {
                    color: #4CAF50;
                    text-decoration: none;
                    font-weight: bold;
                }

                a:hover {
                    text-decoration: underline;
                }

                .btn {
                    display: inline-block;
                    background-color: #4CAF50;
                    color: white;
                    padding: 10px 20px;
                    border: none;
                    cursor: pointer;
                    font-size: 16px;
                    border-radius: 5px;
                    text-align: center;
                    text-decoration: none;
                    margin: 20px auto;
                }

                .btn:hover {
                    background-color: #45a049;
                }

                .no-orders {
                    text-align: center;
                    font-size: 18px;
                    color: #f44336;
                    margin: 30px 0;
                }

                .no-orders i {
                    margin-right: 10px;
                }

                .pagination {
                    margin: 20px 0;
                    text-align: center;
                }

                .pagination a {
                    display: inline-block;
                    padding: 10px 15px;
                    margin: 0 5px;
                    border: 1px solid #ddd;
                    color: #4CAF50;
                    text-decoration: none;
                }

                .pagination a.active {
                    background-color: #4CAF50;
                    color: white;
                    border: none;
                }

                .pagination a:hover {
                    background-color: #ddd;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <h1><i class="fas fa-shopping-cart"></i> Lịch sử Mua Hàng</h1>

                <c:if test="${empty orders}">
                    <p class="no-orders"><i class="fas fa-exclamation-circle"></i> Bạn chưa có đơn hàng nào!</p>
                    <a href="/" class="btn"><i class="fas fa-home"></i> Quay lại trang chủ</a>
                </c:if>

                <c:if test="${not empty orders}">
                    <table>
                        <thead>
                            <tr>
                                <th><i class="fas fa-hashtag"></i> Mã đơn hàng</th>
                                <th><i class="fas fa-calendar-alt"></i> Ngày đặt</th>
                                <th><i class="fas fa-money-bill"></i> Tổng giá</th>
                                <th><i class="fas fa-info-circle"></i> Trạng thái</th>
                                <th><i class="fas fa-eye"></i> Chi tiết</th>
                                <th><i class="fas fa-trash"></i> Hủy</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>${order.id}</td>
                                    <td>${order.orderDate}</td>
                                    <td>${order.totalPrice} VND</td>
                                    <td>${order.status}</td>
                                    <td><a href="/user/order-history/${order.id}"><i class="fas fa-eye"></i> Xem chi
                                            tiết</a></td>
                                    <td>
                                        <c:if test="${order.status == 'Đang xử lý'}">
                                            <form action="/user/order-history/delete/${order.id}" method="post">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <button type="submit" class="btn"
                                                    style="background-color: #f44336; border: none;">
                                                    <i class="fas fa-trash"></i> Hủy
                                                </button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>

                    </table>
                    <div class="pagination">
                        <c:forEach var="i" begin="0" end="${totalPages - 1}">
                            <a href="?page=${i}&size=5" class="${currentPage == i ? 'active' : ''}">${i + 1}</a>
                        </c:forEach>
                    </div>
                    <a href="/" class="btn"><i class="fas fa-home"></i> Quay lại trang chủ</a>
                </c:if>
            </div>
        </body>

        </html>