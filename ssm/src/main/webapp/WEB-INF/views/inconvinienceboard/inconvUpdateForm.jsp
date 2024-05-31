<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>불편사항 수정</title>
<style>
* {
    margin: 0;
    padding: 0;
}

.container {
    font-family: Arial, sans-serif;
    font-size: 18px;
    padding: 20px;
    margin: 25px auto;
    width: 800px;
    outline: dashed 1px black;
}

h3 {
    color: #333;
    font-size: 24px;
    margin-bottom: 10px;
}

.contentbox {
    font-size: 18px; 
    line-height: 1.5;
    margin-bottom: 20px;
    min-height: 400px;
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.btnbox {
    margin-top: 20px;
}

.btnbox button,
.btnbox a {
    display: inline-block;
    padding: 10px 20px;
    margin-right: 10px;
    background-color: rgb(250, 180, 49);
    color: white;
    text-decoration: none;
    border-radius: 5px;
    border: none;
    cursor: pointer;
}

.btnbox button:hover,
.btnbox a:hover {
    background-color: orange;
}

.mv {
    display: inline-block;
    padding: 10px 15px; /* 수정된 부분: 패딩값을 줄임 */
    margin-top: 20px;
    background-color: rgb(250, 180, 49);
    color: white;
    text-decoration: none;
    border-radius: 5px;
    border: none;
    cursor: pointer;
}

.mv:hover {
    background-color: orange;
}
.mv:hover {
    background-color: orange;
}

.title-input {
    font-size: 24px;
    font-weight: bold;
    width: 100%;
    padding: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-bottom: 10px;
}
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<div class="main-container" style="padding-top:100px;">
    <div class="container">
        <hr>
        <form id="modifyForm" action="iupdate.do" method="POST">
            <input type="text" name="boardTitle" maxlength="44" class="title-input"  required value="${inconvBoard.boardTitle}">
            <hr>
            <textarea name="boardContent" class="contentbox" rows="20" cols="20" maxlength="254" required>${inconvBoard.boardContent }</textarea>
            <hr>
            <input type="hidden" name="boardNo" value="${inconvBoard.boardNo }">
        </form>
            <c:url var="lb" value="inconvdetail.do">
                <c:param name="page" value="${page}" />
                <c:param name="ino" value="${inconvBoard.boardNo}" />
            </c:url>
            <a onclick="submitForm()" class="mv">수정하기</a>
            <a href="${pageContext.servletContext.contextPath}/${lb}" class="mv">돌아가기</a>
    </div>
    </div>
    <script>
    function submitForm() {
        document.getElementById("modifyForm").submit();
    }
</script>
    <br>
    <hr>
    <c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
