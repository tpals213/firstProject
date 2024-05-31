<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구독상품페이지</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

.container {
	font-family: arial;
	font-size: 18px;
	padding: 20px;
	margin: 25px auto;
	width: 1200px;
	outline: dashed 1px black;
	text-align: center;
}

table {
	border-collapse: collapse;
	width: 900px;
	margin: 1rem auto;
	background-color: white;
}

thead {
	box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.1);
}

/* 테이블 행 */
td {
	padding: 8px;
	text-align: left;
	border-bottom: 1px solid #ddd;
	text-align: center;
}

th {
	padding: 8px;
	text-align: left;
	text-align: center;
	border-top: 2px solid #000;
	border-bottom: 2px solid #000;
	color: #000;
}

/* 테이블 올렸을 때 */
tbody tr:not(#titlerow):hover {
	background-color: rgb(255, 221, 102);
	opacity: 0.9;
	cursor: pointer;
}

/* 테이블 비율 */
th:nth-child(1) {
	width: 15%;
}

th:nth-child(2) {
	width: 30%;
}

th:nth-child(3) {
	width: 30%;
}

th:nth-child(4) {
	width: 15%;
}

th, td {
	border-left: none;
	border-right: none;
}

button#payment-button {
	width: 200px;
	height: 80px;
	border: orange;
	background: rgb(250, 180, 49);
	color: #ffffff;
	font-size: 25px;
	margin-top: 50px;
	margin-bottom: 50px;
}

p.title {
	margin: 0 0 70px;
	font-size: 24px;
	font-weight: 600;
	color: #4e5968;
}

.modal {
	display: none; /* 모달 기본으로 숨김 */
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4); /* 배경 어둡게 설정 */
}

.modal-content {
	background-color: #fefefe;
	margin: 10% auto;
	padding: 20px;
	border: 1px solid #888;
	max-width: 600px; /* 모달 최대 너비 설정 */
	width: 80%;
	border-radius: 10px; /* 모달 모서리 둥글게 설정 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.modal-title {
	text-align: center;
	font-size: 24px;
	margin-bottom: 20px;
	color: #333;
}

.modal-info {
	margin-bottom: 15px;
}

.modal-info span {
	font-weight: bold;
}

.modal-btns {
	text-align: center;
}

.modal-btns button {
	padding: 10px 20px;
	margin: 0 10px;
	border: none;
	border-radius: 5px;
	background-color: #4CAF50;
	color: white;
	cursor: pointer;
	transition: background-color 0.3s;
}

.modal-btns button:hover {
	background-color: #45a049;
}
.addSubscribe{
	width: 130px;
	height: 40px;
	border: none;
	background: rgb(250, 180, 49);
	color: #ffffff;
	font-size: 16px;
}
</style>
<script type="text/javascript"
	src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<div class="main-container" style="padding-top:100px;">
	<hr>
	<br>
	<br>
	<div class="container">
		<div class="subscribeList">
			<p class="title">구독 상품</p>
			<table>
				<tr id="titlerow">
					<th>상품번호</th>
					<th>상품이름</th>
					<th>가격</th>
					<th>서비스 개월</th>
				</tr>
				<c:forEach items="${ requestScope.list }" var="s">
					<tr class="subscribe-row" data-subscribeNo="${s.subscribeNo}"
						data-subscribeName="${s.subscribeName}" data-price="${s.price}"
						data-subscribeDate="${s.subscribeDate}">
						<td>${s.subscribeNo}</td>
						<td>${s.subscribeName }</td>
						<td>${s.price }</td>
						<td>${s.subscribeDate }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		 <button class="addSubscribe" onclick="$('#addSubscriptionModal').show();">구독상품 추가</button>
	</div>

	<!-- 모달 -->
	<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeMyModal();">&times;</span>
        <div class="modal-title">구독 상품 상세 정보</div>
        <div class="modal-info">
            <p><span>상품번호:</span> <span id="modal-subscribeNo"></span></p>
            <p><span>상품이름:</span> <span id="modal-subscribeName"></span><input type="text" id="input-subscribeName" style="display:none;"></p>
            <p><span>가격:</span> <span id="modal-price"></span> <input type="number" id="input-price" style="display:none;"></p>
            <p><span>서비스개월:</span> <span id="modal-subscribeDate"></span> <input type="number" id="input-subscribeDate" style="display:none;"></p>
        </div>
        <div class="modal-btns">
            <button id="editButton">수정</button>
            <button id="deleteButton">삭제</button>
            <button id="confirmEdit" style="display:none;">확인</button>
        </div>
    </div>
</div>
<!-- 상품추가 모달 -->
<div id="addSubscriptionModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeAddModal();">&times;</span>
        <div class="modal-title">구독 상품 추가</div>
        <div class="modal-info">
            <p><span>상품 이름:</span> <input type="text" id="addSubscribeName"></p>
            <p><span>가격:</span> <input type="number" id="addSubscribePrice"></p>
            <p><span>서비스 개월:</span> <input type="number" id="addSubscribeMonths"></p>
        </div>
        <div class="modal-btns">
            <button id="confirmAddSubscription">추가</button>
        </div>
    </div>
</div>
</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />

	<script>
	$(document).ready(function() {
        // 모달 표시 함수
        function showModal(subscribeNo, subscribeName, price, subscribeDate) {
            $("#modal-subscribeNo").text(subscribeNo);
            $("#modal-subscribeName").text(subscribeName);
            $("#input-subscribeName").val(subscribeName);
            $("#modal-price").text(price);
            $("#input-price").val(price);
            $("#modal-subscribeDate").text(subscribeDate);
            $("#input-subscribeDate").val(subscribeDate);
            $("#myModal").show();
        }

        // 수정 버튼 클릭 이벤트
        $("#editButton").click(function() {
        	$("#modal-subscribeName").hide();
        	$("#input-subscribeName").show();
            $("#modal-price").hide();
            $("#modal-subscribeDate").hide();
            $("#input-price").show();
            $("#input-subscribeDate").show();
            $("#editButton").hide();
            $("#deleteButton").hide();
            $("#confirmEdit").show();
        });

        // 확인 버튼 클릭 이벤트
        $("#confirmEdit").click(function() {
            var subscribeNo = $("#modal-subscribeNo").text();
            var subscribeName = $("#input-subscribeName").val();
            var price = $("#input-price").val();
            var subscribeDate = $("#input-subscribeDate").val();
			
            var url = "updatesub.do?";
            url += "subscribeNo=" + subscribeNo;
            url += "&subscribeName=" +encodeURIComponent(subscribeName);
            url += "&price=" + price;
            url += "&subscribeDate=" + subscribeDate;
            location.href = url;
        });
        
        // 구독 행 클릭 이벤트
        $(".subscribe-row").click(function() {
            var cells = $(this).find('td');
            var subscribeNo = $(cells[0]).text(); 
            var subscribeName = $(cells[1]).text(); 
            var price = $(cells[2]).text();
            var subscribeDate = $(cells[3]).text(); 

            showModal(subscribeNo, subscribeName, price, subscribeDate);
        });

        // 삭제 버튼 클릭 이벤트
        $("#deleteButton").click(function() {
        	var subscribeNo = $("#modal-subscribeNo").text();
        	var url = "deletesub.do?";
            url += "subscribeNo=" + subscribeNo;
            location.href = url;
        });
    });
	// 구독상품 추가이벤트
	$("#confirmAddSubscription").click(function() {
        var subscribeName = $("#addSubscribeName").val();
        var price = $("#addSubscribePrice").val();
        var subscribeDate = $("#addSubscribeMonths").val();
        var url = "insertsub.do?";
        url += "subscribeName=" +encodeURIComponent(subscribeName);
        url += "&price=" + price;
        url += "&subscribeDate=" + subscribeDate;
        location.href = url;
        // 모달 닫기
    });
	// 닫기 버튼을 눌렀을 때 모달 숨기기
    function closeMyModal() {
        $("#myModal").hide();
    };
    function closeAddModal(){
    	$("#addSubscriptionModal").hide();
    }
	</script>
</body>
</html>




