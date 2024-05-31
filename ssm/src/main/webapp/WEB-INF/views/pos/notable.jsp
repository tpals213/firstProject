<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="nowpage" value="1" />
<c:if test="${ !empty requestScope.currentPage }">
	<c:set var="nowpage" value="${requestScope.currentPage }" />
</c:if>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/resources/css/common/reset.css" />
<link rel="stylesheet" href="resources/css/goods/specify.css" />	
<script>
function resetBasket() {
    // 결과를 표시할 테이블
    var basketTable = document.querySelector('.basket');

    // 테이블의 모든 행 삭제
    while (basketTable.rows.length > 1) {
        basketTable.deleteRow(1); // 테이블의 첫 번째 행을 제외한 나머지 행 삭제
    }
}
</script>
<script>
function updateGoods() {
	var jarr = new Array();
   
	var basketTable = document.querySelector('.basket');
    var rows = basketTable.getElementsByTagName('tr');
    
    // 두 번째 테이블의 각 행을 순회하며 상품 이름, 수량 및 오늘 날짜를 출력
    var today = new Date(); // 오늘 날짜
    var formattedDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2); // YYYY-MM 형식으로 변환

    for (var i = 1; i < rows.length; i++) {
        var cells = rows[i].cells;
        var productName = cells[0].textContent; // 상품 이름
        var inputQuantity = cells[1].querySelector('input').value; // 수량 input 태그
        var salePrice = cells[2].textContent;
        var id= $("#testid").val()
        console.log("판매가, " + salePrice + "상품 이름:" + productName + "수량:" + inputQuantity + "날짜:" + formattedDate);
    
        var productInfo = {
        		id: id,
                name: productName,
                quantity: inputQuantity,
                date: formattedDate,
                salePrice: salePrice
            };
        jarr.push(productInfo);   
    }
    console.log(JSON.stringify(jarr));
    
    
    $.ajax({
        type: "POST",
        url: "saleinsert.do",
        data: JSON.stringify(jarr),
        contentType: "application/json; charset=utf-8",
        success: function(result) {
        	alert("계산 성공")
            location.reload();  
        },
        error: function(request, status, errorData) {
            console.log("error code : " + request.status
                + "\nMessage : " + request.responseText
                + "\nError : " + errorData);
        } 
    });  
    
    
    $.ajax({
        type: "POST",
        url: "gupdatebyname.do",
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
function addBasket(rowIndex) {
    // 결과를 표시할 테이블
    var basketTable = document.querySelector('.basket');

    // 클릭된 행 가져오기
    var clickedRow = document.getElementById('row_' + rowIndex);

    // 클릭된 행의 데이터 가져오기
    var productName = clickedRow.cells[1].textContent; // 상품명
    var quantity = 1; // 초기 수량
    var price = clickedRow.cells[3].textContent; // 판매가격

    // 중복 상품 체크 및 수량 증가
    var existingRow = null;
    var rows = basketTable.querySelectorAll('tr');
    for (var i = 0; i < rows.length; i++) {
        var cells = rows[i].cells;
        if (cells[0].textContent === productName) { // 상품명으로 중복 체크
            existingRow = rows[i];
            break;
        }
    }

    // 중복된 상품이 없으면 새로운 행 생성
    if (!existingRow) {
        // 결과를 추가할 새로운 행 생성
        var newRow = document.createElement('tr');

        // 상품명 셀 생성 및 값 설정
        var productNameCell = document.createElement('td');
        productNameCell.textContent = productName;
        newRow.appendChild(productNameCell);

        // 수량 셀 생성 및 값 설정
        var quantityCell = document.createElement('td');

        // 수량 입력란 생성
        var quantityInput = document.createElement('input');
        quantityInput.type = 'number';
        quantityInput.style.width = '70px'; // 너비 설정
        quantityInput.style.marginRight = '0px';
        quantityInput.style.verticalAlign = 'middle';
        quantityInput.value = quantity;
        quantityInput.addEventListener('input', function() {
            // 수량이 변경될 때마다 가격 업데이트
            var inputPrice = parseInt(this.value) * parseInt(price);
            priceCell.textContent = inputPrice; // 소수점 처리 없음
        });

        // td 셀에 input 태그 추가
        quantityCell.appendChild(quantityInput);
        newRow.appendChild(quantityCell); // 수량 셀을 새로운 행에 추가

        // 판매가격 셀 생성 및 값 설정
        var priceCell = document.createElement('td');
        var inputPrice = parseInt(quantity) * parseInt(price);
        priceCell.textContent = inputPrice; // 소수점 처리 없음
        newRow.appendChild(priceCell);

        // 결과 테이블에 새로운 행 추가
        basketTable.appendChild(newRow);
    } else { // 중복된 상품이 있으면 수량 증가
        var inputElement = existingRow.querySelector('input');
        inputElement.value = parseInt(inputElement.value) + 1;
        inputElement.dispatchEvent(new Event('input')); // 수량이 변경되었음을 알림
    }
}
</script>
<style>
.wrap {
	width: 1000px;
	padding: 10px 600px 50px 600px;
}

.header {
	font-size: 30px;
	background-color: orange;
	width: 100%;
	height: 10vh;	
	text-align: center;
	display: flex;
	flex-wrap: nowrap;
	justify-content: center;
	align-items: center;
	font-weight: 700;
	position: relative;
}

.body, .footer {
	background-color: lightgray;
	width: 100%;
}

.body {
	height: 60vh;
	display: flex;
	position: relative;
}

table.goods {
	position: absolute;
	top: 0;
	left: 0;
}

table.bascket {
	position: absolute;
	top: 0;
	right: 0;
}

.body .tableView {
	width: 80%;
	height: 100%;
	padding: 30px;
	position: relative;
}

.buttonList{
	background-color: lightgray;
	text-align: right;
}


.title p {
	color: black;
	font-weight: bolder;
	padding-right: 20px; 
}
.header a{
	color:black;
	font-size: 15px;
	position: absolute;
	left: 10px;
	top: 50%;
	transform: translateY(-50%);
	cursor: pointer;
}

.button {
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 15px;
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 8px;
	font-weight: 800;
	height: 50px;
	weight: 80px;
}



/* 테이블 추가 버튼 */
.button.add {
	background-color: DodgerBlue;
}

/* 테이블 삭제 버튼 */
.button.delete {
	background-color: red;
}

</style>
<meta charset="UTF-8">
<script type="text/javascript"
	src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet"
	href="/ssm/resources/css/jquery-ui-1.13.2/jquery-ui.min.css" />
<script type="text/javascript"
	src="/ssm/resources/css/jquery-ui-1.13.2/jquery-ui.min.js"></script>
<script>



</script>
<title>SSM웹포스기 세팅화면</title>
<script type="text/javascript"
	src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
</head>
<body>
	<div class="wrap">
		<div class="header">
			<a href="${pageContext.servletContext.contextPath }/glist.do?page=1&id=${loginUser.id}">재고 페이지</a>	
			<p class="title">SSM 웹 포스기</p>					
		</div>
		 
		<div class="body">
			<div class="table1" style="margin-left: auto; margin-right: auto; width: 500px;">
				<input type="hidden" id="id" name="id" value="${ loginUser.id }">			
				<table class="goods" align="center" border="1" cellspacing="25"
					width="60%">
					<tr>
						<th style="text-align: center; white-space: nowrap;">번호</th>
						<th style="text-align: center; white-space: nowrap;">상품명</th>
						<th style="text-align: center; white-space: nowrap;">남은 수량</th>
						<th style="text-align: center; white-space: nowrap;">판매가격</th>
					</tr>					
					<c:forEach items="${requestScope.list}" var="goodsPrint"
						varStatus="loop">
						<tr id="row_${loop.index}">
							<td align="center" style="white-space: nowrap;"
								onclick="addBasket(${loop.index})">${goodsPrint.goodsNo}</td>
							<td align="center" style="white-space: nowrap;"
								onclick="addBasket(${loop.index})">${goodsPrint.goodsName}</td>
							<td align="center" style="white-space: nowrap;"
								onclick="addBasket(${loop.index})">${goodsPrint.pdQuantity}</td>
							<td align="center" style="white-space: nowrap;"
								onclick="addBasket(${loop.index})">${goodsPrint.salePrice}</td>
						</tr>					
					</c:forEach>
				</table>				
			</div>	<!-- div 표1 -->	
			<div class="table2" >			
				<table class="basket"  border="1" cellspacing="25"width="30%">
					<tr>
						<th style="text-align: center; white-space: nowrap;">상품명</th>
						<th style="text-align: center; white-space: nowrap;">수량</th>
						<th style="text-align: center; white-space: nowrap;">판매가격</th>
					</tr>
				</table>
			</div> <!-- div 표2 -->			
		</div> <!-- div class="body" -->
		<div class="buttonList">
			<button align="right" class="button add" onclick="updateGoods()">계산</button>
			<button align="right" class="button delete" onclick="resetBasket()">취소</button>
			<input type="hidden" id="userId" value="${loginUser.id }">
		</div>	
	</div> <!-- 전체 -->
	
	<input type="hidden" id ="testid" name="id" value="${ loginUser.id }">
</body>
</html>