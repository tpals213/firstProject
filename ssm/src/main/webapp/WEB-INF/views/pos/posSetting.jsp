<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath }/resources/css/common/reset.css" />
<style>
.wrap {
	width: 1000px;
	padding: 10px 600px 50px 600px;
}

.header {
	background-color: orange;
	width: 100%;
	height: 10vh;
	font-size: 30px;
	text-align: center;
	display: flex;
	flex-wrap: nowrap;
	justify-content: center;
	align-items: center;
	font-weight: 700;
}

.body, .footer {
	background-color: lightgray;
	width: 100%;
}

.body {
	height: 80vh;
	display: flex;
}

.body .tableView {
	width: 80%;
	height: 100%;
	padding: 30px;
	position: relative;
}

.body .buttonList {
	width: 20%;
	height: 100%;
	display: flex;
	flex-direction: column;
	justify-content: flex-end;
	padding-right: 5px;
	parring-bottom: 5px;
}

.title p {
	color: black;
	font-weight: bolder;
}

.button {
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
	border-radius: 8px;
	font-weight: 800;
	height: 80px;
}
/*테이블 모양*/
.tableView {
	position: relative;
}

.tableView a {
	min-width: 150px;
	min-height: 200px;
	max-width: 150px;
	max-height: 200px;
	text-decoration: none;
	text-align: center;
	line-height: 80px;
	background-color: white;
	border: 2px solid black;
	border-radius: 8px;
	margin-bottom: 4px;
	position: absolute;
}

.table:hover {
	box-shadow: 0 0 10px 0 darkgray;
	cursor: pointer;
}

.table.selected {
	border: 3px solid red; /* 선택된 테이블에 빨간 테두리 추가 */
}
/* 테이블 추가 버튼 */
.button.add {
	background-color: DodgerBlue;
}

/* 테이블 삭제 버튼 */
.button.delete {
	background-color: red;
}

/* 메뉴 관리 버튼 */
.button.menu {
	background-color: DodgerBlue;
}

/* 저장 버튼 */
.button.save {
	background-color: LimeGreen;
}

/* 돌아가기 버튼 */
.button.return {
	background-color: DodgerBlue;
}
</style>
<meta charset="UTF-8">
<script type="text/javascript"
	src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet"
	href="/ssm/resources/css/jquery-ui-1.13.2/jquery-ui.min.css" />
<script type="text/javascript"
	src="/ssm/resources/css/jquery-ui-1.13.2/jquery-ui.min.js"></script>
<script>
$(function(){
	document.querySelectorAll(".table").forEach((element)=>{
		 element.setAttribute('draggable','true');
		element.addEventListener("dragstart", (event)=>{
			const objectId = event.target.id; // 해당 객체의 ID 값을 가져옴
		    const posX = event.offsetX;
		    const posY = event.offsetY;
		    event.dataTransfer.setData("text/plain", objectId+","+posX+","+posY); // 드래그하는 요소의 ID 값을 설정하여 데이터 전송 준비
		});
	});
	
	document.querySelector("#tableView").addEventListener("dragover",(event)=>{
		event.preventDefault();
		event.stopPropagation();
	});

	document.querySelector("#tableView").addEventListener("drop", (event)=>{
		event.preventDefault();
		event.stopPropagation();
		
		const tableViewOffSet = $('#tableView').offset();
		const relativeX = event.pageX - tableViewOffSet.left;
		const relativeY = event.pageY - tableViewOffSet.top;
		
		var [id, posX, posY] = event.dataTransfer.getData("text/plain").split(",");
		console.log(id);
		$('#' + id).css('left', (relativeX-parseInt(posX)) + 'px');
		$('#' + id).css('top', (relativeY-parseInt(posY)) + 'px');
	});
	$(document).on('click', '.table', function() {
	    $('.table').removeClass('selected');
	    $(this).addClass('selected');
	});
	
});//documentReady
function addTable() {
	var linkCount = $('#tableView a').length;
	if(linkCount>5){
		alert('테이블은 6개 까지 추가 가능합니다.');
	}else{
		const existingIds = new Set(); // 이미 존재하는 테이블의 ID를 저장하기 위한 Set
	    // 이미 존재하는 테이블의 ID를 확인하여 Set에 추가
	    $('#tableView a').each(function() {
	        existingIds.add($(this).attr('id'));
	    });
	    // 사용되지 않은 ID를 찾아서 새로운 테이블에 할당
	    let newId;
	    for (let i = 1; i <= linkCount + 1; i++) {
	        newId = 'table' + i;
	        if (!existingIds.has(newId)) {
	            break;
	        }
	    }
    // 새로운 <a> 태그 생성
    const newLink = document.createElement('a');
    newLink.textContent = newId; // 링크 텍스트 설정
    newLink.setAttribute('class','table');
    newLink.setAttribute('draggable','true');
    newLink.setAttribute('href', '#'); // 링크 URL 설정
	newLink.setAttribute('id',newId);
    newLink.addEventListener("dragstart", (event) => {
	    const objectId = event.target.id; // 해당 객체의 ID 값을 가져옴
	    const posX = event.offsetX;
	    const posY = event.offsetY;
	    event.dataTransfer.setData("text/plain", objectId+","+posX+","+posY); // 드래그하는 요소의 ID 값을 설정하여 데이터 전송 준비
    });
    // 새로운 <a> 태그를 tableView 안에 추가
    $('#tableView').append(newLink);
	}
}
function deleteTable() {
	const selectedTable = document.querySelector('.table.selected');
    if (selectedTable) {
        const tableId = selectedTable.id; // 선택된 테이블의 ID 값을 가져옴
        selectedTable.remove();

        // 선택된 테이블의 ID 값을 URL에 추가하여 페이지 이동
        location.href = 'deleteTable.do?tableName=' + encodeURIComponent(tableId) +'&id='+${loginUser.id};
    } else {
        alert('삭제할 테이블을 선택하세요.');
    }
}
function saveTable(){
	if(Count ==0){
		alert("테이블이 존재하지 않습니다.");
	}else{
	var userId= $('#userId').val();
	var jarr = new Array();// 테이블 객체 담을 배열
	var Count = $('#tableView a').length;
	var i;
	for(i=1; i<=Count; i++){
	var job = new Object();
	job.tableName = 'table'+i;
	console.log(job.tableName);
	job.tableX=$('#table'+i).css('left');
	console.log(job.tableX);
	job.tableY=$('#table'+i).css('top');
	console.log(job.tableY);
	job.userId = userId;
	jarr.push(job);
	};
	$.ajax({
		url: "saveTableXY.do",
		type: 'post',
		data: JSON.stringify(jarr),
		contentType: "application/json; charset=utf-8",
		success: function(result){
			alert("요청 성공 : " + result);				
		},
		error: function(request, status, errorData){
			console.log("error code : " + request.status
					+ "\nMessage : " + request.responseText
					+ "\nError : " + errorData);
		}
	}); //ajax		
	
	}
	
}
</script>
<title>SSM웹포스기 세팅화면</title>
</head>
<body>
	<div class="wrap">
		<div class="header">
			<p class="title">SSM 웹 포스기</p>
		</div>
		<div class="body">

			<div class="tableView" id="tableView">
				<c:forEach items="${requestScope.list}" var="t">
					<a class="table" id="${t.tableName }"
						style="left:${t.tableX}px;top:${t.tableY}px">${t.tableName }</a>
				</c:forEach>
			</div>

			<div class="buttonList">
				<button class="button add" onclick="addTable();">테이블 추가</button>
				<button class="button delete" onclick="deleteTable()">테이블
					삭제</button>
				<button class="button menu">메뉴 관리</button>
				<button class="button save" onclick="saveTable()">저장</button>
				<button class="button return"
					onclick="location.href = 'mvTablePos.do?id=${loginUser.id}'">돌아가기</button>
				<input type="hidden" id="userId" value="${loginUser.id }">
			</div>
		</div>

	</div>
</body>
</html>