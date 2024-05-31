<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath }/resources/css/common/header.css" />
<script type="text/javascript" src="/ssm/resources/js/jquery-3.7.0.min.js"></script>

<link rel="stylesheet"
	href="/ssm/resources/css/jquery-ui-themes-1.13.2/themes/base/jquery-ui.css" />
<script type="text/javascript"
	src="/ssm/resources/css/jquery-ui-1.13.2/jquery-ui.min.js"></script>

<script type="text/javascript">
	$(function(){
		$('#noUserHeader li:nth-child(2) a, #noUserHeader li:nth-child(3) a, #noUserHeader li:nth-child(4) a').click(function() {
	        alert("로그인 후 이용하실 수 있습니다!");
	    });
	}); // document ready
	
	const logout = () => {
		
		if(confirm("로그아웃 하시겠습니까?")) {
			location.href='logout.do';		
		} else {
			return false;
		}
		
	}
</script>
</head>
<body>
	<%-- 로그인 안한 경우 --%>
	<c:if test="${ empty sessionScope.loginUser }">
		<header>
			<div class="inner-header">
				<nav>
					<h1 class="logo">
					<c:url var="callMain" value="main.do" />
						<a href= "${ callMain }"> 
							<img src="${pageContext.servletContext.contextPath }/resources/images/common/logo.png" alt="logo" />
						</a>
					</h1>
					<div class="gnb">
						<ul id="noUserHeader">
							<li><a href="${pageContext.servletContext.contextPath }/nlist.do?page=1">공지사항</a></li>
							<li><a href="${pageContext.servletContext.contextPath }/goLogin.do">불편사항</a></li>
							<li><a href="${pageContext.servletContext.contextPath}/goLogin.do">매장관리</a></li>
							<li><a href="${pageContext.servletContext.contextPath }/goLogin.do">구독하기</a></li>
						</ul>
					</div>
					<div class="login-box">
						<div class="login-button-box">
							<button onclick="location.href='goLogin.do'">로그인</button>
						</div>
					</div>
				</nav>
			</div>
		</header>
	</c:if>
	
	<%-- 유저 로그인 --%>
	<c:if test="${ !empty loginUser &&  loginUser.adminOk ne 'Y'}">
		<header>
			<div class="inner-header">
				<nav>
					<h1 class="logo">
						<c:url var="callMain" value="main.do" />
						<a href= "${ callMain }">
							<img src="${pageContext.servletContext.contextPath }/resources/images/common/logo.png" alt="logo" />
						</a>
					</h1>
					</h1>
					<div class="gnb">
						<ul>			
							<li><a href="${pageContext.servletContext.contextPath }/nlist.do?page=1">공지사항</a></li>
							<li><a href="${pageContext.servletContext.contextPath }/inconvlist.do?page=1">불편사항</a></li>
							<li><a href="${pageContext.servletContext.contextPath}/mvwelcom.do?userId=${loginUser.userId}">매장관리</a></li>
							<li><a href="${pageContext.servletContext.contextPath }/slist.do">구독하기</a></li>
						</ul>
					</div>
					<div class="login-box">
						<div class="profile-img-box">
							<c:url var="goMyPage" value="goMyPage.do">
								<c:param name="userId" value="${ loginUser.userId }" />
								<c:param name="profileUrl" value="${ loginUser.profileUrl }" />
							</c:url>
							<a href="${ goMyPage }">
								<c:if test="${empty loginUser.profileUrl }">
									<img src="${pageContext.servletContext.contextPath }/resources/images/common/profile.png" alt="프로필" class="photo">
								</c:if>
								<c:if test="${!empty loginUser.profileUrl }">
									<img src="resources/user_upfiles/${loginUser.profileUrl}" alt="프로필" class="photo">
								</c:if>
							</a>							
						</div>
						<div class="login-button-box">
							<button onclick="logout()">로그아웃</button>
						</div>
					</div>
				</nav>
			</div>
		</header>
	</c:if>
	
	<%-- 관리자 로그인 --%>
	<c:if test="${ !empty loginUser &&  loginUser.adminOk eq 'Y'}">
		<header>
			<div class="inner-header">
				<nav>
					<h1 class="logo">
						<c:url var="callMain" value="main.do" />
						<a href= "${ callMain }"> 
							<img src="${pageContext.servletContext.contextPath }/resources/images/common/logo.png" alt="logo" />
						</a>
					</h1>
					<div class="gnb">
						<ul>
							<li><a href="${pageContext.servletContext.contextPath }/nlist.do?page=1">공지글 관리</a>
							<li><a href="${pageContext.servletContext.contextPath }/ulist.do?page=1">사용자 관리</a></li>
							<li><a href="${pageContext.servletContext.contextPath }/inconvlist.do?page=1">불편사항 관리</a></li>
							<li><a href="msubscribe.do">구독상품 관리</a></li>
						</ul>
					</div>
					<div class="login-box">
						<div class="profile-img-box">
							<c:url var="goMyPage" value="goMyPage.do">
								<c:param name="userId" value="${ loginUser.userId }" />
							</c:url>
							<a href="${ goMyPage }">
								<c:if test="${empty loginUser.profileUrl }">
									<img src="${pageContext.servletContext.contextPath }/resources/images/common/profile.png" alt="프로필" class="photo">
								</c:if>
								<c:if test="${!empty loginUser.profileUrl }">
									<img src="resources/user_upfiles/${loginUser.profileUrl}" alt="프로필" class="photo">
								</c:if>
							</a>							
						</div>
						<div class="login-button-box">
							<button onclick="logout()">로그아웃</button>
						</div>
					</div>
				</nav>
			</div>
		</header>
	</c:if>
</body>
</html>