<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/editprofile.css">
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
    </div>
    <div class="d-flex nav-brand justify-content-around">
        <h3>Welcome ${user.firstName}</h3>
        <a href="#" class="d-flex"><img src="${pageContext.request.contextPath}${user.image}" alt="Not found" width="50px" height="50px" style="background-color: transparent"/></a>
        <form id="logoutForm" method="POST" action="/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input class="p-2 nav-btn" type="submit" value="Logout!" />
        </form>
    </div>
</nav>

<div class="m-4 p-4 d-flex justify-content-center special-darkgreen">
    <div class="login_form_container m-4">
        <div class="login_form" style="text-align: center">
            <form:form action="/edit/profile" method="put" modelAttribute="user">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <h1 class="p-4">Edit Profile</h1>
            <div class="form-wrapper">
                <div style="background-color: black">
                    <p>First Name:</p>
                    <p><form:errors path="firstName" class="text-danger"/></p>
                </div>
                <p><form:input class="input" path="firstName"/></p>
            </div>
            <div class="form-wrapper">
                <div style="background-color: black">
                    <p class="float-left">Last Name:</p>
                    <p><form:errors path="lastName" class="text-danger"/></p>
                </div>
                <p class="float-left"><form:input class="input" path="lastName"/></p>
            </div>
            <div class="form-wrapper">
                <div style="background-color: black">
                    <p class="float-left">Email:</p>
                    <p><form:errors path="email" class="text-danger"/></p>
                </div>
                <p class="float-left"><form:input class="input" path="email"/></p>
            </div>

            <div class="form-wrapper">
                <div>
                    <p class="float-left">Password:</p>
                    <p><form:errors path="password" class="text-danger"/></p>
                </div>
                <p class="float-left"><form:input class="input" path="password" type="password"/></p>
            </div>
            <div class="form-wrapper">
                <div>
                    <p class="float-left">Confirm PW:</p>
                    <p><form:errors path="confirm" class="text-danger"/></p>
                </div>
                <p class="float-left"><form:input class="input" path="confirm" type="password"/></p>
            </div>
            <div class="form-wrapper form-button">
                <input type="hidden" name="id" value="${user.id}" />
                <input class="button nav-btn" type="submit" value="Submit"/>
            </div>
        </form:form>
        </div>
    </div>
</div>

</body>
</html>
