<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/goods/goodsDetail.css" />
<title>Insert title here</title>
<style type="text/css">
	div.listdiv {
		height: 40px;
		width: 1300px;
		margin: 20px auto;
		display: flex;
		/* padding-left:400px; */
		justify-content: center;
		position: relative;
	}
	button.listbtn {
		position: absolute;
		right: 270px;
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
<script type="text/javascript"
	src="/ssm/resources/js/jquery-3.7.0.min.js"></script>


<script type="text/javascript">
	$(function() {
		//input 태그의 name 이 item 의 값이 바뀌면(change) 작동되는 이벤트 핸들러 작성
		$('input[name=item]').on('change', function() {
			//여러 개의 태그 중에서 체크표시가 된 태그를 선택
			$('input[name=item]').each(function(index) {
				//선택된 radio 순번대로 하나씩 checked 인지 확인함
				if ($(this).is(':checked')) {
					//체크 표시된 아이템에 대한 폼이 보여지게 처리함
					$('form.sform').eq(index).css('display', 'block');
				} else {
					//체크 표시 안된 아이템의 폼은 안 보이게 처리함
					$('form.sform').eq(index).css('display', 'none');
				}
			}); //each
		}); //on

		$('#checkBoxAll').click(function() {
			if ($(this).is(":checked")) {
				$(".chkCheckBoxId").prop("checked", true)
			} else {
				$(".chkCheckBoxId").prop("checked", false)
			}
		});
	}); //document ready
</script>

<script>
    function insertSelectedGoods() {
    	var jarr = new Array();

    	var checkedRows = document.querySelectorAll('.chkCheckBoxId:checked');
    	var id = $("#testid").val();
        
        // 변경된 내용을 저장할 배열
        var jarr = [];

        // 각 체크된 행에 대해
        checkedRows.forEach(function(row) {
            var rowIndex = row.closest('tr').rowIndex; // 첫 번째 행은 헤더이므로 -1
            var rowData = {
                id: $("#testid").val(), // loginUser.id 값 가져오기
                goodsName: document.getElementById('goodsName_' + rowIndex).value,
                goodsUnit: document.getElementById('goodsUnit_' + rowIndex).value,
                pdQuantity: document.getElementById('pdQuantity_' + rowIndex).value,               
                goodsPrice: document.getElementById('goodsPrice_' + rowIndex).value,
                minOrderQuantity: document.getElementById('minOrderQuantity_' + rowIndex).value,
                minAlarmQuantity: document.getElementById('minAlarmQuantity_' + rowIndex).value,
                pdName: document.getElementById('pdName_' + rowIndex).value,
                pdPhone: document.getElementById('pdPhone_' + rowIndex).value,
                nation: document.getElementById('nation_' + rowIndex).value,
            };
            jarr.push(rowData);
        });   
       
     // 알림 대화 상자 표시
        var confirmMessage = "등록 하시겠습니까?";
        if (confirm(confirmMessage)) {
            // 변경된 내용을 서버로 전송
            $.ajax({
                type: "POST",
                url: "ginsert.do",
                data: JSON.stringify(jarr),
                contentType: "application/json; charset=utf-8",
                success: function(result) {
                	alert("등록 성공")
                	var redirectUrl = "glist.do?page=1&id=${loginUser.id}";
                    // 지정된 URL로 이동
                    location.href = redirectUrl; 
                },
                error: function(request, status, errorData) {
                    console.log("error code : " + request.status
                        + "\nMessage : " + request.responseText
                        + "\nError : " + errorData);
                } 
            });  
        } else {
            alert("등록이 취소되었습니다.");
        }
        
    }
</script>

</head>
<body>
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<div style="padding-top : 100px;">
	<hr>
	<br>
	<c:import url="/WEB-INF/views/common/sidebar.jsp" /> 
	<h1 align="center">재고 등록</h1>

	

	<div style="margin-left: auto; margin-right: auto; width: 1400px;">	
		<div class="listdiv">
			<button class="listbtn" onclick="insertSelectedGoods();">등록</button>
		</div>
		<table align="center" border="1" cellspacing="25" width="100%"
			id="insertTable">
			<tr>
				<th class="table-head"><input type="checkbox" id="checkBoxAll"></th>
				<th style="text-align: center; white-space: nowrap;">상품명</th>
				<th style="text-align: center; white-space: nowrap;">수량</th>
				<th style="text-align: center; white-space: nowrap;">단위</th>
				<th style="text-align: center; white-space: nowrap;">가격</th>
				<th style="text-align: center; white-space: nowrap;">발주 최소 수량</th>
				<th style="text-align: center; white-space: nowrap;">알림 최소 수량</th>
				<th style="text-align: center; white-space: nowrap;">발주처</th>
				<th style="text-align: center; white-space: nowrap;">발주 연락처</th>
				<th style="text-align: center; white-space: nowrap;">원산지</th>
			</tr>
			<form action="ginsert.do" method="post" id="ginsert">
				<input type="hidden" id ="testid" name="id" value="${ loginUser.id }">
				<c:forEach begin="1" end="15" var="index">
					<tr>
						<td class="table-data"><input type="checkbox"
							class="chkCheckBoxId" value="${goodsPrint.goodsNo}"></td>
						<td align="center" style="white-space: nowrap;"><input
							type="text" maxlength="100" name="goodsName"
							id="goodsName_${index}" placeholder="필수입력"
							style="width: 50px; margin-right: 0px; vertical-align: middle;" />
						</td>
						<td align="center" style="white-space: nowrap;"><input
							type="number" name="pdQuantity" id="pdQuantity_${index}"
							placeholder="필수입력"
							style="width: 50px; margin-right: 0px; vertical-align: middle;" />
						</td>
						<td align="center" style="white-space: nowrap;"><input
							type="text" maxlength="10" name="goodsUnit"
							id="goodsUnit_${index}" value=""
							style="width: 50px; margin-right: 0px; vertical-align: middle;" />
						</td>
						<td align="center" style="white-space: nowrap;"><input
							type="number" maxlength="10" name="goodsPrice"
							id="goodsPrice_${index}" value="0" min="0"
							style="width: 50px; margin-right: 0px; vertical-align: middle;" />
						</td>
						<td align="center" style="white-space: nowrap;"><input
							type="number" name="minOrderQuantity"
							id="minOrderQuantity_${index}" value="0" min="0"
							style="width: 50px; margin-right: 0px; vertical-align: middle;" />
						</td>
						<td align="center" style="white-space: nowrap;"><input
							type="number" name="minAlarmQuantity"
							id="minAlarmQuantity_${index}" value="0" min="0"
							style="width: 50px; margin-right: 0px; vertical-align: middle;" />
						</td>
						<td align="center" style="white-space: nowrap;"><input
							type="text" maxlength="100" name="pdName" id="pdName_${index}"
							placeholder="필수입력"
							style="width: 50px; margin-right: 0px; vertical-align: middle;" />
						</td>
						<td align="center" style="white-space: nowrap;"><input
							type="text" maxlength="30" name="pdPhone" id="pdPhone_${index}"
							value=""
							style="width: 50px; margin-right: 0px; vertical-align: middle;" />
						</td>
						<td align="center" style="white-space: nowrap;"><input
							type="text" maxlength="10" name="nation" id="nation_${index}"
							value=""
							style="width: 50px; margin-right: 0px; vertical-align: middle;" />
						</td>
					</tr>
				</c:forEach>
			</form>
		</table>

	</div>



	<br>
	<hr>
	<c:import url="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>