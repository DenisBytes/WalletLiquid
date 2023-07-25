<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="/css/history.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body class="special-darkgreen">
<nav class="d-flex justify-content-between align-items-center p-2">
  <div class="d-flex justify-content-between align-items-center nav-logo nav-brand">
    <div class="d-flex align-items-center">
      <img id="nav-logo-img" src="${pageContext.request.contextPath}/images/hyperliquid1.gif">
      <h3>Wallet<h3 style="font-style: italic;">liquid</h3></h3>
    </div>
    <a href="/trade" class="text-muted text-decoration-none"><h5>Trade</h5></a>
    <a href="/leaderboard" class="text-muted text-decoration-none" ><h5>Leaderboard</h5></a>
  </div>
  <div class="d-flex nav-brand justify-content-around">
    <h3>Welcome ${user.firstName}</h3>
    <img src="${pageContext.request.contextPath}${user.image}" alt="Not found" width="50px" height="50px"/>
    <a href="/logout"><button class="p-2 nav-btn">Log out</button></a>
  </div>
</nav>
<main class="m-4 p-4 special-green">
  <table class="table">
    <thead>
    <th scope="col">Time</th>
    <th scope="col">Pair</th>
    <th scope="col">Amount</th>
    <th scope="col">Leverage</th>
    <th scope="col">Entry Price</th>
    <th scope="col">last Price</th>
    <th scope="col">Earnings</th>
    </thead>
    <tbody>
    <c:forEach var="transaction" items="${transactionList}">
      <tr>
        <td style="padding: 1%">${transaction.createdAt}</td>
        <c:if test="${transaction.direction eq 'long'}">
          <td style="padding: 1%" class="green">${transaction.symbol}-USD</td>
        </c:if>
        <c:if test="${transaction.direction eq 'short'}">
          <td style="padding: 1%" class="red">${transaction.symbol}-USD</td>
        </c:if>
        <td style="padding: 1%">${transaction.amount}</td>
        <td style="padding: 1%">${transaction.leverage}x</td>
        <td style="padding: 1%">${transaction.price}</td>
        <td style="padding: 1%">${transaction.lastPrice}</td>
        <c:if test="${transaction.earnings <0}">
          <td style="padding: 1%" class="red">${transaction.earnings}</td>
        </c:if>
        <c:if test="${transaction.earnings >= 0}">
          <td style="padding: 1%" class="green">${transaction.earnings}</td>
        </c:if>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</main>
</body>
</html>