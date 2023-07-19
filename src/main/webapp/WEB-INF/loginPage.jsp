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
<body>
<style>
  body{
    overflow: hidden;
    background-color: #283454;
    color: white;
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

<div class="outside">
  <div class="inside" style="width: 1000px">
    <div class="left">
      <ul class="nav nav-tabs">
        <li class="active"><a data-toggle="tab" href="#signup">Sign up</a></li>
        <li><a data-toggle="tab" href="#signin">Sign In</a></li>
      </ul>

      <div class="tab-content">
        <div id="signup" class="tab-pane fade in active" style="height: 500px;">
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
              <div style="display: flex">
                <p>First Name:</p>
                <p><form:errors path="firstName" class="text-danger"/></p>
              </div>
              <p><form:input class="input" path="firstName"/></p>
            </div>
            <div class="form-wrapper">
              <div style="display: flex">
                <p class="float-left">Last Name:</p>
                <p><form:errors path="lastName" class="text-danger"/></p>
              </div>
              <p class="float-left"><form:input class="input" path="lastName"/></p>
            </div>
            <div class="form-wrapper">
              <div style="display: flex">
                <p class="float-left">Email:</p>
                <p><form:errors path="email" class="text-danger"/></p>
              </div>
              <p class="float-left"><form:input class="input" path="email"/></p>
            </div>

            <div class="form-wrapper">
              <div style="display: flex">
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
        <div id="signin" class="tab-pane fade" style="height: 500px;">
          <div style="align-items: center; height: 100%">
            <form:form action="/login" method="post" modelAttribute="newLogin">
              <!--<input type="hidden" name="$ {_csrf.parameterName}" value="$ {_csrf.token}"/>-->
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
    </div>
    <div class="right">
      <img src="${pageContext.request.contextPath}/images/walletLogin.gif" width="100%%" height="100%">
    </div>
  </div>
</div>

</body>
</html>
