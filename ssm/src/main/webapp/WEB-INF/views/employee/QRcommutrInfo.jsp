<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QR 코드</title>
</head>
<body>
    <form action="QRController.do">
    <h2>QR 코드 이미지</h2>
    
     <img src="QRimages.do" alt="QR 코드">
 <img src="${pageContext.request.contextPath}/resources/qrcode.png" alt="바코드"> -
    <br>
    <button onclick="location.href='recordTimePage.do'">출퇴근버튼</button>
    <br>
    <h3>내 티스토리 블로그 QR Code!</h3>
    <a href="QRimages.do">QR to Tistory!!</a>
    </form>
</body>
</html>