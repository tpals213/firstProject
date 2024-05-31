<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      
    </script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<title>ssm</title>
<link rel="stylesheet" href="resources/css/common/main.css" />
<%-- jquery 파일 로드 --%>
<script type="text/javascript"
	src="/ssm/resources/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript"
	src="/ssm/resources/js/main/main.js"></script>



</head>
<body>
	<div id="wrap">
		<%-- header --%>
		<c:import url="/WEB-INF/views/common/header.jsp" />
		<c:import url="/WEB-INF/views/common/noticebanner.jsp" />
		<c:if test="${ empty sessionScope.loginUser }">
			<%-- section 로그인 안한 경우--%>
			<div class="section-container n-login">
				<%-- section1 --%>
				<section class="sec1">
					<div class="inner-section">
						<div class="img-box">
							<img alt="메인 이미지" src="${pageContext.servletContext.contextPath }/resources/images/main/main1.png">
						</div>
						<div class="description">
							<p>모든 기능을 월 2만원으로</p>
							<div class="description-botton">
								<p>기업에 필요한 모든 기능을 제공하는</p>
								<p>100% 웹기반 ERP 시스템</p>
							</div>
						</div>
					</div>
				</section>
				<%-- section2 --%>
				<section class="sec2">
					<div class="inner-section">
						<div class="left-section">
							<div class="img-box">
								<img alt="메인 이미지2" src="${pageContext.servletContext.contextPath }/resources/images/main/main2.png">
							</div>
						</div>
						<div class="right-section">
							<div class="description">
								<p>쉽게 사용하고 즉시 확인하세요</p>
								<div class="description-botton">
									<p>메뉴를 한눈에 보기 쉽게 사용할 수 있습니다.</p>
									<p>필요한 메뉴만 골라서 사용하세요</p>
								</div>
							</div>
						</div>
					</div>
				</section>
				<%-- section3 --%>
				<section class="sec3">
					<div class="inner-section">
						<div class="left-section">
							<div class="description">
								<p>누적 50000개 기업 돌파</p>
								<div class="description-botton">
									<p>오늘 하루만 3000개의 기업이</p>
									<p>SSM을 사용 중 입니다.</p>
								</div>
							</div>
						</div>
						<div class="right-section">
							<div class="img-box">
								<img alt="메인 이미지3" src="${pageContext.servletContext.contextPath }/resources/images/main/main3.png">
							</div>
						</div>
						</div>
						<%-- section4 --%>
						<section class="sec4">
							<div class="inner-section">
								<div class="left-section">
									<div class="img-flex">
										<div class="img-box">
											<img alt="메인 이미지 4-1" src="${pageContext.servletContext.contextPath }/resources/images/main/main4_1.png">
										</div>
										<div class="img-box">
											<img alt="메인 이미지 4-2" src="${pageContext.servletContext.contextPath }/resources/images/main/main4_2.png">
										</div>
										<div class="img-box">
											<img alt="메인 이미지 4-3" src="${pageContext.servletContext.contextPath }/resources/images/main/main4_3.png">
										</div>
										<div class="img-box padding-top">
											<img alt="메인 이미지 4-4" src="${pageContext.servletContext.contextPath }/resources/images/main/main4_4.png">
										</div>
										<div class="img-box padding-top">
											<img alt="메인 이미지 4-5" src="${pageContext.servletContext.contextPath }/resources/images/main/main4_5.png">
										</div>
										<div class="img-box padding-top">
											<img alt="메인 이미지 4-6" src="${pageContext.servletContext.contextPath }/resources/images/main/main4_6.png">
										</div>
									</div>
								</div>
								<div class="right-section">
									<div class="description">
										<p>다양한 편의 기능 제공</p>
										<div class="description-botton">
											<p>SSM은 다른 부가 프로그램을</p>
											<p>사용할 필요 없이</p>
											<p>다양한 편의 기능을 사용할 수 있습니다.</p>
										</div>
									</div>
								</div>
							</div>
						</section>
					</div>
				</section>
				
			</div>
		</c:if>
		<%-- 유저 로그인한 경우--%>
		<c:if test="${ !empty loginUser &&  loginUser.adminOk ne 'Y'}">
			<div class="section-container">
				<%-- section1 --%>
				<section class="sec1">
				<div align="center" class="padding-top selectBox">
					<select style="height: 35px; width: 80px;" 
				id="monthSelect" onchange="onChangeMonth()">
					<option value="2024-01">2024-01</option>
				    <option value="2024-02">2024-02</option>
				    <option value="2024-03">2024-03</option>
				    <option value="2024-04">2024-04</option>
				    <option value="2024-05">2024-05</option>
				    <option value="2024-06">2024-06</option>
				    <option value="2024-07">2024-07</option>
				    <option value="2024-08">2024-08</option>
				    <option value="2024-09">2024-09</option>
				    <option value="2024-10">2024-10</option>
				    <option value="2024-11">2024-11</option>
				    <option value="2024-12">2024-12</option>
				</select> 
				</div>				
					<div class="inner-section" style="height: 400px;">
						<div class="left-section" style="height: 400px;">
							<table id="myTable" class="monthlySale"border="1" width="80%" style="height: 400px;">
								<tr style="height: 10px;">
									<th style="text-align: center; white-space: nowrap;">항목</th>
									<th>금액</th>
								</tr>
								<tr>
									<td>월 매출</td>
									<td style="text-align: center; white-space: nowrap;">
											<span id="monthlySales" ></span>
									</td>
								</tr>
								<tr>
									<td  style="white-space: nowrap;">월 발주 금액</td>
				    				<td  style="white-space: nowrap;">						
										<span id="monthlyPdPrice" ></span>						
									</td>
								</tr>	
								
								<tr>
									<td  style="white-space: nowrap;">월세</td>
									<td  style="white-space: nowrap;">
										<span id="monthlyRent" ></span>
									</td>
								</tr>	
								<tr>
									<td  style="white-space: nowrap;">세금</td>
									<td  style="white-space: nowrap;">
										<span id="monthlyTax" ></span>
									</td>
								</tr>		
								<tr>
									<td style="white-space: nowrap;">기타비용</td>
									<td  style="white-space: nowrap;">
										<span id="monthlyCost" ></span>
									</td>
								</tr>	
								<tr>
									<td style="white-space: nowrap;">수익</td>
									<td  style="white-space: nowrap;">
										<span id="profit" ></span>
									</td>
								</tr>				
								
							</table>
						</div>
						<div id="idDisplay" style="display:none;">${ loginUser.id }</div>
						<div class="right-section" id="chart_div_sale" style="height: 400px;">그래프</div>
					</div>
				</section>
				<%-- section2 --%>
				<section class="sec2">
					<div class="inner-section">
						<div class="left-section">
						<div class="title"><p class="title">문의 내역</p></div>
						<table id="inconvinienceUser" class="inconvinience">
							<tr class="titlerow">
								<th>제목</th>
								<th>조치상태</th>
							</tr>
						</table>
						<input type="hidden" id="loginUserId" value="${loginUser.id}">
						</div>
						<div class="right-section">
							<c:import url="/WEB-INF/views/reserve/reservecalendarmain.jsp" />
							<script type="text/javascript" defer>
								$(()=> {
									$("header").css("position", "fixed");	
								});
							</script>
						</div>
					</div>
				</section>
			</div>
		</c:if>
						
		<%-- 관리자 로그인한 경우--%>
		<c:if test="${ !empty loginUser &&  loginUser.adminOk eq 'Y'}">
			<div class="section-container">
				<%-- section1 --%>
				<section class="sec1">
					<div class="inner-section">
						<div>
							<button id="leftButton">&lt;</button>
						</div>
						<div id="chart_div" class="left-section"></div>
						<div id="chart_div2" class="right-section"></div>
						<div>
							<button id="rightButton">&gt;</button>
						</div>
					</div>
				</section>
				<%-- section2 --%>
				<section class="sec2">
					<div class="inner-section-incon">
					<p class="title">조치사항</p>
						<table id="inconvinienceAdmin" class="inconvinience">
							<tr class="titlerow">
								<th>제목</th>
								<th>작성자</th>
								<th>조치상태</th>
							</tr>
						</table>
					</div>
				</section>
			</div>
		</c:if>
		<%-- footer --%>
		<c:import url="footer.jsp" />
	</div>
</body>

</html>