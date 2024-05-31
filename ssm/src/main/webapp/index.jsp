<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
</head>
<body>
<!--  웰컴 요청(첫페이지 접속)이 오면 main 페이지가 나가도록 요청을 전달함 (forwarding)
		첫페이지 요청 url : http://domain/ => 개발시에는 http://localhost:톰켓포트번호/context-root명(프로젝트명)/ 
		예) http://localhost:8080/first-->
<%-- <%
	RequestDispatcher view = request.getRequestDispatcher("main.do");
	//스프링은 바로 main으로 보낼 수 없다. 컨트롤러를 무조건 거쳐야함 . main.do 컨트롤러로 보내고 
	//컨트롤러에서 main으로 보냄
	view.forward(request, response);
%> --%>

<jsp:forward page="main.do" />



</body>
</html>








