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
.modify-button {
	font-size: 12px;
    display: inline-block;
    padding: 15px 25px;
    margin-top: 20px;
    background-color: rgb(250, 180, 49);
    color: white;
    text-decoration: none;
    border-radius: 5px;
    border: none;
    cursor: pointer;
}

.modify-button:hover {
    background-color: orange;
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
<div class="main-container" style="padding-top:100px;">
<div class="container">
<hr>
		<form id='modifyForm' action="nupdate.do" method="POST">
			<input class="title-input"type="text" name="noticeTitle" maxlegth="44"  value=" ${notice.noticeTitle }"required>
			<hr>
			<textarea class="contentbox"name="noticeContent" rows="20" cols="20" maxlength="254"  required>${notice.noticeContent }</textarea>
			<hr>
			<input type='hidden' name="writer"
				value="${sessionScope.loginUser.id }">
			<input type='hidden' name="page" value="${page}">
			<input type='hidden' name="noticeNo" value="${notice.noticeNo }">
			<hr>
			<label style="width: 100px;"><p>중요도 : </p><input type="radio"
				name="importancy" value=1>1</label> <label style="width: 100px;"><input
				type="radio" name="importancy" value=2>2</label> <label
				style="width: 100px;"><input type="radio" name="importancy"
				value=3>3</label> <br> 
		</form>
		 <c:url var="lb" value="ndetail.do">
                <c:param name="page" value="${page}" />
                <c:param name="nno" value="${notice.noticeNo}" />
            </c:url>
            <a onclick="submitForm()" class="mv">수정하기</a>
            <a href="${pageContext.servletContext.contextPath}/${lb}" class="mv">돌아가기</a>
		<script>
		$(document).ready(function(){
		    var ni = "${notice.importancy}"; 
		    $("input[type='radio']").each(function(){
		        if($(this).val() == ni){ 
		            $(this).prop('checked', true); 
		        }
		    });
		}); // document ready 기존 체크되어있던 중요도로 체크
		function submitForm() {
	        document.getElementById("modifyForm").submit();
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












