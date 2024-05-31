<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SSM ERROR</title>
<style type="text/css">
	.error-container {
		padding: 188px 20px 450px 20px;;
	}
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<div class="error-container">
		<h1> 아직 준비중 입니다.</h1>
		<c:url var="movemain" value="main.do" />
	</div>
		<c:import url="footer.jsp" />
</body>
</html>







