<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--
	팝업 연결 버튼 예시 
	<button type="submit"
		, onclick="window.open('http://localhost:8080/ssm/popup.do','_blank','width=350, height=150, top=150, left=50, scrollbars=no')">
		<a href="#pop_info_1" class="btn_open">저장</a>
	</button>

	컨트롤러
	@RequestMapping("ginsert.do")
	public String moveGoodsInsertPage() {
		return "goods/goodsInsert";
	}

 -->
<!DOCTYPE html>
<html>
<head>
</head>
<body>

	

	<div style="text-align: center;">
    <h3>저장하시겠습니까?</h3>
    <a href="#" style="margin-right: 10px;">확인</a>
    <a href="javascript:void(0);" onclick="closeWindow();">취소</a>
</div>
	<script>
		function closeWindow() {
			window.open('', '_self').close();
		}
	</script>


</body>
</html>


