<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="nowpage" value="1" />
<c:if test="${ !empty requestScope.currentPage }">
	<c:set var="nowpage" value="${requestScope.currentPage }" />
</c:if>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/goods/goodsDetail.css" />
<title>goodsListView</title>

<script type="text/javascript" src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">

$(function(){
	//input 태그의 name 이 item 의 값이 바뀌면(change) 작동되는 이벤트 핸들러 작성
	$('input[name=item]').on('change', function(){
		//여러 개의 태그 중에서 체크표시가 된 태그를 선택
		$('input[name=item]').each(function(index){
			//선택된 radio 순번대로 하나씩 checked 인지 확인함
			if($(this).is(':checked')){
				//체크 표시된 아이템에 대한 폼이 보여지게 처리함
				$('form.sform').eq(index).css('display', 'block');
			}else{
				//체크 표시 안된 아이템의 폼은 안 보이게 처리함
				$('form.sform').eq(index).css('display', 'none');
			}
		});  //each
	});  //on
	
	$('#checkBoxAll').click(function () {
	       if ($(this).is(":checked")) {
	         $(".chkCheckBoxId").prop("checked", true)
	       }else{
	         $(".chkCheckBoxId").prop("checked", false)
	       }
	     });
});  //document ready

</script>
<style type="text/css">
	.searchdiv {
        margin: 0 auto; /* 좌우 마진을 자동으로 설정하여 가운데 정렬 */
        width: fit-content; /* 내용에 맞게 자동으로 너비 설정 */
    }
	div.listdiv {
	height: 40px;
	width: 1300px;
	margin: 20px auto;
	display: flex;
	/* padding-left:400px; */
	justify-content: center;
	position: relative;
	}
	.searchbtn {
	width: 50px;
	height: 40px;
	border: none;
	background: rgb(250, 180, 49);
	color: #ffffff;
	font-size: 16px;
	}
	button.listbtn {
		position: absolute;
		right: 200px;
	}
    div.searchdiv {
		height: 80px;
		width: 1600px;
		margin: 20px auto;
		display: flex;
		/* padding-left:400px; */
		justify-content: center;
		position: relative;
	}
    .searchdiv>button.savebutton {
		position: absolute;
		right: 200px;
	}
	.searchdiv>button.deletebutton {
		position: absolute;
		right: 200px;
	}
	button {
		width: 50px;
		height: 40px;
		border: none;
		background: rgb(250, 180, 49);
		color: #ffffff;
		font-size: 16px;
	}
	
</style>

</head>
<body>
<c:import url="/WEB-INF/views/common/header.jsp" />
<div style="padding-top : 100px;">
<hr>
<br>
<c:import url="/WEB-INF/views/common/sidebar.jsp" />
<h1 style="text-align: center;">재고 현황</h1>


<!-- 저장 버튼 -->
<script>
    function updateSelectedGoods() {
        // 체크된 행을 가져오기
        var checkedRows = document.querySelectorAll('.chkCheckBoxId:checked');
        
        // 변경된 내용을 저장할 배열
        var updatedGoods = [];

        // 각 체크된 행에 대해
        checkedRows.forEach(function(row) {
            var rowIndex = row.closest('tr').rowIndex - 1; // 첫 번째 행은 헤더이므로 -1
            var rowData = {
                id: ${loginUser.id}, // loginUser.id 값 가져오기
                goodsNo: row.value, // 체크된 체크박스의 값(상품 번호) 가져오기
                pdQuantity: document.getElementById('pdQuantity_' + rowIndex).value,
                salePrice: document.getElementById('salePrice_' + rowIndex).value,
                goodsPrice: document.getElementById('goodsPrice_' + rowIndex).value,
                minOrderQuantity: document.getElementById('minOrderQuantity_' + rowIndex).value,
                minAlarmQuantity: document.getElementById('minAlarmQuantity_' + rowIndex).value
            };
            updatedGoods.push(rowData);

        });

        // 알림 대화 상자 표시
        var confirmMessage = "변경된 내용을 저장 하시겠습니까?";
        if (confirm(confirmMessage)) {
            // 변경된 내용을 서버로 전송
            $.ajax({
                type: "POST",
                url: "gupdate.do",
                data: JSON.stringify(updatedGoods),
                contentType: "application/json; charset=utf-8",
                success: function(result) {
                	alert("저장 성공")
                    location.reload(); 
                	
                	updatedGoods.forEach(function(rowData) {
                        if (parseInt(rowData.pdQuantity) < parseInt(rowData.minAlarmQuantity)) {
                            alert( (rowData.goodsNo) + "번 상품의 재고가 부족합니다. 주의하세요.");
                        }
                	});
                },
                error: function(request, status, errorData) {
                    console.log("error code : " + request.status
                        + "\nMessage : " + request.responseText
                        + "\nError : " + errorData);
                } 
            });  
        } else {
            alert("수정이 취소되었습니다.");
        }
    }
</script>


<!-- 삭제 버튼 -->
<script>
    function deleteSelectedGoods() {
    	var jarr = new Array();
    	
        // 선택된 체크박스에서 goodsNo 추출
        $(".chkCheckBoxId:checked").each(function() {
        	 var job = new Object();
        	 job.id = parseInt(${loginUser.id});
        	 job.goodsNo = $(this).val();
        	 /* var goodsObj = { id: id , goodsNo: goodsNo }; */
        	 jarr.push(job);
        });
          
        var confirmMessage = "선택한 상품을 삭제하시겠습니까?";
        if (confirm(confirmMessage)) {
            $.ajax({
                type: "POST",
                url: "gdelete.do",
                data: JSON.stringify(jarr),
                contentType: "application/json; charset=utf-8",
                success: function(result) {
                    location.reload(); 
                },
                error: function(request, status, errorData) {
                    console.log("error code : " + request.status
                        + "\nMessage : " + request.responseText
                        + "\nError : " + errorData);
                } 
            });      
        } else {
            alert("삭제가 취소되었습니다.");
        }
    }
</script>	
<script type="text/javascript">
$('#checkBoxAll').click(function () {
    if ($(this).is(":checked")) {
      $(".chkCheckBoxId").prop("checked", true)
    }else{
      $(".chkCheckBoxId").prop("checked", false)
    }
  });
</script>
	

	
<div style="margin-left: auto; margin-right: auto; width: 1400px;">
		<div class="listdiv">
			<button class="listbtn" onclick="javascript:location.href='${pageContext.servletContext.contextPath}/glist.do?page=1&id=${loginUser.id}';">목록</button>	
			</div>
			<form action="gsearch.do" method="post">
			<input type="hidden" id="id" name="id" , value="${ loginUser.id }">
			
			
			<table align="center" border="1" cellspacing="25" width="100%">
				<thead>
					<th class="table-head"><input type="checkbox" id="checkBoxAll"></th>
					<th style="text-align: center; white-space: nowrap;">번호</th>
					<th style="text-align: center; white-space: nowrap;">상품명</th>
					<th style="text-align: center; white-space: nowrap;">수량</th>
					<th style="text-align: center; white-space: nowrap;">단위</th>
					<th style="text-align: center; white-space: nowrap;">판매가격</th>
					<th style="text-align: center; white-space: nowrap;">발주가격</th>
					<th style="text-align: center; white-space: nowrap;">발주 최소 수량</th>
					<th style="text-align: center; white-space: nowrap;">알림 최소 수량</th>
					<th style="text-align: center; white-space: nowrap;">발주처</th>
					<th style="text-align: center; white-space: nowrap;">발주 연락처</th>
					<th style="text-align: center; white-space: nowrap;">원산지</th>
					</tr>
				<thead>
					<c:forEach items="${requestScope.list}" var="goodsPrint" varStatus="loop">
						<tr>
							<td class="table-data"><input type="checkbox"
								class="chkCheckBoxId" value="${goodsPrint.goodsNo}"></td>
							<td align="center" style="white-space: nowrap;">${goodsPrint.goodsNo}</td>
							<td align="center" style="white-space: nowrap;">${goodsPrint.goodsName}</td>
							<td align="center" style="white-space: nowrap;">
								<div style="display: inline-block;">
									<input type="number" id="pdQuantity_${loop.index}"
										value="${goodsPrint.pdQuantity}" name="pdQuantity"
										style="width: 70px; margin-right: 0px; vertical-align: middle;" />
								</div>
							</td>
							<td align="center" style="white-space: nowrap;">${goodsPrint.goodsUnit}</td>

							<td align="center" style="white-space: nowrap;">
								<div style="display: inline-block;">
									<input type="number" id="salePrice_${loop.index}"
										value="${goodsPrint.salePrice}" name="salePrice"
										style="width: 70px; margin-right: 0px; vertical-align: middle;" />
								</div>
							</td>
							<td align="center" style="white-space: nowrap;">
								<div style="display: inline-block;">
									<input type="number" id="goodsPrice_${loop.index}"
										value="${goodsPrint.goodsPrice}" name="goodsPrice"
										style="width: 70px; margin-right: 0px; vertical-align: middle;" />
								</div>
							</td>

							<td align="center" style="white-space: nowrap;">
								<div style="display: inline-block;">
									<input type="number" id="minOrderQuantity_${loop.index}"
										value="${goodsPrint.minOrderQuantity}" name="minOrderQuantity"
										style="width: 70px; margin-right: 5px; vertical-align: middle;" />
								</div>
							</td>
							<td align="center" style="white-space: nowrap;">
								<div style="display: inline-block;">
									<input type="number" id="minAlarmQuantity_${loop.index}"
										value="${goodsPrint.minAlarmQuantity}" name="minAlarmQuantity"
										style="width: 70px; margin-right: 5px; vertical-align: middle;" />
								</div>
							</td>
							<td align="center" style="white-space: nowrap;">${goodsPrint.pdName}</td>
							<td align="center" style="white-space: nowrap;">${goodsPrint.pdPhone}</td>
							<td align="center" style="white-space: nowrap;">${goodsPrint.nation}</td>
						</tr>
					</c:forEach>
			</table>
		</form>
	</div>
<div class="searchdiv">
		<form action="gsearch.do" method="get">
			<input type="hidden" id = "id" name="id" value="${ loginUser.id }">
			<select style="height: 35px; width: 80px;" name="action"
				id="searchselect">
				<option value="goodsName">상품명</option>
				<option value="pdName">발주처</option>
			</select>  
			<input style="height: 30px; width: 325px;"
				type="text" id="searchtext" name="keyword" placeholder="검색어 입력">
			<input type="submit" class="searchbtn" value="검색">
			
			<c:forEach items="${goodsList}" var="goodsPrint">
				<input type="checkbox" class="chkCheckBoxId checkbox"
					value="${goodsPrint.goodsNo}">
			</c:forEach>			
			</form>	
		<div>
			<button class="savebutton" onclick="updateSelectedGoods();">저장</button>			
			<button class="deletebutton"onclick="deleteSelectedGoods();">삭제</button>
		</div>
		
</div>
			

<c:import url="/WEB-INF/views/common/pagingView.jsp" />

<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>