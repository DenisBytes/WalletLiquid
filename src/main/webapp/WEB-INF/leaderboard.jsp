<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>

        nav{
            background-color: black;
            width: 100%;
        }

        #nav-logo-img{
            padding: 0% 2%;
            width: 75px;
            height: 75px;
        }
        .nav-logo{
            color: white;
        }

        .nav-btn{
            background-color: blue;
            color: white;
            border-radius: 5%;
            border: 1px solid blue;

        }

        body {
            background-color: black;
            color: white;
        }

        main{
            background-color: black;

        }

        h2 {
            color: white;
        }

        div{background-color: black;

        }
        table {
            color: white;
            font-size: 12px;
        }

        .table-container > div {
            flex-grow: 1;
        }

        th{
            color: white;
        }
        td{
            color: white;
        }
        table{
            align-items: center;
            text-align: center;
        }

    </style>
</head>
<body>
<nav class="d-flex justify-content-between align-items-center p-2">
    <div class="d-flex justify-content-between align-items-center nav-logo" style="width: 40%">
        <img id="nav-logo-img" src="${pageContext.request.contextPath}/images/hyperliquid1.gif">
        <div class="d-flex">
            <h3 style="margin-left: 5px;font-family: 'Libre Baskerville';">Wallet<h3 style="font-style: italic;font-family: 'Libre Baskerville'">liquid</h3></h3>
        </div>
        <a href="/trade" class="text-muted text-decoration-none" ><h5>Trade</h5></a>
        <a href="/history/${user.id}" class="text-muted text-decoration-none" ><h5>Trade History</h5></a>
    </div>
    <div class="d-flex w-25 justify-content-around">
        <h3>Welcome ${user.firstName}</h3>
        <img src="${pageContext.request.contextPath}${user.image}" alt="Not found" width="50px" height="50px" style="background-color: white; border: white 2px solid"/>
        <a href="/logout"><button class="p-2 nav-btn">Log out</button></a>
    </div>
</nav>
<main class="w-100 p-4">
    <table class="table">
        <thead>
        <th scope="col">Rank</th>
        <th scope="col">User</th>
        <th scope="col">Portfolio Value</th>
        </thead>
        <tbody>
        <c:forEach var="user" items="${userList}" varStatus="loop">
            <tr>
                <td>${loop.index + 1}</td>
                <td><a href="/leaderboard/${user.id}">${user.firstName} ${user.lastName}</a></td>
                <td>${user.usd}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</main>
</body>
</html>
