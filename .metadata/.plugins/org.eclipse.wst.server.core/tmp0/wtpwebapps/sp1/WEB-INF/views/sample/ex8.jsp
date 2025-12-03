<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>name : ${param.name}</h1> <!-- addAttribute를 사용하면 param으로 받아야 페이지에 보인다 -->
  <h1>age : ${age}</h1> <!-- Flash로 요청 됐기때문에 단 한번만 보이고 새로고침 하면 사라진다 -->
  
</body>
</html>