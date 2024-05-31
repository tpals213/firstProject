<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 정보 조회</title>
<style type="text/css">
body {
    font-family: Arial, sans-serif;
    margin-top : 20% auto;
    padding: 50px;
   /*  background-color: #f9f9f9; */ /* 배경색 변경 */
    font-size: 16px;
    color: #333;
    max-width: 800px auto;
}

.container {
    max-width: 1050px;
    margin: 0px auto;
    padding-top: 200px;
  /*   background-color: #fff; */
    border-radius: 8px;
  /*   box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); */
}

h2 {
    text-align: center;
    margin-bottom: 20px;
    color: #007bff; /* 제목 색상 변경 */
}

table {
    margin-top: 20px;
   /*  border-collapse: collapse; */
    width: 100%;
}

th, td {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 10px;
}

th {
    background-color: #f2f2f2;
}

form {
    background: #f2f2f2; /* 검색 폼 배경색 변경 */
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
}

input[type="search"] {
    width: 70%;
    padding: 10px;
    border-radius: 5px;
    border: 1px solid #ddd;
    box-sizing: border-box;
}

input[type="submit"] {
    width: 25%;
    padding: 10px;
    border-radius: 5px;
    border: none;
    background-color: #007bff;
    color: white;
    cursor: pointer;
}

input[type="submit"]:hover {
    background-color: #0056b3;
}

#employeeDetails {
    margin-top: 20px;
}

.button-group {
    text-align: center;
    margin-top: 20px;
}

.button-group button {
    margin: 5px;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    background-color: #007bff;
    color: white;
}

.button-group button:hover {
    background-color: #0056b3;
}
</style>
<c:import url="/WEB-INF/views/common/header.jsp" />
<c:import url="/WEB-INF/views/common/sidebar.jsp" />
<script type="text/javascript" src="/ssm/resources/js/jquery-3.7.0.min.js"></script>	
</head>
<body>
	<div class="container">
		<!-- 검색 폼 -->
	<!-- 	<form id="searchForm"> -->
       <!--  <fieldset id="es">
            <legend>직원 검색</legend>
            <input type="search" id="keyword" placeholder="직원 이름을 입력하세요">
            검색 버튼 클릭 시 search 함수 호출
            <input type="button" value="검색" onclick="search()">
        </fieldset> -->
    <!-- </form> -->
    

		<!-- 직원 정보 표시 -->
		 <h2>직원 정보</h2>
<!--     <h4 align="center">직원 수 : <span id="employeeCount">0</span> 명</h4> -->
    <!-- 검색 결과가 비어있는지 확인하고, 비어 있다면 알림을 표시하는 영역 -->
    <div id="emptyMessage" style="text-align: center; color: #ff0000; font-size: 18px; display: none;"></div>

    <!-- 선택 상자 -->
    <select id="employeeSelect" onchange="loadEmployeeDetails(this.value);">
    <option value="">직원 선택</option>
    <c:forEach items="${employeeList}" var="employee">
    <option value="${employee.empId}">${employee.empName}</option>
    </c:forEach>
</select>
    
    <!-- 검색 결과를 표시할 테이블 -->
    <table id="employeeTable">
			<thead>
				<tr>
					<th>직원번호</th>
					<th>이름</th>
					<th>직급</th>
					<th>입사날짜</th>
					<th>전화번호</th>
					<th>이메일</th>
					<th>주소</th>
					<th>생년월일</th>
					<th>성별</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${requestScope.employeeList}" var="employee">
					<tr onclick="loadEmployeeDetails(${employee.empId})">
						<td>${employee.empId}</td>
						<td>${employee.empName}</td>
						<td>${employee.position}</td>
						<td>${employee.empHireDate}</td>
						<td>${employee.empPhone}</td>
						<td>${employee.empEmail}</td>
						<td>${employee.empAddress}</td>
						<td>${employee.empBirthDate}</td>
						<td>${employee.empGender == 'M' ? '남자' : '여자'}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- 선택된 직원의 상세 정보 -->
		<table id="employeeDetails">
			<tbody>
				<tr>
					<th>직원 번호</th>
					<td id="detailEmpId">${empDetail.empId}</td>
				</tr>
				<tr>
					<th>이름</th>
					<td id="detailEmpName">${empDetail.empName}</td>
				</tr>
				<tr>
					<th>직급</th>
					<td id="detailPosition">${empDetail.position }</td>
				</tr>
				<tr>
					<th>입사날짜</th>
					<td id="detailEmpHireDate">${empDetail.empHireDate }</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td id="detailEmpPhone">${empDetail.empPhone }</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td id="detailEmpEmail">${empDetail.empEmail }</td>
				</tr>
				<tr>
					<th>주소</th>
					<td id="detailEmpAddress">${empDetail.empAddress }</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td id="detailEmpBirthDate">${empDetail.empBirthDate }</td>
				</tr>
				<tr>
					<th>성별</th>
					<td id="detailEmpGender">${empDetail.empGender }</td>
				</tr>
			</tbody>
		</table>
		<!-- 선택된 직원의 상세 정보 아래에 버튼 추가 -->
		<div class="button-group">
			<!-- 등록 페이지 이동 버튼 -->
			<button onclick="location.href='insertemp.do?id=${loginUser.id}'">직원 등록</button>
			<!-- 수정 페이지로 이동 버튼 -->
			<script type="text/javascript">			
			function moveUpEmp(empName){
			location.href = 'moveUpdateEmployee.do?id=${ loginUser.id }&empName=' + empName; }
			</script>
			  <button onclick="moveUpEmp('${empDetail.empName}')">수정하기</button> 
			<!-- 직원 삭제 버튼 -->
			<button onclick="deleteEmployee('${empDetail.empId}')">삭제하기</button>			
			<!-- 목록으로 돌아가기 버튼 -->
			<!-- <button onclick="location.href='mvwelcom.do?'">목록으로 돌아가기</button> -->
		</div>
		<input type="hidden" id="userId"value="${loginUser.id }">
	</div>

 <script type="text/javascript">
// 선택된 직원 정보를 저장하는 변수
var selectedEmployee;
//직원 정보를 조회하는 함수
function loadEmployeeDetails(empId) {
	 // 선택된 직원의 option 엘리먼트를 가져옴
	//var selectedOption = document.getElementById("employeeSelect").options[document.getElementById("employeeSelect").selectedIndex];
    var userId = $('#userId').val(); 
   location.href="employeeDetails.do?id="+userId+"&empId=" + empId;
	 // 선택된 직원 정보를 저장
    /* selectedEmployee = {
        empId: selectedOption.value,
        empName: selectedOption.text,
        position: selectedOption.getAttribute("data-position"),
        empHireDate: selectedOption.getAttribute("data-hire-date"),
        empPhone: selectedOption.getAttribute("data-phone"),
        empEmail: selectedOption.getAttribute("data-email"),
        empAddress: selectedOption.getAttribute("data-address"),
        empBirthDate: selectedOption.getAttribute("data-birth-date"),
        empGender: selectedOption.getAttribute("data-gender")
    };

    // 상세 정보 표시
   document.getElementById("detailEmpId").innerHTML = selectedEmployee.empId;
    document.getElementById("detailEmpName").innerHTML = selectedEmployee.empName;
    document.getElementById("detailPosition").innerHTML = selectedEmployee.position;
    document.getElementById("detailEmpHireDate").innerHTML = selectedEmployee.empHireDate;
    document.getElementById("detailEmpPhone").innerHTML = selectedEmployee.empPhone;
    document.getElementById("detailEmpEmail").innerHTML = selectedEmployee.empEmail;
    document.getElementById("detailEmpAddress").innerHTML = selectedEmployee.empAddress;
    document.getElementById("detailEmpBirthDate").innerHTML = selectedEmployee.empBirthDate;
    document.getElementById("detailEmpGender").innerHTML = selectedEmployee.empGender == 'M' ? '남자' : '여자';

    // 상세 정보를 보여줌
    document.getElementById("employeeSelect").style.display = "table"; */
}
</script>
<script type="text/javascript">
// 직원을 삭제하는 함수
function deleteEmployee(empId) {
    if(confirm('정말로 삭제하시겠습니까?')) {
    	var userId = $('#userId').val(); 
    	location.href="deleteEmployee.do?id="+userId+"&empId=" + empId;
    }
}
</script>
<script type="text/javascript">
function updateEmployee(empId) {
    location.href = 'updateEmployee.do?empId=' + empId;
}
</script>
</body>
</html>
