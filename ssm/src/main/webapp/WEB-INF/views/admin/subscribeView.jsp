<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="nowpage" value="1" />
<c:if test="${ !empty requestScope.currentPage }">
	<c:set var="nowpage" value="${ requestScope.currentPage }" />
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style type="text/css">

table {
	border-collapse: collapse;
	width: 1300px;
	margin: 1rem auto;
	background-color: white;
}

thead {
	box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.1);
}

/* 테이블 행 */
td {
	padding: 8px;
	text-align: left;
	border-bottom: 1px solid #ddd;
	text-align: center;
}

th {
	padding: 8px;
	text-align: left;
	text-align: center;
	border-top: 2px solid #000;
	border-bottom: 2px solid #000;
	color: #000;
}

/* 테이블 올렸을 때 */
tbody tr:not(#titlerow):hover {
	background-color: rgb(255, 221, 102);
	opacity: 0.9;
	cursor: pointer;
}

/* 테이블 비율 */
th:nth-child(1), td:nth-child(1) {
	width: 5%;
}

th:nth-child(2), td:nth-child(2) {
	width: 55%;
}

th:nth-child(3), td:nth-child(3) {
	width: 10%;
}

th, td {
	border-left: none;
	border-right: none;
}
/*목록*/
div.listdiv {
	height: 40px;
	width: 1300px;
	margin: 20px auto;
	display: flex;
	/* padding-left:400px; */
	justify-content: center;
	position: relative;
}

button.listbtn {
	position: absolute;
	right: 0;
}
/*검색창 CSS*/
input:-ms-input-placeholder {
	color: #a8a8a8;
}

input:-webkit-input-placeholder {
	color: #a8a8a8;
}

input:-moz-input-placeholder {
	color: #a8a8a8;
}

div.searchdiv {
	height: 80px;
	width: 1600px;
	margin: 20px auto;
	display: flex;
	/* padding-left:400px; */
	justify-content: center;
	position: relative;
}

input[type='date'] {
	height: 30px;
}

.searchdiv>button.writerB {
	position: absolute;
	right: 150px;
}

.searchdiv>form {
	width: 600px;
	height: 40px;
}

.searchdiv>input#searchtext {
	font-size: 16px;
	width: 325px;
	padding: 0px;
	border: 1px solid rgb(250, 180, 49);
	outline: none;
	float: left;
	height: 40px;
	margin-right: 2px;
}

.searchbtn {
	width: 100px;
	height: 40px;
	border: none;
	background: rgb(250, 180, 49);
	color: #ffffff;
	font-size: 16px;
}

button {
	width: 100px;
	height: 40px;
	border: none;
	background: rgb(250, 180, 49);
	color: #ffffff;
	font-size: 16px;
}
</style>
<script type="text/javascript" src="/ssm/resources/js/jquery-3.7.0.min.js" ></script>
</head>
<body>
	<%-- <%@ include file="../common/menubar.jsp" %> --%>
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<hr>
		<br> <br>
		<div class="listdiv">
			<button class="listbtn"
				onclick="javascript:location.href='${pageContext.servletContext.contextPath}/nlist.do?page=1';">목록</button>
		</div>
		<table>
			<tr id="titlerow">
				<th>상품번호</th>
				<th>상품이름</th>
				<th>가격</th>
				<th>등록날짜</th>
				<th></th>
			</tr>
			<c:forEach items="${ requestScope.list }" var="s">

				<tr onclick="deleteSelected(${s.});">
					<td>${n.noticeNo}</td>
					<td>${n.noticeTitle }</td>
					<td>${n.writer }</td>
					<td>${n.writeDate }</td>
					<td>${n.readCount }</td>
				</tr>
			</c:forEach>
		</table>
		<div class="searchdiv">
			<form action="nsearch.do" method="get">
				<select style="height: 35px; width: 80px;" name="action"
					id="searchselect">
					<option value="title">제목</option>
					<option value="writer">작성자</option>
					<option id="date" value="date">날짜</option>
				</select> <input type="date" name="begin"> <input type="date"
					name="end"> <input style="height: 30px; width: 325px;"
					type="text" id="searchtext" name="keyword" placeholder="검색어 입력">
				<input type="submit" class="searchbtn" value="검색"> <br>
			</form>
		<c:if test="${ !empty loginUser &&  loginUser.adminOk eq 'Y'}">
		<button class="writerB" onclick="showWriteForm();">글쓰기</button>
		</c:if>
		</div>
		<c:url var="nwf" value="nwform.do">
			<c:param name="page" value="${nowpage}" />
		</c:url>
		<script type="text/javascript">
			function showWriteForm() {
			//게시글 원글 쓰기 페이지로 이동 요청
			location.href = "${ pageContext.servletContext.contextPath}/${nwf}";
			}
			$(document).ready(function() {
				// 셀렉트 요소에서 옵션을 선택했을 때 이벤트 핸들러
				$("input[type='date']").hide();
				$('#searchselect').change(function() {
					// 선택된 옵션 값 확인
					var selectedValue = $(this).val();

					// 만약 선택된 값이 '날짜'일 경우 달력 표시
					if (selectedValue === 'date') {
						$("#searchtext").hide()
						$("input[type='date']").show(); // 달력 보이기
					} else {
						$("#searchtext").show()
						$("input[type='date']").hide(); // 다른 경우 달력 숨기기
					}
				});
			});
		</script>
		<br>


		<c:import url="/WEB-INF/views/common/pagingView.jsp" />
		<hr> 
		<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>




