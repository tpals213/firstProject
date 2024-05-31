<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SSM ERROR</title>
<style type="text/css">
	.map-container {
		padding: 140px 0 40px 0;
		display: flex;
		justify-content: center;
	}
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<div class="map-container">
		<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d791.3219877445524!2d127.02437543300435!3d37.501126172421465!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca158dc0da425%3A0x6d7b181daa2e6a55!2z7ISc7Jq47Yq567OE7IucIOyEnOy0iOq1rCDshJzstIjrj5kgMTMwOC02!5e0!3m2!1sko!2skr!4v1712661830261!5m2!1sko!2skr" 
		width="800" height="600" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
	</div>
	<c:import url="footer.jsp" />
</body>
</html>







