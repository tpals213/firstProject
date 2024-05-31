<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>공지사항상세</title>
<style>
* {
    margin: 0;
    padding: 0;
}

.container {
	font-family: arial;
	font-size: 18px;
	padding: 20px;
	margin: 25px auto;
	width: 800px;
	outline: dashed 1px black;
}

h3 {
    color: #333;
    margin-bottom: 10px;
}

.container span {
    color: #666;
}

.contentbox {
    font-size: 18px; 
    line-height: 1.5;
    margin-bottom: 20px;
    min-height: 400px;
}

.btnbox {
    margin-top: 20px;
}

.btnbox button,
.btnbox a {
    display: inline-block;
    padding: 10px 20px;
    margin-right: 10px;
    background-color: rgb(250, 180, 49);
    color: white;
    text-decoration: none;
    border-radius: 5px;
    border: none;
}

.btnbox button:hover,
.btnbox a:hover {
    background-color: orange;
}
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<div class="main-container" style="padding-top:100px;">
	<div class="container">
		<br>
		<h3>${notice.noticeTitle }</h3>
		<br> <span>${notice.writer }</span> &nbsp; &nbsp; &nbsp;
		&nbsp;&nbsp; 조회수: ${notice.readCount } &nbsp; &nbsp; <span>중요도:
			${notice.importancy }</span> &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; <span>Date:
			${notice.writeDate}</span> <br>
		<hr>
		<br>
		<div class="contentbox">${notice.noticeContent }</div>
		<hr>


		<div class="btnbox">
			<c:url var="nlist" value="nlist.do">
				<c:param name="page" value='${currentPage}' />
			</c:url>
			<a href=${nlist }>목록으로</button>

			<c:if test="${sessionScope.loginUser.adminOk eq 'Y' }">
					<c:url var="aupdate" value="mvupdaten.do">
						<c:param name="noticeNo" value='${notice.noticeNo}'/>
						<c:param name="page" value='${currentPage }' />
					</c:url>
					<a href='${aupdate }'>수정</a>

				<c:url var="adelete" value="deleten.do">
					<c:param name="page" value='${currentPage}' />
					<c:param name="noticeNo" value='${notice.noticeNo }' />
				</c:url>
				<a href=${adelete}>삭제</a>
			</c:if>
		</div>
	</div>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
