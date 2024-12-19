<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Liên Hệ - Nhóm 7</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f9fa;
                color: #333;
                overflow-x: hidden;
            }

            header {
                background-color: #007bff;
                padding: 30px;
                text-align: center;
                color: #fff;
                position: relative;
            }

            header .logo {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                animation: spin 5s linear infinite;
            }

            header h1 {
                margin: 10px 0;
                font-size: 28px;
                animation: fadeIn 1.5s ease;
            }

            @keyframes spin {
                0% {
                    transform: rotate(0deg);
                }

                100% {
                    transform: rotate(360deg);
                }
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .contact-container {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                padding: 40px;
                margin: 20px auto;
                max-width: 1200px;
            }

            .contact-info,
            .team {
                flex: 1;
                margin: 10px;
                min-width: 300px;
            }

            .contact-info h2,
            .team h2 {
                font-size: 28px;
                margin-bottom: 20px;
                text-align: center;
                color: #007bff;
            }

            .contact-info p,
            .team p {
                font-size: 16px;
                margin: 10px 0;
                text-align: center;
            }

            .team-members {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
            }

            .team-member {
                width: 40%;
                margin: 10px;
                text-align: center;
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .team-member:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            }

            .team-member img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                border: 3px solid #007bff;
                margin-bottom: 10px;
                transition: transform 0.3s ease-in-out;
            }

            .team-member img:hover {
                transform: scale(1.1);
            }

            footer {
                background-color: #007bff;
                color: #fff;
                text-align: center;
                padding: 15px;
                margin-top: 40px;
                font-size: 14px;
            }

            .back-button {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 5px;
                margin: 20px auto;
                display: inline-block;
                transition: background-color 0.3s, transform 0.2s;
            }

            .back-button:hover {
                background-color: #0056b3;
                transform: translateY(-3px);
            }
        </style>
    </head>

    <body>

        <header>
            <img src="/images/products/logo_nhom7.webp" alt="Logo Nhóm 7" class="logo">
            <h1>Liên Hệ Với Nhóm 7</h1>
        </header>

        <div class="contact-container">
            <div class="contact-info">
                <h2>Thông Tin Liên Hệ</h2>
                <p><strong>Nhóm 7 - Đồ Án Chuyên Ngành</strong></p>
                <p><strong>Số Điện Thoại:</strong> 0988035928</p>
                <p><strong>Email:</strong> nhom7@gmail.com</p>
                <p><strong>Địa Chỉ:</strong> Khuôn viên trường ĐẠI HỌC CÔNG NGHIỆP HÀ NỘI</p>
            </div>
            <div class="team">
                <h2>Thành Viên Nhóm</h2>
                <div class="team-members">
                    <div class="team-member">
                        <img src="/images/products/hacker.png" alt="Vũ Đức Doanh">
                        <p>Vũ Đức Doanh</p>
                    </div>
                    <div class="team-member">
                        <img src="/images/products/hacker.png" alt="Nguyễn Đăng Đức">
                        <p>Nguyễn Đăng Đức</p>
                    </div>
                    <div class="team-member">
                        <img src="/images/products/hacker.png" alt="Thái Bá Đức">
                        <p>Thái Bá Đức</p>
                    </div>
                    <div class="team-member">
                        <img src="/images/products/hacker.png" alt="Đàm Lưu Đức Dương">
                        <p>Đàm Lưu Đức Dương</p>
                    </div>
                </div>
            </div>
        </div>

        <div style="text-align: center;">
            <a href="/admin" class="back-button">Quay về trang Admin</a>
        </div>

        <footer>
            <p>&copy; 2024 Nhóm 7. Tất cả quyền được bảo lưu.</p>
        </footer>

    </body>

    </html>