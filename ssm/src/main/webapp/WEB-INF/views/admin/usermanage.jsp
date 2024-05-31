<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="nowpage" value="1" />
<c:if test="${ !empty requestScope.currentPage }">
	<c:set var="nowpage" value="${ requestScope.currentPage }" />
</c:if>
<c:set var="action" value="$('#searchselect').val()" />
<c:set var="keyword" value="" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저관리</title>
<style type="text/css">
table {
	border-collapse: collapse;
	width: 1300px;
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
th:nth-child(1), td:nth-child(1) {
	width: 10%;
}

th:nth-child(2), td:nth-child(2) {
	width: 20%;
}

th:nth-child(3), td:nth-child(3) {
	width: 20%;
}

th:nth-child(4), td:nth-child(3) {
	width: 20%;
}

th:nth-child(5), td:nth-child(3) {
	width: 20%;
}

th:nth-child(6), td:nth-child(3) {
	width: 10%;
}

th, td {
	border-left: none;
	border-right: none;
}
/*목록*/
div.listdiv {
	height: 40px;
	width: 1300px;
	margin: 20px auto;
	display: flex;
	/* padding-left:400px; */
	justify-content: center;
	position: relative;
}

button.listbtn {
	position: absolute;
	right: 0;
}
/*검색창 CSS*/
input:-ms-input-placeholder {
	color: #a8a8a8;
}

input:-webkit-input-placeholder {
	color: #a8a8a8;
}

input:-moz-input-placeholder {
	color: #a8a8a8;
}

div.searchdiv {
	height: 80px;
	width: 1600px;
	margin: 20px auto;
	display: flex;
	/* padding-left:400px; */
	justify-content: center;
	position: relative;
}

input[type='date'] {
	height: 30px;
}

.searchdiv>button.writerB {
	position: absolute;
	right: 150px;
}

.searchdiv>form {
	width: 600px;
	height: 40px;
}

.searchdiv>input#searchtext {
	font-size: 16px;
	width: 325px;
	padding: 0px;
	border: 1px solid rgb(250, 180, 49);
	outline: none;
	float: left;
	height: 40px;
	margin-right: 2px;
}

.searchbtn {
	width: 100px;
	height: 40px;
	border: none;
	background: rgb(250, 180, 49);
	color: #ffffff;
	font-size: 16px;
}

button.listbtn {
	width: 100px;
	height: 40px;
	border: none;
	background: rgb(250, 180, 49);
	color: #ffffff;
	font-size: 16px;
}
/*회원상세 css*/
/* 유저 정보 컨테이너 스타일 */
.user-info-container {
	background-color: #f2f2f2;
	padding: 80px;
	margin-top: 20px;
	max-width: 1300px;
	margin-left: auto;
	margin-right: auto;
	padding-left: 20px;
	padding-right: 20px;
}

.user-info-parents {
	display: flex;
	justify-content: center;
	margin-top: 80px;
}

.user-info-section {
	width: 400px; /* 각 섹션의 너비 조정 */
	display: inline-block;
	vertical-align: top;
	margin-right: 2%;
	margin-bottom: 20px;
	padding: 100px;
}

.user-info-section ul {
	list-style-type: none;
	padding: 0;
	margin-top: 10px; /* 각 섹션 내용 위 여백 추가 */
}

.user-info-section ul li {
	font-family: sans-serif;
	font-size: 20px;
	margin: 30px;
}

.user-info-section ul li strong {
	font-weight: bold;
	margin-right: 5px;
}

.user-info-section ul li span {
	color: #666;
}

/* 결제 내역 및 정지 내역 컨테이너 스타일 */
.payment-history-container, .suspension-history-container {
	margin-top: 20px;
	margin-bottom: 20px; /* 결제 내역 및 정지 내역 섹션 위아래 여백 추가 */
	text-align: center; /* 섹션 제목 가운데 정렬 */
}

.payment-history-container table, .suspension-history-container table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
}

.payment-history-container th, .suspension-history-container th,
	.payment-history-container td, .suspension-history-container td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

.payment-history-container th, .suspension-history-container th {
	background-color: #f2f2f2;
	color: #333;
}

/* 계정 정지 버튼 스타일 */
.suspend-account-button {
	width: 200px;
	height: 80px;
	border: none;
	background: red;
	color: #ffffff;
	font-size: 20px;
	font-weight: border;
	cursor: pointer;
	margin-top: 10px; /* 버튼 위 여백 추가 */
}

.suspend-account-button:hover {
	background: darkred;
}

.activate-account-button {
	width: 200px;
	height: 80px;
	border: none;
	background: rgb(0, 128, 0);
	color: #ffffff;
	font-size: 20px;
	font-weight: border;
	cursor: pointer;
	margin-top: 10px;
	cursor: pointer; /* 버튼 위 여백 추가 */
}

.activate-account-button:hover {
	background: darkred;
}

/* 섹션 제목 가운데 정렬 */
.user-info-container h2, .payment-history-container h2,
	.suspension-history-container h2 {
	text-align: center;
}

.suspend-account-button:hover {
	background: darkred;
}
/*모달팝업 박스CSS*/
.popup-wrap {
	background-color: rgba(0, 0, 0, .7);
	justify-content: center;
	align-items: center;
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	display: none;
	padding: 15px;
	flex-wrap: wrap;
}

.popup {
	width: 100%;
	max-width: 400px;
	border-radius: 10px;
	overflow: hidden;
	background-color: rgb(180, 180, 180);
	box-shadow: 5px 10px 10px 1px rgba(0, 0, 0, .3);
	margin: auto;
}

.body-contentbox {
	word-break: break-word;
	overflow-y: auto;
	text-align: center;
	font-size: 16px;
}

.contentbox {
	font-size: 16px;
	line-height: 1;
	margin-bottom: 20px;
	min-height: 300px;
	max-height: 300px;
	width: 80%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

select.suspend {
	padding: 8px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
	background-color: #fff;
	width: 200px;
	cursor: pointer;
	margin: 20px;
}

.popup-foot {
	margin-top: 10px;
	margin-bottom: 10px;
	text-align: center;
}

.popup-foot a {
	display: inline-block;
	width: 80px;
	height: 30px;
	padding: 10px 20px;
	margin-right: 10px;
	border-radius: 5px;
	text-decoration: none;
	font-weight: bold;
	font-size: 20px;
}

.popup-foot a:nth-child(1) {
	background-color: red;
	color: white;
}

.popup-foot a:nth-child(2) {
	background-color: #333;
	color: white;
}

.popup-foot a:hover {
	opacity: 0.8;
}

.body-contentbox p {
	margin: 10px;
}

.body-contentbox p#suspendUserInfo {
	margin-top: 20px;
}
</style>
<script type="text/javascript"
	src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<div class="main-container" style="padding-top:100px;">
	<hr>
	<br>
	<br>
	<div class="listdiv">
		<button class="listbtn"
			onclick="javascript:location.href='${pageContext.servletContext.contextPath}/ulist.do?page=1';">1페이지로</button>
	</div>
	<table>
		<tr id="titlerow">
			<th>회원번호</th>
			<th>아이디</th>
			<th>이메일</th>
			<th>상호명</th>
			<th>생년월일</th>
			<th>계정상태</th>
		</tr>
		<c:forEach items="${ requestScope.list }" var="u">
			<tr onclick="showUserDetail('${u.userId}');">
				<td>${u.id}</td>
				<td>${u.userId }</td>
				<td>${u.email }</td>
				<td>${u.businessStoreName }</td>
				<td>${u.userNo }</td>
				<c:if test="${u.loginOk eq 'Y' }">
					<td>이용중</td>
				</c:if>
				<c:if test="${u.loginOk ne 'Y' }">
					<td>이용정지</td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
	<div class="searchdiv">
		<form action="usearch.do" method="get">
			<select style="height: 35px; width: 80px;" name="action"
				id="searchselect">
				<option value="userId">아이디</option>
				<option value="storeName">상호명</option>
			</select> <input style="height: 30px; width: 325px;" type="text"
				id="searchtext" name="keyword" placeholder="검색어 입력"> <input
				type="submit" class="searchbtn" value="검색"> <br>
		</form>
	</div>
	<script type="text/javascript">
		var suspendButton = "<button class='suspend-account-button' onclick='suspendModal();'>계정 정지</button>";
		var activationButton = "<button class='activate-account-button' onclick='activateUser();'>계정 활성화</button>";
		function showUserDetail(id) {
			$
					.ajax({
						url : 'userManageDetail.do',
						type : 'post',
						data : {
							userId : id
						},
						dataType : "json",
						success : function(dataObj) {
							//object => string
							var objStr = JSON.stringify(dataObj);
							//string => parsing : json object
							var jsonObj = JSON.parse(objStr);
							var objUser = jsonObj.objUser;
							console.log('user : ' + objUser);
							var userId = objUser.id;
							$('input#targetAccount').val(userId);
							$('span#id').html(userId);
							$('span#userId').html(objUser.userId);
							$('span#businessStoreName').html(
									decodeURIComponent(
											objUser.businessStoreName).replace(
											/\+/gi, " "));
							$('span#phone').html(objUser.phone);
							$('span#email').html(objUser.email);
							$('span#userNo').html(objUser.userNo);
							$('span#bankNameAndaccountNumber')
									.html(
											/* objUser.bankName + " : " + */objUser.accountNumber);
							$('span#serviceDate').html(
									"<br>" + objUser.serviceDate);
							$('span#lastModified').html(objUser.lastModified);
							if (objUser.loginOk == 'Y') {
								// '계정 정지' 버튼을 생성하여 해당 요소에 추가
								$('li#buttonspace').html(suspendButton);
							} else {
								$('li#buttonspace').html(activationButton);
							}
							;
							var suspensionList = jsonObj.suspensionList;

							var output = "<tr id='titlerow'><th>정지번호</th><th>정지 시작날짜</th><th>정지 종료날짜</th><th>정지사유</th><th>정지사유상세</th></tr>";
							for ( var i in jsonObj.suspensionList) {
								output += "<tr><td>"
										+ suspensionList[i].suspensionNo
										+ "</td><td>"
										+ suspensionList[i].suspensionStart
										+ "</td><td>"
										+ suspensionList[i].suspensionEnd
										+ "</td><td>"
										+ decodeURIComponent(
												suspensionList[i].suspensionTitle)
												.replace(/\+/gi, ' ')
										+ "</td><td>"
										+ decodeURIComponent(
												suspensionList[i].suspensionContent)
												.replace(/\+/gi, ' ')
										+ "</td></tr>";
							}
							;
							$('#suspensionList').html(output);
							var subsPaymentsList = jsonObj.subsPaymentsList;

							var output = "<tr id='titlerow'><th>결제번호</th><th>구독상품이름</th><th>가격</th><th>결제수단</th><th>결제일</th></tr>";
							for ( var i in jsonObj.subsPaymentsList) {
								output += "<tr><td>"
										+ subsPaymentsList[i].payNo
										+ "</td><td>"
										+ decodeURIComponent(
												subsPaymentsList[i].SubscribeName)
												.replace(/\+/gi, ' ')
										+ "</td><td>"
										+ subsPaymentsList[i].amount
										+ "</td><td>"
										+ subsPaymentsList[i].payMethod
										+ "</td><td>"
										+ subsPaymentsList[i].payDate
										+ "</td></tr>";
							}
							;
							$('#subsPaymentsList').html(output);
						},
						error : function(request, status, errorData) {
							console.log("error code : " + request.status
									+ "\nMessage : " + request.responseText
									+ "\nError : " + errorData);
						}
					});
		};
		function suspendUser() {
			var userId = $('span#id').text(); // 사용자 ID 가져오기
			var suspensionTitle = $('#suspensionTitle').val();
			console.log(suspensionTitle);
			var suspensionContent = $('#suspensionContent').val();
			console.log(suspensionContent);
			$.ajax({
				url : 'ususpend.do',
				type : 'post',
				data : {
					targetAccount : userId,
					suspensionTitle : suspensionTitle,
					suspensionContent : suspensionContent
				}, // 사용자 ID를 데이터로 전송
				success : function(response) {
					console.log('User suspended successfully');
					var today = new Date();
					var year = today.getFullYear();
					var month = ('0' + (today.getMonth() + 1)).slice(-2);
					var day = ('0' + today.getDate()).slice(-2);
					var dateString = year + '-' + month + '-' + day;
					$('li#buttonspace').html(activationButton);
					$('table#suspensionList').append(
							"<tr><td>" + response + "</td><td>" + dateString
									+ "</td><td>" + "" + "</td><td>"
									+ suspensionTitle + "</td><td>"
									+ suspensionContent + "</td></tr>");
					closeModal();//모달창닫기
				},
				error : function(request, status, errorData) {
					console.log("Error: " + errorData);
				}
			});
		};
		function activateUser() {
			var userId = $('span#id').text(); // 사용자 ID 가져오기
			var today = new Date();
			var year = today.getFullYear();
			var month = ('0' + (today.getMonth() + 1)).slice(-2);
			var day = ('0' + today.getDate()).slice(-2);
			var dateString = year + '-' + month + '-' + day;//날짜기록용 날짜스트링만들기
			$.ajax({
				url : 'uactivate.do',
				type : 'post',
				data : {
					Id : userId
				}, // 사용자 ID를 데이터로 전송
				success : function(response) {
					console.log('User activated successfully');
					$('li#buttonspace').html(suspendButton);//정지해제 버튼생성
					//정지해제날짜 기록
					$('#suspensionList tr').each(
							function() {
								var suspensionRow = $(this);
								var suspensionNumber = suspensionRow.find(
										'td:first').text(); // 정지번호 열을 확인
								if (suspensionNumber == response) {
									suspensionRow.find('td:nth-child(3)').text(
											dateString); // 정지해제날짜 열에 현재 날짜를 설정
									return false;
								}
							});
				},
				error : function(request, status, errorData) {
					console.log("Error: " + errorData);
				}
			});
		};
	</script>
	<br>
	<c:import url="/WEB-INF/views/common/pagingView.jsp" />
	<br>
	<hr
		style="width: 50%; border-style: dotted; text-align: center; margin: 0px auto;">
	<div class="user-info-container">
		<h2>회원 정보</h2>
		<div class="user-info-parents">
			<div class="user-info-section">
				<ul>
					<li><strong>회원번호:</strong> <span id="id"></span></li>
					<li><strong>아이디:</strong> <span id="userId"></span></li>
					<li><strong>상호명:</strong> <span id="businessStoreName"></span></li>
					<li><strong>전화번호:</strong> <span id="phone"></span></li>
					<li><strong>이메일:</strong> <span id="email"></span></li>
					<li><strong>생년월일:</strong> <span id="userNo"></span></li>
				</ul>
			</div>
			<div class="user-info-section">
				<ul id="userServiceList">
					<li><strong>이용중인 서비스 기한:</strong> <span id="serviceDate"></span></li>
					<li><strong>등록 계좌:</strong> <span
						id="bankNameAndaccountNumber"></span></li>
					<li><strong>가입일시:</strong> <span id="lastModified"></span></li>
					<li id='buttonspace'></li>
				</ul>
			</div>
		</div>
		<!-- 두 번째 구역: 결제 내역 -->
		<div class="payment-history-container">
			<h2>결제 내역</h2>
			<table id="subsPaymentsList">
			</table>
		</div>

		<!-- 세 번째 구역: 정지 내역 -->
		<div class="suspension-history-container">
			<h2>정지 내역</h2>

			<table id="suspensionList">
			</table>
		</div>
	</div>
	<!-- 모달 팝업창  -->
	<div class="container">
		<div class="popup-wrap" id="popup">
			<div class="popup">
				<form id="suspensionForm">
					<div class="body-contentbox">
						<p id="suspendUserInfo"
							style="font-size: 20px; margin-bottom: 0px;"></p>
						<br>
						<h2 style="margin: 10px;">사유를 선택해주세요</h2>
						<select id="suspensionTitle" class="suspend">
							<option>게시글 도배</option>
							<option>비정상적인 이용</option>
							<option>기타</option>
						</select> <br>
						<textarea id="suspensionContent" class="contentbox"
							placeholder="상세사유를 입력해주세요."></textarea>
						<div class="popup-foot">
							<a onclick='suspendUser();'>정지</a> <a onclick='closeModal();'>취소</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	</div>
	<script type="text/javascript">
		function disableScroll() {
			// body 요소의 overflow를 hidden으로 변경하여 스크롤 비활성화
			document.body.style.overflow = 'hidden';
		}

		function enableScroll() {
			// body 요소의 overflow를 다시 visible로 변경하여 스크롤 활성화
			document.body.style.overflow = 'visible';
		}
		//유저 정지 모달 띄우는 펑션
		function suspendModal() {
			$('#suspendUserInfo').html(
					'<span style="font-size:25px;color: red; font-weight: bold;">'
							+ $('span#id').text() + '</span>' + "번 유저를 정지합니다");

			$("#popup").css('display', 'flex').hide().fadeIn();
			disableScroll();
			//팝업을 flex속성으로 바꿔준 후 hide()로 숨기고 다시 fadeIn()으로 효과
		};

		function closeModal() {
			$("#popup").fadeOut();
			enableScroll();
			//컨펌 이벤트 처리
		};
		$("#close").click(function() {
			modalClose(); //모달 닫기 함수 호출
			enableScroll();
		});
	</script>
	<hr>
	
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>




