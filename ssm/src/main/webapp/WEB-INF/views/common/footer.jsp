<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath }/resources/css/common/footer.css" />
<script src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
<script>
$(function() {
	$(function() {
		var ticker = function() {
			setTimeout(function() {
				$('#ticker2 li:first').animate(
						{
							marginTop : '40px'
						},
						550,
						function() {
							$(this).detach().appendTo('ul#ticker2')
									.removeAttr('style');
						});
				ticker();
			}, 3000);
		};
		ticker();
	});
	
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
			$('#ticker2').html(values);
		},
		error: function(jqXHR, textStatus, errorThrown){
			console.log("error : " + jqXHR + ", " + textStatus + ", " + errorThrown);
		}
	});
	
	
	
});

$(()=> {
	$("span#scrollTop").on("click", () => {
        window.scrollTo({ top: 0, behavior: 'smooth' });
        console.log("click!!");
	});
});
</script>
</head>
<body>
<footer>
 <div class="footer">
            <div class="inner-footer">
                <div class="footer-up">
                    <div class="footer-up-wrap">
                        <div class="footer-menu">
                            <ul>
                                <li><a href="${pageContext.servletContext.contextPath }/goReady.do">서비스 이용약관</a></li>
                                <li class="black"><a href="${pageContext.servletContext.contextPath }/goReady.do">개인정보처리방침</a></li>
                                <li><a href="${pageContext.servletContext.contextPath }/goReady.do">영상정보처리기기운영·관리방침</a></li>
                                <li><a href="${pageContext.servletContext.contextPath }/goReady.do">이메일 무단수집 거부</a></li>
                                <li><a href="${pageContext.servletContext.contextPath }/goReady.do">전자공고</a></li>
                                <li><a href="${pageContext.servletContext.contextPath }/goGoogleMap.do">매장안내</a></li>
                                <li><a href="#">고객센터</a></li>
                            </ul>
                        </div>
                        <div class="familySite-con">
                            
                        </div>
                    </div>
                </div>
                <div class="footer-down">
                    <div class="footer-down-con">
                        <div class="adress">
                            <p>SSM | 대표이사 : 남길현, 한지웅, 장세민, 김유리, 김시온, 문승종 </p>
                            <p>서울특별시 서초구 서초대로77길 41, 4층 (서초동, 대동Ⅱ)</p>
                            <p>사업자등록번호 : 123-45-67890 | 개인정보보호책임자 : 문승종</p>
                            <p>고객상담 1234-5678(사이트) | 123-456-789(제품 및 매장외)</p>
                        </div>
                        <div class="footer-issue">
                            <div class="issue-box">
                                <p class="issue">공지사항</p>
                                <div class="sec-con">
									<div class="block2">
											<ul id="ticker2">
											</ul>
										</div>
								</div>
                            </div>
                            <ul class="sns">
                                <li><a href="#"></a></li>
                                <li><a href="#"></a></li>
                                <li><a href="#"></a></li>
                            </ul>
                        </div>
                        <div class="footer-more">
                        	<span id="scrollTop">위로</span>
                        </div>
                    </div>
                    <div class="copyright">
                        <p>
                            © copyright@ict.org &nbsp; 지능형 도우미 서비스 융합 웹 개발자과정
                        </p>
                        <div class="w3c">
                            <!-- <p>
                                <a href="http://validator.kldp.org/check?uri=referer"
                                  onclick="this.href=this.href.replace(/referer$/,encodeURIComponent(document.URL))"><img
                                  src="//validator.kldp.org/w3cimgs/validate/html5-blue.png" alt="Valid HTML 5" height="15" width="80"></a>
                              </p>
                            <p>
                                <a href="http://jigsaw.w3.org/css-validator/check/referer">
                                    <img style="border:0;width:88px;height:31px"
                                        src="http://jigsaw.w3.org/css-validator/images/vcss" alt="올바른 CSS입니다!" />
                                </a>
                            </p>
                            <p>
                                <a href="http://jigsaw.w3.org/css-validator/check/referer">
                                    <img style="border:0;width:88px;height:31px"
                                        src="http://jigsaw.w3.org/css-validator/images/vcss-blue" alt="올바른 CSS입니다!" />
                                </a>
                            </p> -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>
</body>
</html>