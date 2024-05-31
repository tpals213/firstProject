<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오 친구 목록가져오기 api</title>
<style type="text/css" src="https://developers.kakao.com/sdk/js/kakao.min.js"></style>
</head>
<body>
<script type="text/javascript">
Kakao.API.request({
	  url: '/v1/api/talk/profile',
	})
	  .then(function(response) {
	    console.log(response);
	  })
	  .catch(function(error) {
	    console.log(error);
	  });
	  
	//팝업 방식
	Kakao.Picker.selectFriends({
	  title: '친구 선택',
	  maxPickableCount: 10,
	  minPickableCount: 1,
	})
	  .then(function(response) {
	    console.log(response);
	  })
	  .catch(function(error) {
	    console.log(error);
	  });	  
	  
	  
	//리다이렉트 방식
	//성공: ${returnUrl}?selected=${SelectedUsers}
	//실패: ${returnUrl}?error=${Error}
	Kakao.Picker.selectFriends({
	returnUrl: 'https://developers.kakao.com', // 필수
	title: '친구 선택',
	maxPickableCount: 10,
	minPickableCount: 1,
	});  
	  
</script>
</body>
</html>