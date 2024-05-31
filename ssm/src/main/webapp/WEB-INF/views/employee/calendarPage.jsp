<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 스케줄 조회 페이지</title>
<style type="text/css">
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

h1 {
	text-align: center;
	margin-top: 20px;
}

table {
	width: 80%;
	margin: 20px auto;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

th {
	background-color: #f2f2f2;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}

tr:hover {
	background-color: #ddd;
}

button {
	display: block;
	margin: 20px auto;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	background-color: #007bff;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s;
}

button:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
<form action="calendarPage.do">
	<c:import url="/WEB-INF/views/common/header.jsp" />
    <h1>직원 스케줄 조회</h1>
    <table border="1">
        <tr>
            <th>직원 ID</th>
            <th>직원 이름</th>
            <th>직급</th>
            <th>날짜</th>
            <th>내용</th>
        </tr>
        <c:forEach var="schedule" items="${schedules}">
            <tr>
                <td>${schedule.empId}</td>
                <td>${schedule.employee.empName}</td>
                <td>${schedule.employee.position}</td>
                <td>${schedule.date}</td>
                <td>${schedule.remarks}</td>
            </tr>
        </c:forEach>
    </table>
    <button type="button" onclick="location.href='selectemp.do?id=${loginUser.id}'">목록으로 돌아가기</button>
    </form>
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
