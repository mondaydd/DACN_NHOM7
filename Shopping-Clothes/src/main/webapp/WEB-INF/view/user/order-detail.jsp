<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng</title>
    
    <!-- Include Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    
    <!-- Link to your CSS stylesheet -->
    <link rel="stylesheet" href="/css/style.css">

    <style>
      
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7fc;
        }

      
        h1 {
            color: #2c3e50;
            font-size: 32px;
            margin-bottom: 20px;
        }

        h2 {
            color: #34495e;
            font-size: 28px;
            margin-bottom: 15px;
        }

        .order-summary {
            background-color: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .order-summary p {
            font-size: 16px;
            line-height: 1.6;
            color: #34495e;
        }

   
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #2980b9;
            color: white;
        }

        td {
            background-color: #f9f9f9;
        }

        tr:nth-child(even) td {
            background-color: #f1f1f1;
        }

        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }

        .back-button {
            background-color: #2980b9;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            display: inline-block;
            margin-top: 20px;
        }

        .back-button:hover {
            background-color: #1c6e8c;
        }

 
        .icon {
            margin-right: 8px;
        }

        @media (max-width: 768px) {
            table {
                font-size: 14px;
            }

            .order-summary {
                padding: 15px;
            }
        }
    </style>
</head>
<body>

<div class="container">

    <div class="order-summary">
        <h1><i class="fas fa-box-open icon"></i>Chi tiết đơn hàng: ${order.id}</h1>

        <p><strong><i class="fas fa-user icon"></i>Người nhận:</strong> ${order.receiverName}</p>
        <p><strong><i class="fas fa-map-marker-alt icon"></i>Địa chỉ:</strong> ${order.receiverAddress}</p>
        <p><strong><i class="fas fa-phone-alt icon"></i>Số điện thoại:</strong> ${order.receiverPhone}</p>
        <p><strong><i class="fas fa-calendar-day icon"></i>Ngày đặt hàng:</strong> ${order.orderDate}</p>
        <p><strong><i class="fas fa-money-bill-wave icon"></i>Tổng giá trị:</strong> ${order.totalPrice} VND</p>
        <p><strong><i class="fas fa-cogs icon"></i>Trạng thái:</strong> ${order.status}</p>
    </div>


  
    <table>
        <thead>
            <tr>
                <th>Sản phẩm</th>
                <th>Số lượng</th>
                <th>Giá</th>
                <th>Màu sắc</th>
                <th>Kích thước</th>
                <th>Ảnh</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="detail" items="${orderDetails}">
                <tr>
                    <td>${detail.productDetail.product.name}</td>
                    <td>${detail.quantity}</td>
                    <td>${detail.price} VND</td>
                    <td>${detail.color}</td>
                    <td>${detail.size}</td>
                    <td>
                        <img src="/images/productDetails/${detail.productDetail.product.image}" alt="Product Image" class="product-image">
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>


    <a href="/user/order-history" class="back-button"><i class="fas fa-arrow-left"></i> Quay lại trang lịch sử đơn hàng</a>
</div>

</body>
</html>
