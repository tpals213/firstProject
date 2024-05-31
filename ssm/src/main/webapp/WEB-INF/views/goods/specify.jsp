<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="nowpage" value="1" />
<c:if test="${ !empty requestScope.currentPage }">
	<c:set var="nowpage" value="${requestScope.currentPage }" />
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="resources/css/goods/specify.css" />
<title>goodsListView</title>
<style>
.searchdiv {
	margin: 0 auto; /* 좌우 마진을 자동으로 설정하여 가운데 정렬 */
	width: fit-content; /* 내용에 맞게 자동으로 너비 설정 */
}

@media print {
   
	header, footer, sidebar, button {
		display: none !important;
	}
	
	.searchdiv {
		display: none !important;
	}
	table {
		margin: 0 auto; /* 좌우 마진을 자동으로 설정하여 가운데 정렬 */
		width: fit-content;
		page-break-inside: avoid;
	}
}
</style>
<style type="text/css">
	.buttons>button {
		width: 150px;
		height: 40px;
		border: none;
		background: rgb(250, 180, 49);
		color: #ffffff;
		font-size: 16px;
	}
	.searchbtn {
	width: 50px;
	height: 35px;
	border: none;
	background: rgb(250, 180, 49);
	color: #ffffff;
	font-size: 16px;
	}
</style>

<script type="text/javascript" src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">

</script>
<script>
    var pdName = '';
    var pdAddress = '';
    
    <c:forEach items="${list}" var="goodsPrint">
        pdName = '${goodsPrint.pdName}';
        pdAddress = '${goodsPrint.pdAddress}';
        // 필요한 경우 다른 속성도 동일한 방식으로 설정할 수 있습니다.
    </c:forEach>

    // 페이지 로드 시 실행되는 함수
    window.onload = function() {
        // 알림으로 성명과 주소 표시
        document.getElementById('pdNameSpan').innerText = pdName;
        document.getElementById('pdAddressSpan').innerText = pdAddress;
        
        var today = new Date();
        
        // 날짜 입력란에 오늘 날짜 설정
        document.getElementById("date").value = today.toISOString().substr(0, 10);

        // 오늘 날짜를 div 요소에도 설정
        var pdDateDiv = document.getElementById("pdDate");
        var dateString = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
        pdDateDiv.textContent = dateString;
    };
</script>

</head>
<body>
<c:import url="/WEB-INF/views/common/header.jsp" />
<div style="padding-top : 100px;">
<hr>

<c:import url="/WEB-INF/views/common/sidebar.jsp" />
<h1 style="text-align: center;">발주 명세서</h1>
<div style="align:center;text-align:center;">
<br>

</div>

<div class="searchdiv">
	<form method="get" id="searchForm">
		<input type="hidden" id = "id" name="id" value="${ loginUser.id }">
		<select style="height: 35px; width: 80px;" name="action"id="searchselect">
			<option value="goodsName">상품명</option>
			<option value="pdName">발주처</option>
		</select>  
		<input style="height: 30px; width: 325px;" type="text" id="searchtext" name="keyword" placeholder="검색어 입력">
        <input type="button" class="searchbtn" value="검색" onclick="search()">
	</form>
</div>

<script>
    function search() {
        var action = document.getElementById("searchselect").value;
        var keyword = document.getElementById("searchtext").value;
        var form = document.getElementById("searchForm");

        if (action === "goodsName") {
            form.action = "goodsNameSearch.do"; // 상품명 검색을 처리하는 URL로 변경
        } else if (action === "pdName") {
            form.action = "pdNameSearch.do"; // 발주처 검색을 처리하는 URL로 변경
        }
        
        form.submit();
    }
</script>



<div style="margin-left: auto; margin-right: auto; width: 1400px;">	
        <table id="specifysave" align="center" border="2" cellspacing="25" width="100%">
        	<tr>
                <th style="text-align: center; white-space: nowrap;">일자</th>
                <th style="text-align: center; white-space: nowrap;">
        			<input type="date" id="date" name="date" onchange="setSelectedDate()" required>
        		</th>
                <th style="text-align: center; white-space: nowrap;">성명</th>
                <th style="text-align: center; white-space: nowrap;">받는분</th>
                <th style="text-align: center; white-space: nowrap;">성명</th>
            </tr>
            <tr>             	
                <td style="text-align: center; white-space: nowrap;">상호명</td>
                <td style="text-align: center; white-space: nowrap;">
					${loginUser.businessStoreName}
				</td>
                <td style="text-align: center; white-space: nowrap;">
					<input type="text" id="username" name="username">
			    </td>         
                <td style="text-align: center; white-space: nowrap;">
					<span id="pdNameSpan"></span>
				</td>
                <td style="text-align: center; white-space: nowrap;">
					<input type="text" id="producer" name="producer">
				</td>           
            </tr>
            <tr>             	
                <td style="text-align: center; white-space: nowrap;">주소</td>
                <td colspan='2' style="text-align: center; white-space: nowrap;">
					<input type="text" id="address" name="address">
				</td>  
                <td colspan='2' style="text-align: center; white-space: nowrap;">
                	<span id="pdAddressSpan"></span>
                </td>
            </tr>
            <tr>             	
                <td style="text-align: center; white-space: nowrap;">상품명</td>
                <td style="text-align: center; white-space: nowrap;">단위</td>
                <td style="text-align: center; white-space: nowrap;">수량</td>
                <td style="text-align: center; white-space: nowrap;">단가</td>
                <td style="text-align: center; white-space: nowrap;">금액</td>
            </tr>
			<c:forEach items="${list}" var="goodsPrint" varStatus="loop">
            <tr>
             	<td align="center" style="white-space: nowrap;">${ goodsPrint.goodsName }</td>
                <td align="center" style="white-space: nowrap;">${ goodsPrint.goodsUnit }</td>
                <td align="center" style="white-space: nowrap;">
                	<input type="number" id="oq_${ loop.index }" name="oq">
                </td>
                <td id="goodsPriceCell_${loop.index}" align="center" style="white-space: nowrap;">${ goodsPrint.goodsPrice }</td>
                <td align="center" style="white-space: nowrap;">
                	<span id="goodstotalprice_${ loop.index }"></span>
                </td>
            </tr>
            </c:forEach>             
            <tr>
            	<td style="text-align: center; white-space: nowrap;">합계</td>
            	<td style="text-align: center; white-space: nowrap;"></td>
            	<td style="text-align: center; white-space: nowrap;"></td>
            	<td style="text-align: center; white-space: nowrap;"></td>
            	<td id="sum" style="text-align: center; white-space: nowrap;">
            		<div id="buttonDisplay">
            			<button class="sum" onclick="calcSum();">합계</button>
            		</div>
            	<form action="sinsert.do" method="post" id="sinsert">
            		<div id="sumDisplay" style="display:none;"></div>
            		<input type="hidden" id="idd" name="idd" value="${ loginUser.id }">   		
            		<div id="pdDate" style="display:none;"></div>
            	</form>
            	</td>
            </tr>
        </table>
        <div id="idDisplay" style="display:none;">${ loginUser.id }</div>
</div>
<div class="buttons" style="text-align: center;">
	<button onclick="exportToExcel()">엑셀로 저장</button>&nbsp;
	<button onclick="printTable()">인쇄 및 pdf로 저장</button>&nbsp;
	<button onclick="insertTable()">발주 금액 저장</button>&nbsp;
</div>
<script>
function setSelectedDate() {
    // input 요소에서 선택한 날짜 가져오기
    var selectedDate = document.getElementById("date").value;
    
    // 가져온 날짜를 div 요소에 설정
    document.getElementById("pdDate").innerText = selectedDate;
    // 또는 내부 HTML로 설정하려면 아래 코드를 사용합니다.
    // document.getElementById("selectDate").innerHTML = selectedDate;
}
</script>

<script>
function insertTable() {
	
    var jarr = new Array();
    var job = new Object();
    
    job.id = document.getElementById("idDisplay").textContent;
    job.pdPrice = document.getElementById("sumDisplay").textContent;
    job.pdDate  = document.getElementById("pdDate").textContent;
    
    jarr.push(job);

    var confirmMessage = "해당 금액을 월 발주 금액에 저장하시겠습니까?"
    	if (confirm(confirmMessage)) {
            $.ajax({
                type: "POST",
                url: "sinsert.do",
                data: JSON.stringify(jarr),
                contentType: "application/json; charset=utf-8",
                success: function(result) {
                	alert("저장 성공 : ");
                },
                error: function(request, status, errorData) {
                    console.log("error code : " + request.status
                        + "\nMessage : " + request.responseText
                        + "\nError : " + errorData);
                } 
            });      
        } else {
            alert.log("저장이 취소되었습니다.");
        }
    
}


</script>


<!-- 상품당 총 가격 덧셈 -->
<script>
<c:forEach items="${list}" var="goodsPrint" varStatus="loop">
	var quantityInput_${loop.index} = document.getElementById('oq_${loop.index}');
	var goodsPriceCell_${loop.index} = document.getElementById('goodsPriceCell_${loop.index}');
	var goodstotalprice_${loop.index} = document.getElementById('goodstotalprice_${loop.index}');
	
	quantityInput_${loop.index}.addEventListener('change', function() {
    // 사용자가 입력한 수량
    	var quantity = parseInt(this.value);
    // 상품 가격 가져오기
    	var goodsPrice = parseFloat(goodsPriceCell_${loop.index}.textContent); // 또는 innerText 사용 가능

    // 총 가격 계산
    	var totalPrice = quantity * goodsPrice;
    	
    // 결과를 화면에 출력
    	goodstotalprice_${loop.index}.textContent = totalPrice;  
    });
</c:forEach>
</script>

<script>
function calcSum() {
    // table element 찾기
    const table = document.getElementById('specifysave');
    
    // 합계 계산
    let sum = 0;
    for(let i = 4; i < table.rows.length-1; i++)  {
        sum += Number(table.rows[i].cells[4].textContent);
    }
    
    // 합계 출력
    document.getElementById('sumDisplay').textContent = sum;
    
    // 버튼 숨기기
    document.getElementById('buttonDisplay').style.display = 'none';
    // 합계 표시
    document.getElementById('sumDisplay').style.display = 'block';
}

// 합계를 클릭하면 버튼 다시 표시
document.getElementById('sumDisplay').addEventListener('click', function() {
    // 합계 숨기기
    document.getElementById('sumDisplay').style.display = 'none';
    // 버튼 표시
    document.getElementById('buttonDisplay').style.display = 'block';
});
</script>




<!-- 파일로 저장 -->
<script>
        function exportToExcel() {
            const table = document.getElementById('specifysave');
            const rows = table.getElementsByTagName('tr');
            const csvData = [];

            for (let i = 0; i < rows.length; i++) {
                const row = [], cols = rows[i].querySelectorAll('td, th');

                for (let j = 0; j < cols.length; j++) {
                    row.push(cols[j].innerText);
                }
                
                csvData.push(row.join(','));
            }

            const csvString = '\uFEFF' + csvData.join('\n'); // Add BOM character for UTF-8 encoding
            const a = document.createElement('a');
            const blob = new Blob([csvString], { type: 'text/csv;charset=utf-8;' });
            const url = URL.createObjectURL(blob);
            a.href = url;
            a.target = '_blank';
            a.download = 'table_data.csv';
            document.body.appendChild(a);
            a.click();
            setTimeout(() => {
                document.body.removeChild(a);
                window.URL.revokeObjectURL(url);
            }, 0);
        }
</script>

<!-- 출력 -->
<script>
    function printTable() {
        // 모든 input 요소의 현재 스타일 저장
        var inputs = document.querySelectorAll('input');
        
        // 인쇄 전에 테두리 없애기
        inputs.forEach(function(input) {
            input.style.outline = 'none';
            input.style.border = 'none';
        });

        // 테이블을 인쇄
        window.print();

        // 인쇄 후에 테두리 복원
        inputs.forEach(function(input) {
            input.style.outline = '';
            input.style.border = '';
        });
    }
</script>
<br>
<br>
<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>