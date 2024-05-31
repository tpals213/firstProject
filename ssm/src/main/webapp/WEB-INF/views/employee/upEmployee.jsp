<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 정보 수정</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
        color: #333;
    }
    .container {
        max-width: 600px;
        margin: 0 auto;
    }
    h2 {
        color: #444;
        margin-bottom: 20px;
    }
    form {
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    label {
        display: block;
        margin-top: 20px;
        margin-bottom: 5px;
        font-weight: bold;
    }
    input[type="text"],
    input[type="email"],
    select {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border-radius: 5px;
        border: 1px solid #ddd;
        box-sizing: border-box; 
    }
    input[type="submit"],
    button {
        width: 100%;
        padding: 10px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
        text-transform: uppercase;
    }
    input[type="submit"] {
        background-color: #FFDD66;
        color: white;
    }
    input[type="submit"]:hover {
        background-color: #4cae4c;
    }
    button {
        background-color: #4cae4c;
        color: white;
    }
    button:hover {
        background-color: #45a049;
    }
</style>
<script type="text/javascript" src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
</head>
<body>
<div class="container" id="moveUpdateEmployee.do">
    <h2>직원 정보 수정</h2>

    <form id="updateForm" action="updateEmployee.do?id=${loginUser.id}" method="post"> 
    <input type="hidden" name="empId" value="${employee.empId}">
    
    <label for="empName">이름:</label>
    <input type="text" id="empName" name="empName" value="${employee.empName}" disabled required><br><br>
 
    <input type="hidden" name="empName" value="${employee.empName}">
    
    <label for="position">직급:</label>
    <input type="text" id="position" name="position" value="${employee.position}" required><br><br>
    
    <label for="empPhone">전화번호:</label>
    <input type="text" id="empPhone" name="empPhone" value="${employee.empPhone}" required><br><br>
    
    <label for="empEmail">이메일:</label>
    <input type="email" id="empEmail" name="empEmail" value="${employee.empEmail}" required><br><br>
    
    <label for="empAddress">주소:</label>
    <input type="text" id="empAddress" name="empAddress" value="${employee.empAddress}" required><br><br>
    
    <label for="empGender">성별:</label>
    <select id="empGender" name="empGender" required>
        <option value="M" ${employee.empGender == 'M' ? 'selected' : ''}>남자</option>
        <option value="F" ${employee.empGender == 'F' ? 'selected' : ''}>여자</option>
    </select><br><br>

    <input type="submit" value="수정">
   <button type="button" onclick="location.href='selectemp.do?id=${loginUser.id}'">목록</button>
</form>
</div>


	<script type="text/javascript">
	var userId = $('#userId').val(); 
   location.href="employeeDetails.do?id="+userId+"&empId=" + empId;
   </script>
</body>
</html>
