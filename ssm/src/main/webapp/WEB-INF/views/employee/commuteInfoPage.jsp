<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근태 정보 페이지</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style type="text/css">
/* 공통 스타일 */
body {
    font-family: Arial, sans-serif;
  /*   background-color: #f4f4f4; */
    margin: 0;
    padding: 0;
}

.container {
    max-width: 800px;
    padding: 200px;
   /*  background-color: #fff; */
    border-radius: 5px;
  /*   box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); */
    margin: 20px auto;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

th, td {
    padding: 10px;
    text-align: center;
}

th {
    background-color: #f2f2f2;
    font-weight: bold;
}

input[type="submit"], button {
    padding: 8px 16px;
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
}

input[type="submit"]:hover, button:hover {
    background-color: #0056b3;
}

/* 수정된 스타일 */
.page-title {
    font-size: 24px;
    font-weight: bold;
    color: #333;
}

.detail-info-container {
    margin-top: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
}

.detail-info-container h4 {
    margin-top: 0;
    margin-bottom: 10px;
}

.detail-info-table {
    width: 100%;
    border-collapse: collapse;
}

.detail-info-table th, .detail-info-table td {
    padding: 8px;
    border-bottom: 1px solid #ddd;
}

.detail-info-table th {
    background-color: #007bff;
    color: #fff;
}

.button-container {
    text-align: center;
    margin-top: 20px;
}

.return-button {
    background-color: #333;
}

.return-button:hover {
    background-color: #555;
}
</style>
</head>
<<body>
    <c:import url="/WEB-INF/views/common/header.jsp" />
    <c:import url="/WEB-INF/views/common/sidebar.jsp" />
    <div class="container">
        <form action="selectcommutePage.do" method="post">
            <fieldset id="employee">
                <legend>직원 검색</legend>
                <input type="search" name="keyword"> &nbsp; <input
                    type="submit" value="검색">
            </fieldset>
        </form>
        </form>
        <div>
            <table id="commutelninfo" border="1" cellspacing="0" cellpadding="3">
                <tr>
                    <th>직원 이름</th>
                    <th>직원 번호</th>
                    <th>출근 시간</th>
                    <th>근무 일</th>
                    <th>퇴근 시간</th>
                    <th>근무 시간</th>
                    <th>지각 여부</th>
                    <th>조퇴 여부</th>
                    <th>결근 여부</th>
                    <th>상세 조회</th>
                </tr>
                <c:forEach items="${sessionScope.selectcommute}" var="cinfo">
                    <tr>
                        <td><c:out value="${cinfo.employee.name}" /></td>
                        <td><c:out value="${cinfo.empId}" /></td>
                        <td><c:out value="${cinfo.startTime}" /></td>
                        <td><c:out value="${cinfo.workDay}" /></td>
                        <td><c:out value="${cinfo.endTime}" /></td>
                        <td><c:out value="${cinfo.workingHours}" /></td>
                        <td><c:out value="${cinfo.lateFlag}" /></td>
                        <td><c:out value="${cinfo.leaveEarly}" /></td>
                        <td><c:out value="${cinfo.absenteeism}" /></td>
                        <td>
                            <button
                                onclick="selectcommute('${cinfo.employee.name}', '${cinfo.empId}', '${cinfo.startTime}', '${cinfo.workDay}', '${cinfo.endTime}', '${cinfo.workingHours}', '${cinfo.lateFlag}', '${cinfo.leaveEarly}', '${cinfo.absenteeism}')">상세
                                조회</button>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <div id="detailInfo" style="display: none;">
                <h4>상세 조회</h4>
                <table id="detailTable" border="1" cellspacing="0" cellpadding="3">
                    <tr>
                        <th>직원 이름</th>
                        <th>직원 번호</th>
                        <th>출근 시간</th>
                        <th>근무 일</th>
                        <th>퇴근 시간</th>
                        <th>근무 시간</th>
                        <th>지각 여부</th>
                        <th>조퇴 여부</th>
                        <th>결근 여부</th>
                    </tr>
                </table>
            </div>
        </div>
         <button type="button" onclick="location.href='selectemp.do?id=${loginUser.id}'">목록으로 돌아가기</button>
    </div>
    <script type="text/javascript">
        // 상세 조회 버튼을 클릭했을 때 상세 정보를 표시하는 함수
        function selectcommute(name, empId, startTime, workDay, endTime, workingHours, lateFlag, leaveEarly, absenteeism) {
            var detailTable = document.getElementById("detailTable");
            detailTable.innerHTML = "";
            var newRow = detailTable.insertRow();

            // 상세 조회 정보를 채웁니다.
            var nameCell = newRow.insertCell(0);
            var empIdCell = newRow.insertCell(1);
            var startTimeCell = newRow.insertCell(2);
            var workDayCell = newRow.insertCell(3);
            var endTimeCell = newRow.insertCell(4);
            var workingHoursCell = newRow.insertCell(5);
            var lateFlagCell = newRow.insertCell(6);
            var leaveEarlyCell = newRow.insertCell(7);
            var absenteeismCell = newRow.insertCell(8);

            nameCell.innerHTML = name;
            empIdCell.innerHTML = empId;
            startTimeCell.innerHTML = startTime;
            workDayCell.innerHTML = workDay;
            endTimeCell.innerHTML = endTime;
            workingHoursCell.innerHTML = workingHours;
            lateFlagCell.innerHTML = lateFlag;
            leaveEarlyCell.innerHTML = leaveEarly;
            absenteeismCell.innerHTML = absenteeism;

            document.getElementById("detailInfo").style.display = "block";
        }
    </script>
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
