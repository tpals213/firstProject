<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/user/enroll.css">
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/user/enroll.js" defer></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.1/kakao.min.js" integrity="sha384-kDljxUXHaJ9xAb2AzRd59KxjrFjzHa5TAoFQ6GbYTCAG0bjM55XohjjDT7tDDC01" crossorigin="anonymous"></script>
<script>


$(() => {
    
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
			<div class="form-box">
				<ul class="go-page">
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
				<form action="enroll.do" method="post" onsubmit="return validateForm();">
					<ul>
						<li class="auth relative first">
							<p></p>
							<c:if test="${ empty param.id }">
								<input type="text" name="userId" id="userId" placeholder="아이디">
							</c:if>
							<c:if test="${ !empty param.id }">
								<input type="text" name="userId" id="userId" placeholder="아이디" value="${param.id}">
							</c:if>
								<input type="button" value="중복검사" onclick="return dupIDCheck();">
						</li>
						<li class="relative">
							<p></p>
							<c:if test="${ empty param.id }">
								<input type="password" name="passWd" id="passWd" placeholder="비밀번호">
							</c:if>
							<c:if test="${ !empty param.id }">
								<input type="password" name="passWd" id="passWd" placeholder="비밀번호" value="${ param.passWd }">
							</c:if>
						</li>
						<li class="relative">
							<p></p>
							<c:if test="${ empty param.id }">
								<input type="password" name="passWd2" id="passWd2" placeholder="비밀번호 확인">
							</c:if>
							<c:if test="${ !empty param.id }">
								<input type="password" name="passWd2" id="passWd2" placeholder="비밀번호 확인" value="${ param.passWd }">
							</c:if>
						</li>
						<li class="auth relative">
							<p></p>
							<c:if test="${ empty param.email }">
								<input type="email" name="email" id="email" placeholder="이메일">							
							</c:if>
							<c:if test="${ !empty param.email }">
								<input type="email" name="email" id="email" placeholder="이메일" value="${ param.email}">							
							</c:if>
							<input type="button" value="이메일 인증" class="chkEMail" id="chkEMail" onclick="emailAuth();">
						</li>
						<li class="auth relative chkEmailAuth">
							<p></p>
							<input type="text"  id="chkEmailAuth" placeholder="인증번호">
							<!-- <input type="button" value="이메일 인증 확인"> -->
						</li>
						<li class="relative">
							<p></p>
							<c:if test="${ empty param.birth }">
								<input type="text" name="userNo" id="userNo" placeholder="생년월일 (ex.19980101)">
							</c:if>
							<c:if test="${ !empty param.birth }">
								<input type="text" name="userNo" id="userNo" placeholder="생년월일 (ex.19980101)" value="${ param.birth }">
							</c:if>
						</li>
						<li class="relative">
							<p></p>
							<c:if test="${ empty param.phone }">
								<input type="tel" name="phone" id="phone" placeholder="전화번호 (ex.010-1234-5678)">
							</c:if>
							<c:if test="${ !empty param.phone }">
								<input type="tel" name="phone" id="phone" placeholder="전화번호 (ex.010-1234-5678)" value="${ param.phone }">
							</c:if>
						</li>
						<li class="auth relative">
							<p></p>
							<input type="text" name="businessNo" id="businessNo" placeholder="사업자 번호 (ex.123 45 789)">
							<input type="button" value="사업자 인증" id="businessNoBtn" onclick="busicessNoChk();">
						</li>
						<li class="businessStoreName">
							<input type="text" name="businessStoreName" id="businessStoreName" readonly>						
						</li>
						<li class="auth relative">
							<p></p>
							<input type="text" name="accountNumber" id="accountNumber" placeholder="계좌번호">
							<!-- <input type="button" value="계좌인증" id="accountNumBtn" onclick="accountNumChk();"> -->
						</li>
						<li>
							<input type="submit" value="회원가입" class="enroll" id="submitBtn">
						</li>
					</ul>
				</form>
				
			</div>
		</div>
	</div>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>