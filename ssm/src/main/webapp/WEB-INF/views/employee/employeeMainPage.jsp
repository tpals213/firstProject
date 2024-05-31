<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>employee main page</title>
<link rel="stylesheet" type="text/css" href="style.css">
<style type="text/css">
/* 버튼 스타일 */
button {
    background-color: #007bff; /* 배경색 */
    color: white; /* 텍스트색 */
    border: none; /* 테두리 없음 */
    padding: 10px 20px; /* 내부 여백 */
    margin: 5px; /* 외부 여백 */
    cursor: pointer; /* 커서 모양 */
    font-size: 16px; /* 폰트 크기 */
    border-radius: 5px; /* 모서리를 둥글게 */
}

button:hover {
    background-color: #0056b3; /* 호버시 배경색 */
}

/* 테이블 스타일 */
table {
    width: 100%; /* 전체 너비 사용 */
    border-collapse: collapse; /* 테두리 겹침 */
    margin-top: 20px; /* 위 여백 */
}

th, td {
    border: 1px solid #ddd; /* 테두리 스타일 */
    padding: 8px; /* 셀 내부 여백 */
    text-align: left; /* 텍스트 정렬 */
}

th {
    background-color: #007bff; /* 머릿글 배경색 */
    color: white; /* 머릿글 텍스트색 */
}

/* 페이지네이션 스타일 */
.pagination {
    margin-top: 20px; /* 위 여백 */
}

.pagination span {
    display: inline-block; /* 인라인 요소로 표시 */
    padding: 8px 16px; /* 내부 여백 */
    background-color: #007bff; /* 배경색 */
    color: white; /* 텍스트색 */
    cursor: pointer; /* 커서 모양 */
    border-radius: 5px; /* 모서리를 둥글게 */
    margin-right: 5px; /* 오른쪽 여백 */
}

.pagination span:hover {
    background-color: #0056b3; /* 호버시 배경색 */
}

.pagination .active {
    background-color: #0056b3; /* 활성 페이지 배경색 */
}

</style>
</head>

<body>
<c:import url="/WEB-INF/views/common/header.jsp" />
 <c:import url="/WEB-INF/views/common/sidebar.jsp" />
<button onclick="location.href='recordTimePage.do'">출퇴근버튼</button>
<button onclick="location.href='calenderPage.do'">캘린더</button>
<div id="ebady">
<table id="info" border="1" cellspacing="0" cellpadding="3">
    <tr>
        <th>직원번호</th>
        <th>이름</th>
        <th>직급</th>        
        <th>전화번호</th>
        <th>이메일</th>             
        <th>성별</th>
    </tr>
    <c:forEach items="${sessionScope.employeeList}" var="employee">
        <tr id="selectAllEmployees">
            <td><c:out value="${employee.id}"/></td>
            <td><c:out value="${employee.name}"/></td>
            <td><c:out value="${employee.position}"/></td>
            <td><c:out value="${employee.phone}"/></td>
            <td><c:out value="${employee.email}"/></td>
            <td><c:out value="${employee.gender}"/></td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">
    <c:if test="${sessionScope.paging.startPage > 1}">
        <li onclick="location.href='${sessionScope.paging.urlMapping}&page=1'">처음</li>
        <li onclick="location.href='${sessionScope.paging.urlMapping}&page=${sessionScope.paging.startPage - 1}'">이전</li>
    </c:if>
    <c:forEach begin="${sessionScope.paging.startPage}" end="${sessionScope.paging.endPage}" var="pageNum">
        <li class="${pageNum == sessionScope.paging.currentPage ? 'active' : ''}" 
            onclick="location.href='${sessionScope.paging.urlMapping}&page=${pageNum}'">${pageNum}</li>
    </c:forEach>
    <c:if test="${sessionScope.paging.endPage < sessionScope.paging.maxPage}">
        <li onclick="location.href='${sessionScope.paging.urlMapping}&page=${sessionScope.paging.endPage + 1}'">다음</li>
        <li onclick="location.href='${sessionScope.paging.urlMapping}&page=${sessionScope.paging.maxPage}'">마지막</li>
    </c:if>
</div>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>
