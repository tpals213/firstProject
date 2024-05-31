<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/user/login.css">
<link rel="stylesheet" href="resources/css/user/enroll.css">
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
const emailAuth = () => {
	$.ajax({
		url: "emailAuth.do",
		data: {userEmail : $("#email").val()},
		type : "post",
		dataType : "json",
		success : (data) => {
			console.log("result : " + data);
			
			const objStr = JSON.stringify(data);
			const parseJson = JSON.parse(objStr);
			
			code = parseJson.authCode;
			
			console.log(code);
			$("#submitBtn").prop("disabled", true);
			alert("인증 코드가 입력하신 이메일로 전송 되었습니다");
			
			$("li.chkEmailAuth").css("display", "block");
		},
		error: (jqXHR, textStatus, errorThrown) => {
			console.log("error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
		}
	}) // ajax
}

const validateForm = () => {
	if (!$("#userId").val()) {
	    alert("아이디를 입력해 주세요.");
	    return false;
	} else if (!$("#email").val()) {
	    alert("이메일을 입력해 주세요.");
	    return false;
	} else if (!$("#chkEmailAuth").val()) {
	    alert("이메일 인증을 해주세요.");
	    return false;
	}
    return true; 
}

let code = "" ;

const sendNewPw = () => {
	alert("새로운 암호가 입력하신 이메일로 전송 되었습니다");
	$.ajax({
		url: "searchPw.do",
		data: {userEmail : $("#email").val()},
		type : "post",
		dataType : "json",
		success : (data) => {
			console.log("result : " + data);
			
			$("#submitBtn").prop("disabled", true);
			
			$("li.chkEmailAuth").css("display", "block");
		},
		error: (jqXHR, textStatus, errorThrown) => {
			console.log("error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
		}
	}) // ajax
}

$(()=> {
	
$("#email").on("keyup", () => {
    const email = $("#email").val();
    const message = "이메일 형식을 확인해주세요";
    const regex = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
    $("#submitBtn").prop("disabled", false);
    
    if (!regex.test(email)) {
        $("li.relative > p").eq(0).html(message).css("color", "red");
        $("#chkEMail").css("display", "none");
    } else {
        $("li.relative > p").eq(0).html(message).css("color", "orange");
        $("#chkEMail").css("display", "block");
    }
});

$("#chkEmailAuth").on("keyup", () => {
	 const chkEmailAuth = $("#chkEmailAuth").val();
	 const message = "인증번호가 ";
	 
	if (chkEmailAuth != code) {
        $("li.relative > p").eq(1).html(message + "일치하지 않습니다").css("color", "red");
        $("#chkEMail").css("display", "block");
        $(".searchId").prop("disabled", true);
    } else {
        $("li.relative > p").eq(1).html(message + "일치합니다").css("color", "orange");
        $("#chkEMail").css("display", "none");
        $(".searchId").prop("disabled", false);
    }
})	;

}); //doc ready;

	
</script>
</head>
<body>
	<div class="login-box">
		<div class="inner-box">
			<div class="logo-box">
				<h1 class="logo">
					<c:url var="callMain" value="main.do" />
					<a href="${ callMain }"> 
						<img src="${pageContext.servletContext.contextPath }/resources/images/common/logo.png" alt="logo" />
					</a>
				</h1>
			</div>
			<div class="form-box">
				<form action="searchPw.do" method="post" onsubmit="return validateForm();">
					<ul>
						<li>
							<input type="text" name="userId" id="userId" placeholder="아이디">
						</li>
						<li class="auth relative">
							<p></p>
							<input type="email" name="email" id="email" placeholder="이메일" value="${ param.email}">							
							<input type="button" value="이메일 인증" class="chkEMail" id="chkEMail" onclick="emailAuth();">
						</li>
						<li class="auth relative chkEmailAuth">
							<p></p>
							<input type="text"  id="chkEmailAuth" placeholder="인증번호">
						</li>
						<li>
							<input type="submit" value="비밀번호 찾기" class="searchPw" onclick="sendNewPw();">
						</li>
					</ul>
				</form>
				<ul class="go-page">
					<li>
						<a href="${pageContext.servletContext.contextPath }/goSearchId.do">아이디 찾기</a> | 
						<c:url var="goEnroll" value="goEnroll.do" />
						<a href="${ goEnroll }">회원가입</a>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>