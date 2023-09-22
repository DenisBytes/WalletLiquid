<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/admin.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body class="special-darkgreen">
<nav class="d-flex justify-content-between align-items-center p-2">
    <div class="d-flex justify-content-between align-items-center nav-logo nav-brand">
        <div class="d-flex align-items-center">
            <a class="d-flex" href="/trade"><img id="nav-logo-img" src="${pageContext.request.contextPath}/images/hyperliquid1.gif"></a>
            <a class="d-flex text-decoration-none text-white" href="/trade"><h3>Wallet<h3 style="font-style: italic;">liquid</h3></h3></a>
        </div>
        <a href="/trade" class="text-muted text-decoration-none"><h5>Trade</h5></a>
        <a href="/leaderboard" class="text-muted text-decoration-none" ><h5>Leaderboard</h5></a>
        <a href="/history/${currentUser.id}" class="text-muted text-decoration-none" ><h5>Trade History</h5></a>
    </div>
    <div class="d-flex nav-brand justify-content-around">
        <h3>Welcome ${currentUser.firstName}</h3>
        <a href="#" class="d-flex"><img src="${pageContext.request.contextPath}${currentUser.image}" alt="Not found" width="50px" height="50px" style="background-color: transparent"/></a>
        <form id="logoutForm" method="POST" action="/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input class="p-2 nav-btn" type="submit" value="Logout!" />
        </form>
    </div>
</nav>


<div class="m-4 p-4 d-flex justify-content-center special-darkgreen">
    <div class="login_form_container m-4">
        <div class="login_form" style="text-align: center">
            <h1>User List</h1>
            <table style="width: 100%">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${usersList}">
                    <c:if test = "${!user.roles.get(0).name.contains('ROLE_SUPER_ADMIN')}">
                        <tr>
                            <td>${user.firstName} ${user.lastName}</td>
                            <td>${user.email}</td>
                            <c:if test = "${currentUser.roles.get(0).name.contains('ROLE_SUPER_ADMIN')}">
                                <c:if test = "${user.roles.get(0).name.contains('ROLE_USER')}">
                                    <td><a href="/delete/${user.id}">Delete</a> <a href="/admin/${user.id}">Make Admin</a></td>
                                </c:if>
                                <c:if test = "${user.roles.get(0).name.contains('ROLE_ADMIN')}">
                                    <td><a href="/delete/${user.id}">Delete</a>  Admin</td>
                                </c:if>
                            </c:if>
                            <c:if test = "${currentUser.roles.get(0).name.contains('ROLE_ADMIN')}">
                                <c:if test = "${user.roles.get(0).name.contains('ROLE_USER')}">
                                    <td><a href="/admin/${user.id}">Make Admin</a></td>
                                </c:if>
                                <c:if test = "${user.roles.get(0).name.contains('ROLE_ADMIN')}">
                                    <td>Admin</td>
                                </c:if>
                            </c:if>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
