<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>캘린더 API 사용 페이지</title>
<link href="${pageContext.request.contextPath}/resources/fullcalendar-5.1.0/lib/main.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/fullcalendar-5.1.0/lib/main.js"></script>
<style>
#calendar {
    width: 60%;
    margin: 20px auto;
}
</style>

</head>
<body>
<form id="calendarForm">
    <label for="googleCalendarId">구글 캘린더 ID:</label>
    <input type="text" id="googleCalendarId" name="googleCalendarId">
    <button type="submit">캘린더 표시</button>
</form>
<div id="calendar"></div>
<c:import url="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
