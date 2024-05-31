<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>first</title>
<script type="text/javascript"
	src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
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
/*라디오*/
label {
	font-size: 18px;
	line-height: 2rem;
	padding: 0.2em 0.4em;
	flex-direction: row;
}

[type="radio"], span {
	vertical-align: middle;
}

[type="radio"] {
	appearance: none;
	border: max(2px, 0.1em) solid gray;
	border-radius: 50%;
	width: 1.25em;
	height: 1.25em;
	transition: border 0.5s ease-in-out;
}

[type="radio"]:checked {
	border: 0.4em solid tomato;
}

[type="radio"]:focus-visible {
	outline-offset: max(2px, 0.1em);
	outline: max(2px, 0.1em) dotted tomato;
}

[type="radio"]:hover {
	box-shadow: 0 0 0 max(4px, 0.2em) lightgray;
	cursor: pointer;
}

[type="radio"]:hover+span {
	cursor: pointer;
}

[type="radio"]:disabled {
	background-color: lightgray;
	box-shadow: none;
	opacity: 0.7;
	cursor: not-allowed;
}

[type="radio"]:disabled+span {
	opacity: 0.7;
	cursor: not-allowed;
}
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<div class="main-container" style="padding-top:100px;">
	<div class='container'>
		<hr>
		<form id='writeForm' action="nwrite.do" method="POST">
			<input class="title-input" type="text" name="noticeTitle"
				maxlegth="44" placeholder="제목을 입력해주세요 최대 44글자" required>
			<hr>
			<textarea class="contentbox" name="noticeContent" rows="20" cols="20"
				maxlength="254" placeholder="내용을 입력해주세요 최대 254글자" required></textarea>
			<hr>
			<input type='hidden' name="writer"
				value="${sessionScope.loginUser.id }"> <input type='hidden'
				name="page" value="${page}">
			<hr>
			<P>중요도</P>
			<label style="width: 100px;"><input type="radio"
				name="importancy" value=1 checked>1</label> <label
				style="width: 100px;"><input type="radio" name="importancy"
				value=2>2</label> <label style="width: 100px;"><input
				type="radio" name="importancy" value=3>3</label> <br>
		</form>
		<a onclick="submitForm()" class="mv">글쓰기</a> <a
			href="${pageContext.servletContext.contextPath}/${lb}" class="mv">돌아가기</a>

		<c:url var="lb" value="nlist.do">
			<c:param name="page" value="${page}" />
		</c:url>

		<script>
			function submitForm() {
				document.getElementById("writeForm").submit();
			}
		</script>
		<c:url var="lb" value="nlist.do">
			<c:param name="page" value="${page}" />
		</c:url>
	</div>
	</div>
	<br>
	<hr>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>












