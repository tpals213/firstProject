<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/user/enroll.css">
<link rel="stylesheet" href="resources/css/user/myPage.css">
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript" src="${ pageContext.servletContext.contextPath }/resources/js/user/enroll.js" defer></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.1/kakao.min.js" integrity="sha384-kDljxUXHaJ9xAb2AzRd59KxjrFjzHa5TAoFQ6GbYTCAG0bjM55XohjjDT7tDDC01" crossorigin="anonymous"></script>
<script>

$(() => {
	$(".form-box ul li.relative p").css("color", "#000");
	$("li.businessStoreName").css("display", "block");
	$("#submitBtn").prop("disabled", true);
	
	$("#email").on("keyup", () => {
		$("#chkEmailAuth").val("");
	});
	
	// 선택한 사진 파일 이미지 미리보기 처리
    $("#profileUrl").change(function(event) {
        const files = event.currentTarget.files;
        const file = files[0];
        const myphoto = $(".photo");
        console.log(file.name);
        
        const reader = new FileReader();
        reader.onload = function(e) {          
            myphoto.attr('src', e.target.result);
            myphoto.attr('data-file', file.name);
        };
        reader.readAsDataURL(file);    
    });
	
    $("#withdrawButton").click(function(){
        if(confirm("회원탈퇴를 진행하시겠습니까?")) {
            if(confirm("정말로 하시겠습니까?")) {
                $.ajax({
                    url: "withdraw.do",
                    type: "POST",
                    data: { 
                    	id: "${loginUser.id}",
                    	userId: "${loginUser.userId}",
                    	email: "${loginUser.email}"
                    	}, 
                    success: function(response) {
                        console.log("회원탈퇴 성공");
                        location.href = "main.do"
                    },
                    error: function(xhr, status, error) {
                        console.error("회원탈퇴 실패");
                        console.log(error);
                    }
                });
            } else {
                alert("회원탈퇴를 취소하였습니다.");
                return false;
            }
        } else {
            alert("회원탈퇴를 취소하였습니다.");
            return false;
        }
    });
	
    
}); //doc ready;

</script>
</head>
<body>
	<div class="enroll-box">
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
				<form action="userInfoUpdate.do" method="post" onsubmit="return validateForm();" enctype="multipart/form-data">
				<input type="hidden" name=profileUrl value="${loginUser.profileUrl }" >
					<ul>
						<li class="profile-img">
							<div class="img-box">
    							<c:if test="${empty loginUser.profileUrl }">
									<img src="${pageContext.servletContext.contextPath }/resources/images/common/profile.png" alt="프로필" class="photo">
								</c:if>
								<c:if test="${!empty loginUser.profileUrl }">
									<img src="resources/user_upfiles/${loginUser.profileUrl}" alt="프로필" class="photo">
								</c:if>
							</div>
							<div class="upfile">
								<input type="file" name="upfile" id="profileUrl" value="">
							</div>
						</li>
						
						<li class="auth relative first">
							<p>아이디</p>
							<input type="text" name="userId" id="userId" placeholder="아이디" value="${loginUser.userId}" readonly>
						</li>
						<li class="relative">
							<p>비밀번호</p>
							<input type="password" name="passWd" id="passWd" placeholder="비밀번호">
						</li>
						<li class="relative">
							<p>비밀번호 확인</p>
							<input type="password" name="passWd2" id="passWd2" placeholder="비밀번호 확인">
						</li>
						<li class="auth relative">
							<p>이메일</p>
							<input type="email" name="email" id="email" placeholder="이메일" value="${ loginUser.email}">							
							<input type="button" value="이메일 인증" class="chkEMail" id="chkEMail" onclick="emailAuth();">
						</li>
						<li class="auth relative chkEmailAuth">
							<p></p>
							<input type="text"  id="chkEmailAuth" placeholder="인증번호" value="1234">
							<!-- <input type="button" value="이메일 인증 확인"> -->
						</li>
						<li class="relative">
							<p>생년월일</p>
							<input type="text" name="userNo" id="userNo" placeholder="생년월일 (ex.19980101)" value="${ loginUser.userNo }">
						</li>
						<li class="relative">
							<p>전화번호</p>
							<input type="tel" name="phone" id="phone" placeholder="전화번호 (ex.010-1234-5678)" value="${ loginUser.phone }">
						</li>
						<li class="auth relative">
							<p>사업자 번호</p>
							<input type="text" name="businessNo" id="businessNo" placeholder="사업자 번호 (ex.123 45 789)" value="${ loginUser.businessNo }">
							<input type="button" value="사업자 인증" id="businessNoBtn" onclick="busicessNoChk();">
						</li>
						<li class="businessStoreName relative">
						<p>사업장 명</p>
							<input type="text" name="businessStoreName" id="businessStoreName" readonly value="${ loginUser.businessStoreName }">						
						</li>
						<li class="auth relative">
							<p>계좌 번호</p>
							<input type="text" name="accountNumber" id="accountNumber" placeholder="계좌번호" value="${ loginUser.accountNumber }">
						</li>
						<li>
							<input type="submit" value="수정하기" class="enroll" id="submitBtn">
						</li>
					</ul>
				</form>
				<div class="withdraw-box">
						<ul>
							<li>
								<p>------------------- 또는 --------------------</p>
							</li>
							<li>
								<input type="submit" value="회원탈퇴" class="withdraw" id="withdrawButton">
							</li>
						</ul>
				</div>				
			</div>
		</div>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>