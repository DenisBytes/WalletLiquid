<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/css/editProfile.css">
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .special-green{
            background-color: #0f2e29;
        }
        .special-darkgreen{
            background-color: #02221f;
        }
        .green{
            color: #02c903;
        }
        .red{
            color: #e90c2f;
        }

        .signup-form{
            display: flex;
            justify-content: center;
        }

        .signup-form{
            display: flex;
            justify-content: center;
        }

        .form-wrapper {
            padding: 0% 10%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #fff;
            margin-bottom: 16px;
        }

        .form-button{
            padding-bottom: 1%;
            display: flex;
            justify-content: center;
        }

        .button{
            background-color: blue;
            color: white;
            border-radius: 1rem;
            padding:2% 5%;
            font-size: 17px;
        }

        .outside{
            display: flex;
            justify-content: center;
            align-items:center;
            margin: 8% auto;
        }

        .inside{
            display: flex;
            width: 50%;
        }

        .left{
            width: 50%;
            background-color: #fafafb;
            color: black;
        }

        .right{
            width: 50%;
            position: relative;
            bottom: 2px;
        }

        #signup{
            height: auto;
        }
        #signin{
            height: 450px;
        }

    </style>
</head>
<body class="special-darkgreen text-white">
<nav class="d-flex justify-content-between align-items-center p-2">
    <div class="d-flex justify-content-between align-items-center nav-logo nav-brand">
        <div class="d-flex align-items-center">
            <img id="nav-logo-img" src="${pageContext.request.contextPath}/images/hyperliquid1.gif">
            <h3>Wallet<h3 style="font-style: italic;">liquid</h3></h3>
        </div>
        <a href="/leaderboard" class="text-muted text-decoration-none" ><h5>Leaderboard</h5></a>
        <a href="/history/${user.id}" class="text-muted text-decoration-none" ><h5>Trade History</h5></a>
    </div>
    <div class="d-flex nav-brand justify-content-around">
        <h3>Welcome ${user.firstName}</h3>
        <img src="${pageContext.request.contextPath}${user.image}" alt="Not found" width="50px" height="50px" style="background-color: transparent"/>
        <a href="/logout"><button class="p-2 nav-btn">Log out</button></a>
    </div>
</nav>
<main class="m-4 p-4 special-darkgreen d-flex justify-content-center">
    <div class="special-green w-50 p-4">
        <span class="d-flex justify-content-center m-4">
            <h1>Edit Profile</h1>
        </span>
        <form:form action="/edit/${user.id}" method="post" modelAttribute="user">
            <input type="hidden" name="_method" value="put">

            <div class="form-wrapper special-green">
                <div class="special-green" style="display: flex">
                    <h5>First Name:</h5>
                    <h5><form:errors path="firstName" class="text-danger"/></h5>
                </div>
                <h5><form:input class="input special-darkgreen text-white p-1" cssStyle="border: 1px solid #97fce4; border-radius: 0.5rem" path="firstName"/></h5>
            </div>
            <div class="form-wrapper special-green">
                <div class="special-green" style="display: flex">
                    <h5>Last Name:</h5>
                    <h5><form:errors path="lastName" class="text-danger"/></h5>
                </div>
                <h5><form:input class="input special-darkgreen text-white p-1" cssStyle="border: 1px solid #97fce4; border-radius: 0.5rem" path="lastName"/></h5>
            </div>
            <div class="form-wrapper special-green">
                <div class="special-green" style="display: flex">
                    <h5>Image:</h5>
                    <h5><form:errors path="image" class="text-danger"/></h5>
                </div>
                <h5><form:input id="image" type="file" accept="image/png, image/jpeg" class="input special-darkgreen text-white p-1" cssStyle="border: 1px solid #97fce4; border-radius: 0.5rem" path="image"/></h5>
            </div>
            <div class="d-flex justify-content-center special-green m-4 p-4">
                <input class="nav-btn p-2 w-25" type="submit" value="Submit"/>
            </div>
        </form:form>
    </div>
</main>
</body>
</html>
