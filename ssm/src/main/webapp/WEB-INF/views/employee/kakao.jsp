<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>메시지 보내기</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f3f5f9;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.container {
	max-width: 600px;
	background-color: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

#messageInput {
	width: calc(100% - 40px);
	padding: 10px;
	margin: 10px 0;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
}

#messageInput:focus {
	outline: none;
	border-color: #007bff;
}

input[type="button"] {
	width: 100%;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	background-color: #ff69b4;
	color: #fff;
	cursor: pointer;
	transition: background-color 0.3s;
}

input[type="button"]:hover {
	background-color: #ff1493;
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

<div class="container">
    <form id="messageForm">
        <textarea id="messageInput" name="message" rows="4" cols="50" placeholder="메시지를 입력하세요"></textarea>
        <input type="button" value="메시지 보내기" onclick="sendMessage()">
    </form>
</div>
<button type="button" onclick="location.href='selectemp.do?id=${loginUser.id}'">목록으로 돌아가기</button>
<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript">
function sendMessage() {
    var message = document.getElementById("messageInput").value;

    Kakao.init('f73d56570e7fb0efa7fa0f476dd12336');
    Kakao.Link.sendDefault({
        objectType: 'text',
        text: message,
        link: {
            mobileWebUrl: 'https://developers.kakao.com',
            webUrl: 'https://developers.kakao.com',
        },
    });

    document.getElementById("messageInput").value = "";
}

document.getElementById("messageForm").addEventListener("submit", function(event) {
    event.preventDefault();
    sendMessage();
});
</script>
</body>
</html>
