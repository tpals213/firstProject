<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출퇴근 페이지</title>
<script type="text/javascript"
	src="/ssm/resources/js/jquery-3.7.0.min.js">
    function recordTime(action) {
        var url = "";
        if (action === '퇴근') {
            url = "recordEndTime.do"; // 퇴근 버튼 클릭 시 사용할 URL
        } else {
            url = "recordTimeData.do"; // 출근 버튼 클릭 시 사용할 URL
        }
        location.href = url + "?id=" + $('#id').val() + "&empName=" + $('#empName').val();
    };
</script>

<style type="text/css">
/* 입력 폼과 버튼을 포함한 컨테이너 스타일 */
body {
	font-family: 'Noto Sans', sans-serif; /* 깔끔하고 현대적인 폰트 설정 */
	background-color: #f5f6fa; /* 부드러운 배경색 */
	color: #333; /* 글자색 */
	margin: 0;
	padding: 0;
}

.centered {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	padding-top: 120px; /* 위쪽 여백 조정 */
}

/* 중앙 정렬을 위한 컨테이너 */
.centered {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	padding-top: 100px; /* 위쪽 여백 조정 */
	padding-bottom: 100px; /* 아래쪽 여백 조정 */
}

/* 제목 스타일 */
h2 {
	color: #007bff; /* 파란색 계열로 통일감 */
	margin-bottom: 10px; /* 여백 추가 */
	padding-top: 10px;
}

/* 입력 필드 스타일 */
input[type="text"] {
	padding: 10px;
	margin: 10px 0; /* 상하 여백 추가 */
	border: 1px solid #ccc;
	border-radius: 5px; /* 모서리 둥글게 */
	width: calc(100% - 22px); /* 패딩과 보더 고려한 너비 설정 */
}

/* 컨테이너 내 버튼 개선 */
.container button {
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	background-color: #007bff;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	margin-top: 10px;
	transition: background-color 0.3s; /* 부드러운 색상 변화 */
}

.container button:hover {
	background-color: #0056b3; /* 호버 시 색상 변화 */
}

/* 테이블 스타일 개선 */
#commuteInfoSection table {
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	background-color: #fff; /* 배경색 */
	margin-top: 40px; /* 상단 여백 */
}

/* 테이블 헤더 스타일 */
#commuteInfoSection th {
	background-color: #007bff;
	color: #fff;
	padding: 12px 8px; /* 패딩 추가 */
}

/* 테이블 바디 스타일 */
#commuteInfoSection td {
	padding: 10px 8px; /* 패딩 추가 */
}

/* 테이블 행 스타일 */
#commuteInfoSection tbody tr:nth-child(even) {
	background-color: #f2f2f2; /* 짝수 행 배경색 */
}

#commuteInfoSection tbody tr:hover {
	background-color: #ddd; /* 호버 시 배경색 */
}

/* 반응형 디자인을 위한 미디어 쿼리 */
@media ( max-width : 768px) {
	.container, #commuteInfoSection {
		width: 95%; /* 모바일에서 너비 조정 */
		margin: 20px auto; /* 상단 여백 조정 */
	}
	input[type="text"] {
		width: calc(100% - 22px); /* 모바일에서 입력 필드 너비 조정 */
	}
}
/* 목록 버튼 스타일 */
#listButton {
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	background-color: #007bff;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	margin-top: 20px; /* 상단 여백 추가 */
	transition: background-color 0.3s; /* 부드러운 색상 변화 */
	margin-bottom: 20px; /* 하단 여백 추가 */
}

#listButton:hover {
	background-color: #0056b3; /* 호버 시 색상 변화 */
}
</style>

</head>
<body>
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<c:import url="/WEB-INF/views/common/sidebar.jsp" />
	<hr>
	<div class="centered">
		<div class="container">
			<!-- 출퇴근 버튼 폼 -->
			<form id="timeFrom">
				<label for="empName">사용자 이름:</label> <input type="text" id="empName">
				<input type="hidden" value="${requestScope.empId}" id="empId">
				<input type="hidden" value="${loginUser.id}" id="id">
				<button onclick="recordTime('출근')">출근</button>
				<button onclick="recordTime('퇴근')">퇴근</button>
			</form>
		</div>
		<div id="commuteInfoSection">
			<h2>출퇴근 정보</h2>
			<table>
				<thead>

					<tr>
						<th>직원 번호</th>
						<th>직원 이름</th>
						<th>출근 시간</th>
						<th>퇴근 시간</th>
					</tr>

				</thead>
				<tbody id="commuteInfoBody">
				
				</tbody>

			</table>
			<div class="centered">
				<button id="listButton" type="button"
					onclick="location.href='selectemp.do?id=${loginUser.id}'"> 목록 </button>
			</div>

		</div>
	</div>


</body>
</html>
