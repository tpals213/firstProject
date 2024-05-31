<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>직원 급여 정보</title>
    <c:import url="/WEB-INF/views/common/header.jsp"/>
 <style type="text/css">
        /* Common styles */
        body {
            font-family: 'Arial', sans-serif;
       
            margin: 10px auto;
            padding: 20px;
            color: #333;
        }

        h2, h4 {
            color: #444;
        }

        form {
           
            padding: 20px;
            border-radius: 8px;         
            margin-top: 20px; /* Adjusted margin top */
        }

        label {
            display: block;
            margin-top: 20px;
            margin-bottom: 5px;
        }

        input[type="number"], input[type="text"], input[type="submit"], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #ddd;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #5cb85c;
            color: white;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #4cae4c;
        }

        /* Specific styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px; /* Adjusted margin top */
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
            margin-top: 0px;
        }

        th {
            background-color: #f2f2f2;
            margin-top: 0px;
        }

        /* Center align buttons and adjust margin */
        div.button-group {
            text-align: center;
            margin-top: 20px; /* Adjusted margin top */
        }

        div.button-group button {
            padding: 10px 20px;
           /*  background-color: #007bff; */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        div.button-group button:hover {
            background-color: #0056b3;
        }

        /* Container styles */
        .container {
            max-width: 800px;
            margin: 150px auto; /* Center align container */
            padding: 20px;
           /*  background-color: #fff; */
            border-radius: 8px;
            /* box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); */
        }

        /* Detail table */
        #loadSalaryInfoDetails {
            display: none;
        }
        header {
   		 position: fixed; /* 페이지 스크롤에 관계없이 고정 위치 */
    		top: 0; /* 화면 상단에 배치 */
    left: 0;
    width: 100%; /* 전체 너비를 차지하도록 설정 */
    z-index: 1000; /* 다른 요소 위에 표시되도록 설정 */
}
        
    </style>
</head>
<body>

<c:import url="/WEB-INF/views/common/sidebar.jsp"/>
<div class="container">
    <h2>직원 급여 정보</h2>
    <!-- 급여 정보 표시 -->
    <table id="salaryInfoTable">
        <thead>
        <tr>
            <th>선택</th>
            <th>직원번호</th>
            <th>받는 사람 이름</th>
            <th>은행 이름</th>
            <th>계좌 번호</th>
            <th>보험료</th>
            <th>세금</th>
            <th>월급</th>
            <th>삭제</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="salaryInfo" items="${requestScope.employees}">
            <tr>
                <td><button onclick="loadSalaryInfoDetails(${salaryInfo.empId})">상세보기</button></td>
                <td>${salaryInfo.empId}</td>
                <td>${salaryInfo.accountHolder}</td>
                <td>${salaryInfo.bankName}</td>
                <td>${salaryInfo.bankAccountNo}</td>
                <td>${salaryInfo.premium}</td>
                <td>${salaryInfo.tax}</td>
                <td id="monthlySalary_${salaryInfo.empId}">원급 계산하기</td>
                <td>
                    <form action="deleteSalary" method="post"
                          onsubmit="return confirm('정말 삭제하시겠습니까?');">
                        <input type="hidden" name="empId" value="${salaryInfo.empId}">
                        <input type="submit" value="삭제">
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <!-- 시급 입력 폼 -->
    <form id="calculateSalaryForm" action="calculateMonthlySalary" method="post">
        <h4 class="page-title">월급 계산</h4>
        <label for="hourlyWage">시급:</label>
        <input type="number" id="hourlyWage" name="hourlyWage" required>
        <button type="submit">월급 계산</button>
    </form>

    <!-- 선택된 직원의 상세 정보 -->
    <table id="loadSalaryInfoDetails">
        <tbody>
        <tr>
            <th>직원 번호</th>
            <td id="detailEmpId"></td>
        </tr>
        <tr>
            <th>받는 사람 이름</th>
            <td id="detailAccountHolder"></td>
        </tr>
        <tr>
            <th>은행 이름</th>
            <td id="detailBankName"></td>
        </tr>
        <tr>
            <th>계좌 번호</th>
            <td id="detailBankAccountNo"></td>
        </tr>
        <tr>
            <th>보험료</th>
            <td id="detailPremium"></td>
        </tr>
        <tr>
            <th>세금</th>
            <td id="detailTax"></td>
        </tr>
        <tr>
            <th>월급</th>
            <td id="detailMonthlySalary"></td>
        </tr>
        </tbody>
    </table>

    <!-- 월급 계산 결과 -->
    <p id="calculatedHourlyWage"></p>
    <p id="calculatedMonthlySalary"></p>
</div>
<script type="text/javascript">
function loadSalaryInfoDetails(empId) {
    var detailsTable = document.getElementById('loadSalaryInfoDetails');

    // 서버에 직원의 상세 정보 요청
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/selectSalary.do?empId=' + empId, true);
    xhr.onload = function () {
        if (xhr.status === 200) {
            var salaryDetails = JSON.parse(xhr.responseText);

            // 서버에서 받은 상세 정보를 표시
            document.getElementById('detailEmpId').innerText = salaryDetails.empId; // 변경된 부분
            document.getElementById('detailAccountHolder').innerText = salaryDetails.accountHolder;
            document.getElementById('detailBankName').innerText = salaryDetails.bankName;
            document.getElementById('detailBankAccountNo').innerText = salaryDetails.bankAccountNo;
            document.getElementById('detailPremium').innerText = salaryDetails.premium;
            document.getElementById('detailTax').innerText = salaryDetails.tax;
            document.getElementById('detailMonthlySalary').innerText = salaryDetails.monthlySalary;

            // 선택된 직원의 상세 정보를 표시하기 위해 테이블을 보이게 함
            detailsTable.style.display = 'table';
        } else {
            alert('상세 정보를 불러오는 동안 오류가 발생했습니다.');
        }
    };
    xhr.onerror = function () {
        alert('상세 정보를 불러오는 동안 네트워크 오류가 발생했습니다.');
    };
    xhr.send();
}

</script>
<script type="text/javascript">
//월급 계산 요청을 서버로 전송하는 함수
function calculateMonthlySalary(hourlyWage) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/calculateMonthlySalary', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function () {
        if (xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            var monthlySalary = response.monthlySalary;

            // 결과를 표시할 영역에 월급을 표시
            document.getElementById('calculatedHourlyWage').innerText = '입력된 시급: ' + hourlyWage + ' 원';
            document.getElementById('calculatedMonthlySalary').innerText = '계산된 월급: ' + monthlySalary + ' 원';
        } else {
            alert('오류가 발생했습니다.');
        }
    };
    xhr.onerror = function () {
        alert('네트워크 오류가 발생했습니다.');
    };
    xhr.send('hourlyWage=' + hourlyWage);
}
</script>
<c:import url="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
