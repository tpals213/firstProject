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
	width: 10%;
}

th:nth-child(2) {
	width: 10%;
}

th:nth-child(3) {
	width: 30%;
}

th:nth-child(4) {
	width: 30%;
}

th:nth-child(5) {
	width: 20%;
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
/*결제 로고*/
#payment-method img {
	width: 100px;
	height: 40px;
}
/* 이미지에 마우스를 올렸을 때 */
#payment-method img:hover {
	transform: scale(1.05); /* 이미지 크기를 약간 키움 */
	transition: transform 0.3s ease; /* 부드럽게 변화되도록 애니메이션 적용 */
	cursor: pointer; /* 커서 모양을 손가락으로 변경 */
}

/* 이미지를 선택했을 때 */
img.selected {
	border: 2px solid blue; /* 이미지 주변에 파란색 테두리 추가 */
}
/*결제 div*/
#payment-method {
	display: flex;
	justify-content: space-around; /* 가로로 배치하고 가운데 정렬 */
}

.payment-section {
	width: 30%; /* 각 구역의 너비 */
	padding: 10px;
	border: 1px solid #ccc; /* 테두리 설정 */
	background-color: #f9f9f9; /* 배경색 설정 */
	text-align: center; /* 텍스트 가운데 정렬 */
}

.payment-section p {
	font-size: 16px;
}

/*약관*/
.payment-option {
	margin-top: 20px;
	margin-bottom: 10px;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	background-color: #f9f9f9;
	margin-bottom: 10px;
}

.payment-option label {
	font-weight: bold;
}

.payment-option input[type="checkbox"] {
	margin-right: 5px;
}

#option-1-checkbox, #option-2-checkbox, #option-3-checkbox {
	float: left;
	margin-right: 5px;
	width: 20px;
	height: 20px;
}

.payment-option a {
	float: right;
	font-size: 12px;
}

.agree {
	width: 500px;
	height: 100px;
	border: 1px solid black;
	overflow-y: scroll;
}

.agreeDetail {
	font-size: 10px;
}
</style>
<script type="text/javascript"
	src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript"
	src="/ssm/resources/js/subscribe/subscribe.js"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<div class="main-container" style="padding-top:100px;">
	<hr>
	<br>
	<br>
	<div class="container">
	<input id="message" type="hidden" value="${requestScope.message }">
		<div class="subscribeList">
			<p class="title">구독 상품</p>
			<table>
				<tr id="titlerow">
					<th></th>
					<th>상품번호</th>
					<th>상품이름</th>
					<th>가격</th>
					<th>기간</th>
				</tr>
				<c:forEach items="${ requestScope.list }" var="s">
					<tr>
						<td><input type="checkbox"></td>
						<td>${s.subscribeNo}</td>
						<td>${s.subscribeName }</td>
						<td>${s.price }</td>
						<td>${s.subscribeDate }개월</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<br>
		<hr>
		<br>
		<p class="title">결제 방법</p>
		<div id="payment-method">
			<div class="payment-section" id="mobile-payment">
				<p class="title">모바일 결제</p>
				<img src="resources/images/paylogo/danal.png"
					data-payment-method="danal">
			</div>
			<div class="payment-section" id="easy-payment">
				<p class="title">간편 결제</p>
				<img src="resources/images/paylogo/kakao.jpg"
					data-payment-method="kakaopay"><img
					src="resources/images/paylogo/toss.jpg"
					data-payment-method="tosspay">
			</div>
			<div class="payment-section" id="card-payment">
				<p class="title">카드 결제</p>
				<img src="resources/images/paylogo/danal.png"
					data-payment-method="danal_tpay"> <img
					src="resources/images/paylogo/kginicis.jpg"
					data-payment-method="html5_inicis">
			</div>
		</div>
		<br>
		<hr>
		<br>
		
			<p class="title">이용약관</p>

		<div id="agreement"
			style="width: 700px; margin: 0 auto; text-align: center;">
			<div class="payment-option" id="payment-option-1"
				style="margin-bottom: 20px;">
				<input type="checkbox" id="option-1-checkbox"> <label
					for="option-1-checkbox">회원 탈퇴 및 자격 상실 등</label> <a
					onclick="showDetail(1);">자세히</a>
				<p class="agreeDetail" id="detail-1" style="display: none;">①
					회원은 “SSSM”에 언제든지 탈퇴를 요청할 수 있으며 “SSSM”은 즉시 회원탈퇴를 처리합니다. ② 회원이 다음 각 호의 사유에
					해당하는 경우, “SSSM”은 회원자격을 제한 및 정지시킬 수 있습니다. 1. 가입 신청 시에 허위 내용을 등록한 경우 2.
					“SSSM”을 이용하여 구입한 재화 등의 대금, 기타 “SSSM”이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우

					3. 다른 사람의 “SSSM” 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우 4. “SSSM”을 이용하여
					법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우 ③ “SSSM”이 회원 자격을 제한․정지 시킨 후, 동일한
					행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 “SSSM”은 회원자격을 상실시킬 수 있습니다.



					④ “SSSM”이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에
					최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.</p>
			</div>
			<div class="payment-option" id="payment-option-2"
				style="margin-bottom: 20px;">
				<input type="checkbox" id="option-2-checkbox"> <label
					for="option-2-checkbox">청약철회</label> <a onclick="showDetail(2);">자세히</a>
				<p class="agreeDetail" id="detail-2" style="display: none;">①
					“SSSM”이용자는 SSSM몰”상에서 다음 또는 이와 유사한 방법에 의하여 구매를 신청하며, “몰”은 이용자가 구매신청을 함에
					있어서 다음의 각 내용을 알기 쉽게 제공하여야 합니다. 1. 재화 등의 검색 및 선택 2. 받는 사람의 성명, 주소,
					전화번호, 전자우편주소(또는 이동전화번호) 등의 입력 3. 약관내용, 청약철회권이 제한되는 서비스, 배송료․설치비 등의
					비용부담과 관련한 내용에 대한 확인 4. 이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는 표시 (예, 마우스
					클릭) 5. 재화등의 구매신청 및 이에 관한 확인 또는 “몰”의 확인에 대한 동의 6. 결제방법의 선택 ② “몰”이
					제3자에게 구매자 개인정보를 제공할 필요가 있는 경우 1) 개인정보를 제공받는 자, 2)개인정보를 제공받는 자의 개인정보
					이용목적, 3) 제공하는 개인정보의 항목, 4) 개인정보를 제공받는 자의 개인정보 보유 및 이용기간을 구매자에게 알리고
					동의를 받아야 합니다. (동의를 받은 사항이 변경되는 경우에도 같습니다.) ③ “SSSM”이 제3자에게 구매자의 개인정보를
					취급할 수 있도록 업무를 위탁하는 경우에는 1) 개인정보 취급위탁을 받는 자, 2) 개인정보 취급위탁을 하는 업무의
					내용을 구매자에게 알리고 동의를 받아야 합니다. (동의를 받은 사항이 변경되는 경우에도 같습니다.) 다만, 서비스제공에
					관한 계약이행을 위해 필요하고 구매자의 편의증진과 관련된 경우에는 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」에서
					정하고 있는 방법으로 개인정보 취급방침을 통해 알림으로써 고지절차와 동의절차를 거치지 않아도 됩니다.</p>
			</div>

			<div class="payment-option" id="payment-option-3">
				<input type="checkbox" id="option-3-checkbox"> <label
					for="option-3-checkbox">결제 취소 및 환불</label> <a
					onclick="showDetail(3);">자세히</a>
				<p class="agreeDetail" id="detail-3" style="display: none;">①
					“SSSM”과 재화등의 구매에 관한 계약을 체결한 이용자는 「전자상거래 등에서의 소비자보호에 관한 법률」 제13조 제2항에
					따른 계약내용에 관한 서면을 받은 날(그 서면을 받은 때보다 재화 등의 공급이 늦게 이루어진 경우에는 재화 등을
					공급받거나 재화 등의 공급이 시작된 날을 말합니다)부터 7일 이내에는 청약의 철회를 할 수 있습니다. 다만, 청약철회에
					관하여 「전자상거래 등에서의 소비자보호에 관한 법률」에 달리 정함이 있는 경우에는 동 법 규정에 따릅니다. ② 이용자는
					재화 등을 배송 받은 경우 다음 각 호의 1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다. 1. 이용자에게 책임
					있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는
					청약철회를 할 수 있습니다) 2. 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우 3.
					시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우 4. 같은 성능을 지닌 재화 등으로
					복제가 가능한 경우 그 원본인 재화 등의 포장을 훼손한 경우 ③ 제2항제2호 내지 제4호의 경우에 “몰”이 사전에
					청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면
					이용자의 청약철회 등이 제한되지 않습니다. ④ 이용자는 제1항 및 제2항의 규정에 불구하고 재화 등의 내용이 표시·광고
					내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안 날 또는 알
					수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.</p>
			</div>
		</div>
		<input id="email" type="hidden" value="${loginUser.email}"> <input
			id="businessStoreName" type="hidden"
			value="${loginUser.businessStoreName}"> <input id="phone"
			type="hidden" value="${loginUser.phone}"> <input id="userId"
			type="hidden" value="${loginUser.userId}"> <input id="id"
			type="hidden" value="${loginUser.id}">
		<!-- 로그인유저 아이디랑 , 상품번호도 보내야함! -->
		<br> <br> <br> <br> <br>
		<button id="payment-button" onclick="pay();">결제하기</button>
	</div>
	</div>
	<hr>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>




