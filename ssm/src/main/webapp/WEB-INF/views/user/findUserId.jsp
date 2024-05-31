<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/user/login.css">
<link rel="stylesheet" href="resources/css/user/enroll.css">
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.0.min.js"></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.1/kakao.min.js" integrity="sha384-kDljxUXHaJ9xAb2AzRd59KxjrFjzHa5TAoFQ6GbYTCAG0bjM55XohjjDT7tDDC01" crossorigin="anonymous"></script>
<script>

$(() => {
	const userIdLength = $("#userId").val().length;
	if (userIdLength > 0) {
		$("li.user-id > p").eq(0).css("color", "orange");
	} else {
	    $("li.user-id > p").eq(0).html("해당 아이디가 존재하지 않습니다.").css("color", "red");
	}
}); //doc ready;

</script>
</head>
<body>
	<div class="enroll-box">
		<div class="inner-box">
			<div class="logo-box">
				<h1 class="logo">
					<c:url var="callMain" value="main.do" />
					<a href="${ callMain }">
					 	<img src="${pageContext.servletContext.contextPath }/resources/images/common/logo.png" alt="logo" />
					 </a>
				</h1>
			</div>
			<div class="form-box  findId-box">
				<ul>
					<li class="user-id">
						<p>가입한 날짜 : ${ findUser.lastModified }</p>
						<c:if test="${ empty findUser.userId }">
							<input type="text" name="userId" id="userId" placeholder="아이디" value="일치하는 아이디가 없습니다" readonly>
						</c:if>
						<c:if test="${ !empty findUser.userId }">
							<input type="text" name="userId" id="userId" placeholder="아이디" value="아이디 : ${findUser.userId}" readonly>
						</c:if>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>