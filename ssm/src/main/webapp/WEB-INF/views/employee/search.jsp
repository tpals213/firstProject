<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 검색</title>
</head>
<body>

<h2>사용자 검색</h2>
<form action="searchUser.do" method="post">
    <label for="keyword">검색어:</label>
    <input type="text" id="keyword" name="keyword"><br>
    
    <label for="age">나이:</label>
    <input type="number" id="age" name="age"><br>
    
    <label for="begin">가입 시작 날짜:</label>
    <input type="date" id="begin" name="begin"><br>
    
    <label for="end">가입 종료 날짜:</label>
    <input type="date" id="end" name="end"><br>
    
    <label for="id">사용자 ID:</label>
    <input type="text" id="id" name="id"><br>
    
    <input type="submit" value="검색">
</form>

</body>
</html>
