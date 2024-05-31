<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
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
	outline: dashed 1px black;
}

p.title {
	margin: 0 0 30px; /* 여백을 줄임 */
	font-size: 24px;
	font-weight: 600;
	color: #4e5968;
}

.table {
	margin-bottom: 30px; /* 테이블 아래 여백을 늘림 */
}

.tg {
	border-collapse: collapse;
	border-spacing: 0;
	width: 100%; /* 테이블 너비를 100%로 설정하여 가로폭에 맞춤 */
}

.tg td, .tg th {
	border-color: black;
	border-style: solid;
	border-width: 1px;
	font-family: Arial, sans-serif;
	font-size: 14px;
	overflow: hidden;
	padding: 10px 5px;
	word-break: normal;
}

.tg th {
	font-weight: bold;
}

.tg .tg-62nc {
	text-align: center; /* 중앙 정렬 */
	vertical-align: middle; /* 수직 정렬 */
}

.tg .tg-zci2 {
	background-color: #dae8fc;
	font-weight: bold;
	text-align: center; /* 중앙 정렬 */
	vertical-align: middle; /* 수직 정렬 */
}
</style>
</head>
<body>
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<c:import url="/WEB-INF/views/common/sidebar.jsp" />
	<div class="container" style="text-align:center; width:1000px;">
		<p class="title">급여 명세서</p>
		<div class="table">
		<table class="tg">
<thead>
  <tr>
    <th class="tg-62nc" style="background-color: #dae8fc;">성명</th>
    <th class="tg-0lax" colspan="2"></th>
    <th class="tg-62nc" style="background-color: #dae8fc;">부서/직위</th>
    <th class="tg-0lax" colspan="3"></th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-62nc"  style="background-color: #dae8fc;">소득구분</td>
    <td class="tg-0lax" colspan="2"></td>
    <td class="tg-62nc" style="background-color: #dae8fc;">급여기간</td>
    <td class="tg-0lax" colspan="3"></td>
  </tr>
  <tr>
    <td class="tg-62nc" style="background-color: #dae8fc;">비고</td>
    <td class="tg-0lax" colspan="6"></td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="7"></td>
  </tr>
  <tr>
    <td class="tg-62nc" colspan="2" style="background-color: #dae8fc;">지급합계</td>
    <td class="tg-62nc" colspan="2" style="background-color: #dae8fc;"></td>
    <td class="tg-62nc" colspan="3" style="background-color: #dae8fc;">실지급액</td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="2"></td>
    <td class="tg-0lax" colspan="2"></td>
    <td class="tg-0lax" colspan="3"></td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="7"></td>
  </tr>
  <tr>
    <td class="tg-62nc" rowspan="4" style="background-color: #dae8fc;">급여내역</td>
    <td class="tg-zci2" style="background-color: #dae8fc;">기본급</td>
    <td class="tg-w747" style="background-color: #dae8fc;"></td>
    <td class="tg-w747" style="background-color: #dae8fc;"></td>
    <td class="tg-w747" style="background-color: #dae8fc;"></td>
    <td class="tg-w747" style="background-color: #dae8fc;"></td>
    <td class="tg-w747" style="background-color: #dae8fc;"></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
  </tr>
  <tr>
    <td class="tg-w747"></td>
    <td class="tg-w747"></td>
    <td class="tg-w747"></td>
    <td class="tg-w747"></td>
    <td class="tg-w747"></td>
    <td class="tg-w747"></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
  </tr>
  <tr>
    <td class="tg-0lax" colspan="7"></td>
  </tr>
  <tr>
    <td class="tg-62nc" rowspan="4" style="background-color: #dae8fc;">공제내역</td>
    <td class="tg-zci2" style="background-color: #dae8fc;">국민연금</td>
    <td class="tg-zci2" style="background-color: #dae8fc;">건강보험</td>
    <td class="tg-zci2" style="background-color: #dae8fc;">장기요양보험</td>
    <td class="tg-zci2" style="background-color: #dae8fc;">소득세</td>
    <td class="tg-zci2" style="background-color: #dae8fc;">지방소득세</td>
    <td class="tg-w747" style="background-color: #dae8fc;"></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
  </tr>
  <tr>
    <td class="tg-w747"></td>
    <td class="tg-w747"></td>
    <td class="tg-w747"></td>
    <td class="tg-w747"></td>
    <td class="tg-w747"></td>
    <td class="tg-w747"></td>
  </tr>
  <tr>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
    <td class="tg-0lax"></td>
  </tr>
</tbody>
</table>
		</div>
		<p class="title">${loginUser.businessStoreName}</p>
		<p class="title">${loginUser.phone}</p>
		<p class="title">${loginUser.email}</p>
	</div><!-- container -->
	<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>