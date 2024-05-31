<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
<script>
$(function() {
	$(function() {
		var ticker = function() {
			setTimeout(function() {
				$('#ticker li:first').animate(
						{
							marginTop : '40px'
						},
						550,
						function() {
							$(this).detach().appendTo('ul#ticker')
									.removeAttr('style');
						});
				ticker();
			}, 3000);
		};
		ticker();
	});
});
</script>
<script>
$(function(){
	//중요도 높은 공지사항 5개 롤링
	$.ajax({
		url: "ntop5.do",
		type: "post",
		dataType: "json",
		success: function(data){
			console.log("success : " + data);
			//object --> string
			var str = JSON.stringify(data);
			//string --> json
			var json = JSON.parse(str);
			values = "";			
			for(var i in json.nlist){
			values += "<li><a href='ndetail.do?nno=" + json.nlist[i].noticeNo+"'> 사장님들께 알립니다 ! "
					+ decodeURIComponent(json.nlist[i].noticeTitle).replace(/\+/gi, " ")
					+"</a></li>"}
			$('#ticker').html(values);
		},
		error: function(jqXHR, textStatus, errorThrown){
			console.log("error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
		}
	});
});
</script>
<style>
.block {
	padding-top: 110px;
	height: 40px;
	overflow: hidden;
	background: #fff;
	width: 400px;
	font-family: Gulim;
	font-size: 12px;
	text-align: center;
	margin: 0 auto;
}
.block ul {
	overflow: hidden;
}
.block ul, .block li {
	margin: 0;
	padding: 0;
	list-style: none;
	line-height: 40px;
}

.block li a {
	display: block;
	height: 40px;
	line-height: 40px;
	color: #222;
	text-decoration: none;
	font-size: 16px;
	font-weight: 600;
	font-family: sans-serif;
}
</style>
</head>
<body>
	<div class="block">
		<ul id="ticker">
		</ul>
	</div>
</body>
</html>

