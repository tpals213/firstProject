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
		right: 250px;
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
		right: 470px;
	}
	.searchdiv>button.deletebutton {
		position: absolute;
		right: 400px;
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


</head>
<body>
<c:import url="/WEB-INF/views/common/header.jsp" />
<div style="padding-top : 100px;">
<hr>
<br>
<c:import url="/WEB-INF/views/common/sidebar.jsp" /> 
<h1 style="text-align: center;">발주처 현황</h1>

<script type="text/javascript">
$('#checkBoxAll').click(function () {
    if ($(this).is(":checked")) {
      $(".chkCheckBoxId").prop("checked", true)
    }else{
      $(".chkCheckBoxId").prop("checked", false)
    }
  });
</script>



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
                pdPhone: document.getElementById('pdPhone_' + rowIndex).value,
                pdAddress: document.getElementById('pdAddress_' + rowIndex).value,
                goodsUnit: document.getElementById('goodsUnit_' + rowIndex).value,
                nation: document.getElementById('nation_' + rowIndex).value
            };
            updatedGoods.push(rowData);
        });

        // 알림 대화 상자 표시
        var confirmMessage = "변경된 내용을 저장 하시겠습니까?";
        if (confirm(confirmMessage)) {
            // 변경된 내용을 서버로 전송
            $.ajax({
                type: "POST",
                url: "pupdate.do",
                data: JSON.stringify(updatedGoods),
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
            alert.log("수정이 취소되었습니다.");
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
        	 jarr.push(job
        			 );
        });
          
        var confirmMessage = "선택한 발주처를 삭제하시겠습니까?";
        if (confirm(confirmMessage)) {
            $.ajax({
                type: "POST",
                url: "pdelete.do",
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
            alert.log("삭제가 취소되었습니다.");
        }
    }
</script>	
		

	<%-- 조회된 상품 목록 출력 --%>
<div style="margin-left: auto; margin-right: auto; width: 1400px;">
	<div class="listdiv">
	<button class="listbtn" onclick="javascript:location.href='${pageContext.servletContext.contextPath}/plist.do?page=1&id=${loginUser.id}';">목록</button>
	</div>
    <form action="psearch.do" method="post">
        <table align="center" border="1" cellspacing="25" width="100%">
        	<thead>
            	<th class="table-head"><input type="checkbox" id="checkBoxAll"></th>
                <th style="text-align: center; white-space: nowrap;">발주처</th>
                <th style="text-align: center; white-space: nowrap;">연락처</th>
                <th style="text-align: center; white-space: nowrap;">주소</th>
                <th style="text-align: center; white-space: nowrap;">상품명</th>
                <th style="text-align: center; white-space: nowrap;">가격</th>
                <th style="text-align: center; white-space: nowrap;">단위</th>
                <th style="text-align: center; white-space: nowrap;">원산지</th>
            </tr>
            <thead>
            <c:forEach items="${requestScope.list}" var="goodsPrint" varStatus="loop">
                <tr>               	
                	<td class="table-data">
                		<input type="checkbox" class="chkCheckBoxId checkbox" value="${goodsPrint.goodsNo}">
                	</td>
                	<td align="center" style="white-space: nowrap;">${ goodsPrint.pdName }</td>
                    <td align="center" style="white-space: nowrap;">
						<div style="display: inline-block;">
							<input type="text" id="pdPhone_${loop.index}"
										value="${goodsPrint.pdPhone}" name="pdPhone"
										style="width: 100px; margin-right: 0px; vertical-align: middle;" />
						</div>
					</td>
                	<td align="center" style="white-space: nowrap;">
						<div style="display: inline-block;">
							<input type="text" id="pdAddress_${loop.index}"
										value="${goodsPrint.pdAddress}" name="pdAddress"
										style="width: 250px; margin-right: 0px; vertical-align: middle;" />
						</div>
					</td>
                    <td align="center" style="white-space: nowrap;">${ goodsPrint.goodsName }</td>
                    <td align="center" style="white-space: nowrap;">${ goodsPrint.goodsPrice }</td>
                    <td align="center" style="white-space: nowrap;">
						<div style="display: inline-block;">
							<input type="text" id="goodsUnit_${loop.index}"
										value="${goodsPrint.goodsUnit}" name="goodsUnit"
										style="width: 70px; margin-right: 0px; vertical-align: middle;" />
						</div>
					</td>        
                    <td align="center" style="white-space: nowrap;">
						<div style="display: inline-block;">
							<input type="text" id="nation_${loop.index}"
										value="${goodsPrint.nation}" name="nation"
										style="width: 70px; margin-right: 0px; vertical-align: middle;" />
						</div>
					</td>       
                </tr>
            </c:forEach>
        </table>
    </form>
</div>
<div class="searchdiv">
		<form action="psearch.do" method="get">
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
		
<button onclick="updateSelectedGoods();">저장</button>			
<button onclick="deleteSelectedGoods();">삭제</button>

</div>

<c:import url="/WEB-INF/views/common/pagingView.jsp" />

<hr>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</div>
</body>
</html>