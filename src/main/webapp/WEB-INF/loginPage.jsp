<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" href="/css/login.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <title>Login Page</title>
</head>
<body style="background-color: #283454; color: white">
<style>
  body{
    overflow: hidden;
  }

  .signup-form{
    display: flex;
    justify-content: center;
  }

  .form-wrapper {
    padding: 0% 10%;
    color: black;
    display: flex;
    justify-content: space-between;
    align-items: center;
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

</style>

<div style="display: flex; justify-content: center; align-items:center; margin: 8% auto;">
  <div style="display: flex; width: 50%">
    <div style="width: 50%;background-color: #fafafb; color: black">
      <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#home">Sign up</a></li>
        <li><a data-toggle="tab" href="#menu1">Sign In</a></li>
      </ul>

      <div class="tab-content">
        <div id="home" class="tab-pane fade in active" style="height: auto;">
          <form:form action="/register" method="post" modelAttribute="newUser">
            <span class="signup-form">
              <c:if test="${logoutMessage != null}">
                <c:out value="${logoutMessage}"></c:out>
              </c:if>
              <h1>Sign Up</h1>
              <c:if test="${errorMessage != null}">
                <c:out value="${errorMessage}"></c:out>
              </c:if>
            </span>
            <div class="form-wrapper">
              <div>
                <p>First Name:</p>
                <p><form:errors path="firstName" class="text-danger"/></p>
              </div>
              <p><form:input class="input" path="firstName"/></p>
            </div>
            <div class="form-wrapper">
              <div>
                <p class="float-left">Last Name:</p>
                <p><form:errors path="lastName" class="text-danger"/></p>
              </div>
              <p class="float-left"><form:input class="input" path="lastName"/></p>
            </div>
            <div class="form-wrapper">
              <div>
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
              <input class="button" type="submit" value="Submit"/>
            </div>
          </form:form>
        </div>
        <div id="menu1" class="tab-pane fade" style="height: 450px">
          <form:form action="/login" method="post" modelAttribute="newLogin">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <span class="signup-form">
              <c:if test="${logoutMessage != null}">
                <c:out value="${logoutMessage}"></c:out>
              </c:if>
              <h1>Sign In</h1>
              <c:if test="${errorMessage != null}">
                <c:out value="${errorMessage}"></c:out>
              </c:if>
            </span>
            <div class="form-wrapper">
              <h4 class="float-left">Email:</h4>
              <h4 class="float-left"><form:input class="input" path="email"/></h4>
            </div>
            <div class="form-wrapper">
              <h4><form:errors path="email" class="text-danger"/></h4>
            </div>
            <div class="form-wrapper">
              <h4 class="float-left">Password:</h4>
              <h4 class="float-left"><form:input class="input" path="password" type="password"/></h4>
            </div>
            <div class="form-wrapper">
              <h4><form:errors path="password" class="text-danger"/></h4>
            </div>
            <div class="form-wrapper form-button">
              <input class="button" type="submit" value="Submit"/>
            </div>
          </form:form>
        </div>
      </div>
    </div>
    <div style="width: 50%; position: relative; bottom: 2px">
      <img src="${pageContext.request.contextPath}/images/walletLogin.gif" width="100%%" height="100%">
    </div>
  </div>
</div>

</body>
</html>
