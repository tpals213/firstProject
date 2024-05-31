<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first : error</title>
</head>
<body>
<h1>오류 발생 : </h1>

 <%-- jsp 에서 넘어온 에러일 때  --%>
 <c:set var="e" value="<%= exception %>" />
 <c:if test="${ !empty e }">
 	<h3>jsp 페이지 오류 : ${ e.message }</h3>
 </c:if>
 <%-- 서블릿(컨트롤러)에서 넘어온 에러일 때 --%>
 <c:if test="${ empty e }">
 	<h3>컨트롤러 오류 : ${ requestScope.message } </h3>
 </c:if>
 <%-- 스프링에서는 내보낼 뷰페이지들은 모두 설정된 ViewResolver 를 거쳐서 나가야 함 
 			즉, 컨트롤러로 요청을 보내서 뷰파일명을 리턴시켜야 한다는 뜻임
 --%>
<c:url var="moveinsert" value="gmoveinsert.do?id=${loginUser.id}" />
<a href="${moveinsert}">등록페이지로 이동</a>
 
 
</body>
</html>







