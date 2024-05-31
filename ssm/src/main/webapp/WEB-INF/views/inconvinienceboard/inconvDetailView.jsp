<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>불편사항상세</title>
<style>
* {
	margin: 0;
	padding: 0;
}

.container {
	font-family: arial;
	font-size: 18px;
	padding: 20px;
	margin: 25px auto;
	width: 800px;
	outline: dashed 1px black;
}

h3 {
	color: #333;
	margin-bottom: 10px;
}

.author-info {
	margin-bottom: 20px;
}

.author-info span {
	color: #666;
}

.contentbox {
    font-size: 18px; 
    line-height: 1.5;
    margin-bottom: 20px;
    min-height: 400px;
}

.btnbox {
	margin-top: 20px;
}

.btnbox a {
	display: inline-block;
	padding: 10px 20px;
	margin-right: 10px;
	background-color: rgb(250, 180, 49);
	color: white;
	text-decoration: none;
	border-radius: 5px;
}

.btnbox a:last-child {
	margin-right: 0;
}

.btnbox a:hover {
	background-color: orange;
}
.comment-section {
    margin-top: 20px;
}

.comment-section h4 {
    font-size: 20px;
    margin-bottom: 10px;
    color: #333;
}

.comment-form .form-group {
    margin-bottom: 10px;
}

.comment-form textarea {
    width: 100%;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.comment-form button {
    padding: 10px 20px;
    background-color: rgb(250, 180, 49);
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.comment-form button:hover {
    background-color: orange;
}

.comments {
    margin-top: 20px;
}

.comment {
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 10px;
    margin-bottom: 10px;
}

.comment .author {
    font-weight: bold;
    margin-bottom: 5px;
}

.comment .content {
    font-size: 16px;
}
select#statusOption {
    padding: 8px; /* 내부 여백 설정 */
    font-size: 16px; /* 폰트 크기 설정 */
    border: 1px solid #ccc; /* 테두리 설정 */
    border-radius: 5px; /* 테두리 둥글게 설정 */
    background-color: #fff; /* 배경색 설정 */
    width: 200px; /* 너비 설정 */
    cursor: pointer; /* 커서 모양 변경 */
}
</style>
<script type="text/javascript"
	src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
			$(function(){
				if(${loginUser.adminOk =='N'}){
			    switch (${inconvBoard.status}) {
			        case 1:
			            $('#status').html($('#status').html() + "조치전");
			            break;
			        case 2:
			            $('#status').html($('#status').html() + "조치중");
			            break;
			        case 3:
			            $('#status').html($('#status').html() + "조치완료");
			            break;
			    }}
				else{
					$('#status').html($('#status').html() +
							'<select id="statusOption">'+
							'<option value="1">조치전</option>'+
							'<option value="2">조치중</option>' +
							'<option value="3">조치완료</option>' +
							'</select>'
					)
					switch (${inconvBoard.status}) {
			        case 1: $("#statusOption").val("1").prop("selected", true); 
			            break;
			        case 2:
			        	$("#statusOption").val("2").prop("selected", true); 
			            break;
			        case 3:
			        	$("#statusOption").val("3").prop("selected", true); 
			            break;
			    }
				}
				$('#statusOption').change(function() {
			        // 선택된 옵션의 값을 가져옴
			        var selectedValue = $(this).val();
			        // 선택된 값이 있다면 컨트롤러로 요청을 보냅니다.
			        if (selectedValue) {
			        	var boardNo = ${inconvBoard.boardNo}
			            $.ajax({
			                url: 'stchange.do',
			                method: 'POST', // 요청 메소드 (POST 또는 GET)
			                data: { status: selectedValue, boardNo : boardNo }, // 요청으로 보낼 데이터
			                success: function(response) {
			                    // 성공적으로 응답을 받았을 때 실행할 코드
			                    console.log('status바꾸기 성공.');
			                },
			                error: function(xhr, status, error) {
			                    // 요청이 실패했을 때 실행할 코드
			                    console.error('status 바꾸기 실패 : ', error);
			                }
			            });
			        }
			    });
				
			});	
			</script>
</head>
<body>
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<div class="main-container" style="padding-top:100px;">
	<div class="container">
		<br>
		<h3>${inconvBoard.boardTitle }</h3>
		<br> <span>${inconvBoard.writer }</span> &nbsp; &nbsp; &nbsp;
		&nbsp;&nbsp;&nbsp; &nbsp; <span id="status">조치상태 : &nbsp;</span>
		&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; <span>Date:
			${inconvBoard.writeDate }</span> <br>
		<hr>
		<br>
		<div class="contentbox">${inconvBoard.boardContent }</div>
		<br>
		<hr>
		<div class="btnbox">
			<c:url var="ilist" value="inconvlist.do">
				<c:param name="page" value='${currentPage}' />
			</c:url>
			<a href=${ilist}>목록으로</a>
			<c:if
				test="${(sessionScope.loginUser.id eq inconvBoard.id)|| sessionScope.loginUser.adminOk eq 'Y' }">
				<c:if test="${sessionScope.loginUser.userId eq inconvBoard.writer}">
					<c:url var="aupdate" value="mvupdatei.do">
						<c:param name="boardNo" value='${inconvBoard.boardNo}' />
						<c:param name="page" value='${currentPage }' />
					</c:url>
					<a href='${aupdate }'>수정</a>
				</c:if>
				<c:url var="adelete" value="deletei.do">
					<c:param name="page" value='${currentPage}' />
					<c:param name="inconvNo" value='${inconvBoard.boardNo }' />
				</c:url>
				<a href=${adelete}>삭제</a>
			</c:if>
		</div>
		<c:if test="${inconvBoardReply !=null }">
		<div class="comments" style="background-color: #f9f9f9; padding: 10px;">
		 <span style="font-size: 14px;">관리자 : ${inconvBoardReply.user }</span> &nbsp; &nbsp; &nbsp;
		 <span style="font-size: 14px;">작성일자 : ${inconvBoardReply.writeDate}</span><br><hr>
		 ${inconvBoardReply.commentContent }
		</div>
		</c:if>

		<c:if
			test="${sessionScope.loginUser.adminOk=='Y'&&inconvBoardReply==null }">
			<div class="comment-section">
				<form class="comment-form" action="iconvreply.do">
					<div class="form-group">
						<textarea name="commentContent" class="form-control" placeholder="댓글을 입력하세요" required></textarea>
					</div>
					<input type="hidden" name="boardNo" value="${inconvBoard.boardNo }">
					<input type="hidden" name="id" value="${sessionScope.loginUser.id }">
					<input type="hidden" name="user" value="${sessionScope.loginUser.userId }">
					<input type="hidden" name="page" value='${currentPage }' >
					<button type="submit" class="btn btn-primary">작성</button>
				</form>
			</div>
		</c:if>
	</div>
	</div>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
