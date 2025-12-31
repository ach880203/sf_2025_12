<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>GoldenBook</title>

  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- ⭐ GoldenBook CSS (이게 핵심) -->
  <link rel="stylesheet"
        href="${pageContext.request.contextPath}/resources/css/style.css?v=20251231">

</head>
<body>

<header class="app-header">
  <div class="header-inner">

    <a href="/" class="logo">💰 GoldenBook</a>

    <nav class="main-nav">
      <a href="/community/list">커뮤니티</a>
      <a href="/accountbook/list">가계부</a>
    </nav>

    <div class="auth-box">
      <sec:authorize access="isAuthenticated()">
        로그인 됨💰<sec:authentication property="principal.uid"/>
        <a href="/account/logout" class="logout-btn">로그아웃</a>
      </sec:authorize>

      <sec:authorize access="isAnonymous()">
        <a href="/account/login" class="login-btn">로그인</a>
      </sec:authorize>
    </div>

  </div>
</header>

<main class="main-container">
