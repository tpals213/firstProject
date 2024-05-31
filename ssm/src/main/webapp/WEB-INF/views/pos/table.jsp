<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/resources/css/common/reset.css" />
<style>
.wrap {
	width: 1000px;
	padding: 10px 600px 50px 600px;
}

.header {
	background-color: orange;
	width: 100%;
	height: 10vh;
	font-size : 30px;
	text-align : center;
	display: flex;
    flex-wrap: nowrap;
    justify-content: center;
    align-items: center;
    font-weight:700;
}

.body, .footer {
	background-color: lightgray;
	width: 100%;
}

.body {
	height: 60vh;
	position: relative;
}
.body a {
	min-width: 150px;
	min-height: 200px;
	max-width: 150px;
	max-height: 200px;
	text-decoration: none;
	text-align: center;
	line-height: 80px;
	background-color: white;
	border: 2px solid black;
	border-radius: 8px;
	margin-bottom: 4px;
	position: absolute;
}

.footer {
	height: 20vh;
	display: flex;
	justify-content: flex-end;
}

.inner-footer {
	padding-right: 50px;
}

.setting-image {
	width: 100px;
	background-color: SkyBlue;
	padding: 0px;
	transition: transform 0.3s, cursor 0.3s;
}

.setting-image img {
	width: 100%;
	height: 100px;
	display: block;
}

.setting-image:hover {
	cursor: pointer;
	transform: scale(1.1);
}
.title p{
	color : black;
	font-weight: bolder;
}
</style>
<meta charset="UTF-8">
<title>SSM웹포스기</title>
</head>
<body>
	<div class="wrap">
		<div class="header"><p class="title">SSM 웹 포스기</p></div>
		<div class="body">
		<c:forEach items="${requestScope.list}" var="t">
		<a class="table" id="${t.tableName }" style="left:${t.tableX}px;top:${t.tableY}px">${t.tableName }</a>
</c:forEach>
		</div>
		<div class="footer">
			<div class="inner-footer">
				<div class="setting-image" onclick="location.href='mvPosSetting.do?id=${loginUser.id}'">
					<img src="resources/images/posImage/setting.png">
				</div>
			</div>
		</div>
	</div>
</body>
</html>