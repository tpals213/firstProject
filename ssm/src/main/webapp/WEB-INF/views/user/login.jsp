<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/user/login.css">
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
const validateForm = () => {
	if (!$("#userId").val()) {
	    alert("아이디를 입력해주세요.");
	    return false;
	} else if (!$("#passWd").val()) {
	    alert("비밀번호를 입력해주세요.");
	    return false;
	}
    return true; 
}
	
</script>
</head>
<body>
	<div class="login-box">
		<div class="inner-box">
			<div class="logo-box">
				<h1 class="logo">
					<c:url var="callMain" value="main.do" />
					<a href="${ callMain }">
						 <img src="${pageContext.servletContext.contextPath }/resources/images/common/logo.png" alt="logo" />
					 </a>
				</h1>
			</div>
			<div class="form-box">
				<form action="login.do" method="post" onsubmit="return validateForm();">
					<ul>
						<li>
							<input type="text" name="userId" id="userId" placeholder="아이디">
						</li>
						<li>
							<input type="password" name="passWd" id="passWd" placeholder="비밀번호">
						</li>
						<li>
							<input type="submit" value="로그인" class="login">
						</li>
					</ul>
				</form>
				<ul class="go-page">
					<li>
						<a href="${pageContext.servletContext.contextPath }/goSearchId.do">아이디 찾기</a> | 
						<a href="${pageContext.servletContext.contextPath }/goSearchPw.do">비밀번호 찾기</a> | 
						<c:url var="goEnroll" value="goEnroll.do" /> 
						<a href="${ goEnroll }">회원가입</a></li>
					<li>
						<p>------------------- 또는 --------------------</p>
					</li>
					<li>
						<ul class="sns">
							<li>
						 		<a href="${ kakaourl }"> 
									 <img src="${pageContext.servletContext.contextPath }/resources/images/snsLogin/kakaoLB.png" alt="카카오로고" />
								</a>
							</li>
							<li>
						 		<a href="${ naverurl }"> 
									<img src="${pageContext.servletContext.contextPath }/resources/images/snsLogin/naverLB.png" alt="네이버로고" />
								</a>
							</li>
							<li>
						 		<a href="${ googleurl }"> 
								 	<img src="${pageContext.servletContext.contextPath }/resources/images/snsLogin/googleLB.png" alt="구글로고" />
								</a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>