<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
* {
    margin: 0;
    padding: 0;
}
.container, .userInfo {
	font-family: sans-serif;
	padding: 20px;
	margin: 25px auto;
	width: 1400px;
	background-color : lightgray;
	display :flex;
}
.userInfo{
	display : flex;
	justify-content: flex-end;
	font-size : 20px;
	color : black;
	font-weight: bolder;
}
.userInfoP{
	margin-right : 150px;
}
.inner{
	width:600px;
	height:500px;
	margin : 50px;
}
.image{
	width:500px;
	height: 300px;
	margin : 50px 0px 0px 0px;
}
.image img{
    max-width: 50%; 
    height: auto; 
    display: block; 
}
.title{
	width:500px;
	height: 100px;
	margin : 25px 0px 25px 0px;
	display: flex;
    align-content: space-around;
    flex-wrap: wrap;
    justify-content: center;
}
.title p{
	text-align : center;
	font-size : 30px;
	color : white;
	font-weight: bolder;
}
.left{
background-color: MidnightBlue;
margin-left : 100px;
    display: flex;
    flex-wrap: wrap;
    align-content: space-around;
    justify-content: space-around;
}
.right{
background-color: DarkGreen;
margin-right : 100px;
    display: flex;
    flex-wrap: wrap;
    align-content: space-around;
    justify-content: space-around;
}
.onclick {
            cursor: pointer; 
        }
</style>
<title>Insert title here</title>
<script type="text/javascript" src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
function mvTablePos(){
	window.open('mvTablePos.do?id='+${loginUser.id}, '_blank');
}
function mvNoTablePos(){
	window.location.href = '${pageContext.servletContext.contextPath}/mvNoTablePos.do?id=${loginUser.id}';
}
</script>
</head>
<body>
<c:import url="/WEB-INF/views/common/header.jsp" />
<div style="padding-top : 100px;">
<c:import url="/WEB-INF/views/common/sidebar.jsp" />
<div class="main-container" style="padding-top:100px;">
<div class="container">
<div class="inner">
<div class="image left onclick" onclick="mvTablePos();">
<img src="resources/images/posImage/table.png">
</div>
<div class="title left onclick" onclick="mvTablePos();">
<p>Table</p>
</div>
<input type="hidden" id="id" value="${loginUser.id}">
</div>
<div class="inner">
<div class="image right onclick" onclick="mvNoTablePos()">
<img src="resources/images/posImage/notable.png">
</div>
<div class="title right onclick" onclick="mvNoTablePos()">
<p>No Table</p>
</div>
</div>
</div>
<div class="userInfo"><p class="userInfoP">아이디 : ${loginUser.userId} &nbsp;&nbsp;&nbsp;&nbsp;매장명 : ${loginUser.businessStoreName }</div>

</div>
<c:import url="footer.jsp" />
</div>
</body>
</html>