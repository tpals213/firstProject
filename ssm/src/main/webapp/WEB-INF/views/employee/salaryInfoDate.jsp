<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 급여 정보 등록, 수정 및 삭제</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
        color: #333;
    }
    h2, h4 {
        color: #444;
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
    }
    input[type="number"], input[type="text"], input[type="submit"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border-radius: 5px;
        border: 1px solid #ddd;
        box-sizing: border-box; /* Makes sure padding does not affect total width */
    }
    input[type="submit"] {
        background-color: #5cb85c;
        color: white;
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #4cae4c;
    }
    .accordionMenu div {
		font-size:15px;
		display:block;
		font-weight:normal;
		color:#424242;
		text-shadow:2px 2px 2px #aeaeae;
		text-decoration:none;
		margin:0;
		padding:10px;
		background:#8f8f8f;
	}
	.accordionMenu form {
		padding:0 10px;
		margin:0;
		height:0;
		overflow:hidden;
		-moz-transition:height 0.5s ease-in;
		-webkit-transition:height 0.5s ease-in;
		-o-transition:height 0.5s ease-in;
		transition:height 0.5s ease-in;
	}
</style>
</head>
<body>

<div id="insertSalaryForm">
    <h2>직원 금융 정보 등록</h2>
    <!-- 등록 폼 -->
<form id="insertSalary" action="insertSalary.do" method="post">
    <!-- 입력 필드들 -->
    <label for="empId">직원 번호:</label> 
    <input type="number" id="empId" name="empId" min="1" required><br>
     
    <label for="bankName">은행 이름:</label> 
    <input type="text" id="bankName" name="bankName" required><br>
    
    <label for="bankAccountNo">계좌 번호:</label> 
    <input type="text" id="bankAccountNo" name="bankAccountNo" required><br>
     
    <label for="accountHolder">계좌 소유자 이름:</label>
    <input type="text" id="accountHolder" name="accountHolder" required><br>
     
    <label for="premium">보험료:</label>
    <input type="text" id="premium" name="premium" required><br> 
     
    <label for="tax">세금:</label>            
    <input type="text" id="tax" name="tax" required><br> 
    
    <input type="submit" value="등록"> <br> 
</form>

</div>  
<div id="updateSalaryForm">
    <!-- 직원 급여정보 수정 -->
    <h2>직원 급여 정보 수정</h2>
      <form action="updateSalary.do" method="post">
        <label for="empId">직원 번호:</label>
        <input type="number" id="empId" name="empId" min="1" required><br>
        
        <label for="bankName">은행 이름:</label> 
        <input type="text" id="bankName" name="bankName" required><br>
    
        <label for="bankAccountNo">계좌 번호:</label>
        <input type="text" id="bankAccountNo" name="bankAccountNo" required><br>
    
        <label for="accountHolder">계좌 소유자 이름:</label>
        <input type="text" id="accountHolder" name="accountHolder" required><br>
    
        <label for="premium">보험료:</label>
        <input type="number" id="premium" name="premium" required><br>
    
        <label for="tax">세금:</label>
        <input type="number" id="tax" name="tax" required><br>
    
        <input type="submit" value="수정">
    </form>
</div>
<br>
<div id="deleteSalaryForm">
    <!-- 직원 급여정보 삭제 -->
    <h4>직원 급여 정보 삭제</h4>
    <form action="deleteSalary.do" method="post">
         직원 번호: <input type="text" name="empId" required><br>
        직원 이름: <input type="text" name="empName" required><br>
        <input type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');">
    </form>
</div>  
<!-- 목록으로 돌아가기 버튼 -->
<button onclick="location.href='selectemp.do?id=${loginUser.id}'">목록으로 돌아가기</button>

</body>
</html>
