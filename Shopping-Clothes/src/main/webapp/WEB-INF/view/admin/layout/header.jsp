<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!-- ======= Header ======= -->
        <header id="header" class="header fixed-top d-flex align-items-center">

            <div class="d-flex align-items-center justify-content-between">
                <a href="index.html" class="logo d-flex align-items-center">
                    <img src="assets/img/logo.png" alt="">
                    <span class="d-none d-lg-block">NiceAdmin</span>
                </a>
                <i class="bi bi-list toggle-sidebar-btn"></i>
            </div><!-- End Logo -->



            <nav class="header-nav ms-auto">
                <ul class="d-flex align-items-center">

                    <li class="nav-item dropdown">
                        <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown" id="messageDropdown">
                            <i class="bi bi-chat-left-text"></i>
                            <span class="badge bg-success badge-number" id="newMessagesCount">${totalMessages}</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow messages" id="messagesDropdown">
                            <li class="dropdown-header">
                                Bạn có <span id="messageCount">${totalMessages}</span> tin nhắn mới
                                <a href="/admin/dashboard/messages">
                                    <span class="badge rounded-pill bg-primary p-2 ms-2">Xem tất cả</span>
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <!-- Lặp qua các tin nhắn gần đây -->
                            <c:forEach var="messageHistory" items="${recentMessages}" varStatus="status">
                                <c:if test="${status.index < 5}">
                                    <li class="message-item">
                                        <a href="/admin/dashboard/messages">
                                            <img src="/images/avatar/${messageHistory.sender.avatar}" alt=""
                                                class="rounded-circle">
                                            <div>
                                                <h4>${messageHistory.sender.name}</h4>
                                                <p>${messageHistory.content}</p>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                </c:if>
                            </c:forEach>

                            <li class="dropdown-footer">
                                <a href="/admin/dashboard/messages">Xem tất cả</a>
                            </li>
                        </ul>
                    </li>









                    <li class="nav-item dropdown pe-3">
                        <c:if test="${not empty pageContext.request.userPrincipal}">
                            <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#"
                                data-bs-toggle="dropdown">

                                <span class="d-none d-md-block dropdown-toggle ps-2">
                                    <c:out value="${pageContext.request.userPrincipal.name}" />
                                </span>
                            </a><!-- End Profile Iamge Icon -->



                            <div class="dropdown my-auto">
                                <a href="#" class="dropdown" role="button" id="dropdownMenuLink"
                                    data-bs-toggle="dropdown" aria-expanded="false" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                    <i class="fas fa-user fa-2x"></i>
                                </a>

                                <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="dropdownMenuLink">
                                    <li class="d-flex align-items-center flex-column" style="min-width: 300px;">
                                        <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;"
                                            src="/images/products/1732193890952-anh_sp.jpg" />

                                    </li>

                                    <li><a class="dropdown-item" href="#">Quản lý tài khoản</a></li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <li>
                                        <form method="post" action="/logout">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <i class="bi bi-box-arrow-right"> <button class="dropdown-item">Đăng
                                                    xuất</button></i>

                                        </form>
                                    </li>
                                </ul>
                            </div>

                        </c:if>



                    </li><!-- End Profile Nav -->

                </ul>
            </nav><!-- End Icons Navigation -->

        </header><!-- End Header -->