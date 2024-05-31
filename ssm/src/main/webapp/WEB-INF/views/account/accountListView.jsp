<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="monthlyPdSum" value="${requestScope.monthlyPdSum }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/goods/specify.css" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<title>goodsListView</title>

<script type="text/javascript" src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
</script>




<script>
function sum() {
    // table element 찾기
    const table = document.getElementById('myTable');

	// 2번 행의 값을 초기 값으로 설정
	let sum = Number(table.rows[2].cells[1].textContent); 

	// 3, 4행의 값을 빼기
	 for (let i = 3; i <= 3; i++) {
    	sum -= Number(table.rows[i].cells[1].textContent);
	}

	// 5행부터 마지막 이전 행까지의 input 요소의 값을 빼기
	for (let i = 4; i < table.rows.length - 1; i++) {
    	sum -= Number(table.rows[i].cells[1].querySelector('input').value);
	}
    
    // 합계 출력
    document.getElementById('sumDisplay').textContent = sum;
    
    // 버튼 숨기기
    document.getElementById('buttonDisplay').style.display = 'none';
    // 합계 표시
    document.getElementById('sumDisplay').style.display = 'block';
    
    var jarr = new Array();
    
    var selectElement = document.getElementById("monthSelect");
    var yearmonth = selectElement.value;
    var id = document.getElementById("idDisplay").textContent;
    
    var job1 = {};
    job1.yearmonth = yearmonth;    
    job1.id = id   
    job1.rent = document.getElementById("monthlyRent").value;   
    jarr.push(job1);
    
    var job2 = {};
    job2.yearmonth = yearmonth;    
    job2.id = id   
    job2.tax = document.getElementById("montlyTax").value;
    jarr.push(job2);
    
    var job3 = {};
    job3.yearmonth = yearmonth;    
    job3.id = id 
    job3.cost = document.getElementById("monthlyCost").value;
    jarr.push(job3);
    

    $.ajax({
        type: "POST",
        url: "insertAccount.do",
        data: JSON.stringify(jarr),
        contentType: "application/json; charset=utf-8",
        success: function(result) {
        	location.reload();
        },
        error: function(request, status, errorData) {
            console.log("error code : " + request.status
                + "\nMessage : " + request.responseText
                + "\nError : " + errorData);
        } 
    });    
    
}

</script>
<script>
function onChangeMonth() {  
    var jarr = new Array();
    var job = new Object();
    
    var selectElement = document.getElementById("monthSelect");
    var month = selectElement.value; 
    
    job.id = document.getElementById("idDisplay").textContent;
    job.month = month;
    
    jarr.push(job);
    
            $.ajax({
                type: "POST",
                url: "monthlyPdPrice.do",
                data: JSON.stringify(jarr),
                contentType: "application/json; charset=utf-8",
                success: function(result) {
                	var spanElement = document.getElementById("monthlyPdPrice");
                    spanElement.textContent = result;
                },
                error: function(request, status, errorData) {
                    console.log("error code : " + request.status
                        + "\nMessage : " + request.responseText
                        + "\nError : " + errorData);
                } 
            });   
            
            // input 값에 값 넣기
            $.ajax({
                type: "POST",
                url: "monthlyCost.do",
                data: JSON.stringify(jarr),
                contentType: "application/json; charset=utf-8",
                success: function(response) {
                	var dataArray = JSON.parse(response); // JSON 배열을 JavaScript 배열로 변환
                	for (var i = 0; i < dataArray.length; i++) {
                        var data = dataArray[i];
                        if (data.monthlycost !== undefined) {
                            document.getElementById("monthlyCost").value = data.monthlycost;
                        }
                        if (data.monthlytax !== undefined) {
                            document.getElementById("montlyTax").value = data.monthlytax;
                        }
                        if (data.monthlyrent !== undefined) {
                            document.getElementById("monthlyRent").value = data.monthlyrent;
                        }
                        if (data.monthlysale !== undefined) {
                            document.getElementById("monthlySales").textContent = data.monthlysale;
                        }
                    }
                	var sumDisplay = document.getElementById("sumDisplay");
                	sumDisplay.textContent = document.getElementById("monthlySales").textContent 
                			- document.getElementById("monthlyRent").value
                			- document.getElementById("montlyTax").value
                		    - document.getElementById("monthlyCost").value
                		    - document.getElementById("monthlyPdPrice").textContent;
                },
                error: function(request, status, errorData) {
                    console.log("error code : " + request.status
                        + "\nMessage : " + request.responseText
                        + "\nError : " + errorData);
                } 
            }); 
            
        
}
</script>

</head>
<body onload="onChangeMonth()">
<c:import url="/WEB-INF/views/common/header.jsp" />
<div style="padding-top : 100px;">

<br>
<c:import url="/WEB-INF/views/common/sidebar.jsp" />
<h1 style="text-align: center;">월 매출</h1>
<div style="align:center;text-align:center;">


<select style="height: 35px; width: 80px;" 
				id="monthSelect" onchange="onChangeMonth()">
	<option value="2024-01">2024-01</option>
    <option value="2024-02">2024-02</option>
    <option value="2024-03">2024-03</option>
    <option value="2024-04">2024-04</option>
    <option value="2024-05">2024-05</option>
    <option value="2024-06">2024-06</option>
    <option value="2024-07">2024-07</option>
    <option value="2024-08">2024-08</option>
    <option value="2024-09">2024-09</option>
    <option value="2024-10">2024-10</option>
    <option value="2024-11">2024-11</option>
    <option value="2024-12">2024-12</option>
</select> 

<br>
<br>
</div>
<style>
	 .searchdiv {
        margin: 0 auto; /* 좌우 마진을 자동으로 설정하여 가운데 정렬 */
        width: fit-content; /* 내용에 맞게 자동으로 너비 설정 */
    }
    
	table {
		margin: 0 auto; /* 좌우 마진을 자동으로 설정하여 가운데 정렬 */
		width: fit-content;
		page-break-inside: avoid;
	}   
</style>


<div>
	<div class="left-div" style="margin-left: auto; margin-right: auto; width: 700px;">
			<table id="myTable" border="1" cellspacing="25" width="100%">
				<tr>
					<th style="text-align: center; white-space: nowrap;">항목</th>
					<th style="text-align: center; white-space: nowrap;">금액</th>
				</tr>
				<tr>
					<td align="center" style="white-space: nowrap;">월 매출</td>
					<td align="center" style="white-space: nowrap;">
						<span id="monthlySales"></span>
					</td>
				</tr>	
				<tr>
					<td align="center" style="white-space: nowrap;">월 발주 금액</td>
    				<td align="center" style="white-space: nowrap;">						
						<span id="monthlyPdPrice" ></span>						
					</td>
				</tr>		
				<tr>
					<td align="center" style="white-space: nowrap;">월세</td>
					<td align="center" style="white-space: nowrap;">
						<input id="monthlyRent" type="number" placeholder="월세 입력 단위 원">
					</td>
				</tr>	
				<tr>
					<td align="center" style="white-space: nowrap;">세금</td>
					<td align="center" style="white-space: nowrap;">
						<input id="montlyTax" type="number" placeholder="세금 입력 단위 원">
					</td>
				</tr>		
				<tr>
					<td align="center" style="white-space: nowrap;">기타비용</td>
					<td align="center" style="white-space: nowrap;">
						<input id="monthlyCost" type="number" placeholder="기타비용 입력 단위 원">
					</td>
				</tr>				
				
				<tr>
					<td align="center" style="white-space: nowrap;">월 수익</td>
					<td align="center" style="white-space: nowrap;">				
            			<div id="sumDisplay"></div> 		
					</td>
				</tr>	
			</table>
	</div>
</div>

<br>
<br>
<div id="idDisplay" style="display:none;">${ loginUser.id }</div>

<div id="buttonDisplay" style="text-align: center;">
    <button onclick="sum();">변경 사항 저장</button>
</div>
<br>
<br>

<c:import url="/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>