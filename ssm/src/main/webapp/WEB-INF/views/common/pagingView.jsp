<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ page import="javax.servlet.http.HttpSession" %>

<%
	HttpSession currentSession = request.getSession(false);
	boolean isLoggedIn = (currentSession != null && currentSession.getAttribute("loginUser") != null);
%>
<%-- 페이지 표시에 사용될 값들을 변수 선언 --%>
<c:set var="currentPage" value="${ requestScope.paging.currentPage }" />
<c:set var="urlMapping" value="${ requestScope.paging.urlMapping }" />
<c:set var="startPage" value="${ requestScope.paging.startPage }" />
<c:set var="endPage" value="${ requestScope.paging.endPage }" />
<c:set var="maxPage" value="${ requestScope.paging.maxPage }" />
<c:set var="id" value="${ requestScope.loginUser.id }" />

<c:set var="action" value="${ requestScope.action }" />
<c:set var="keyword" value="${ requestScope.keyword }" />
<c:set var="begin" value="${ requestScope.begin }" />
<c:set var="end" value="${ requestScope.end }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

<%-- 로그인 했을 때 --%>
<div>
    <c:if test="<%= isLoggedIn %>">
        <input type="hidden" name="id" value="${loginUser.id}">
        
        <c:if test="${ empty action and empty keyword}">
<div style="text-align:center;">
	<%-- 첫 페이지로 이동 --%>	
	<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>	
	<c:if test="${ currentPage gt 1 }">
		<a href="/ssm/${ urlMapping }?page=1&id=${loginUser.id}">[맨처음]</a> &nbsp;
	</c:if>
	
	<%-- 이전 페이지 그룹으로 이동 --%>
	<%-- 이전그룹이 있다면 --%>
	<c:if test="${ (currentPage - 10) lt startPage and (currentPage - 10) gt 1 }">
		<a href="/ssm/${ urlMapping }?page=${ startPage - 10 }&id=${loginUser.id}">[이전그룹]</a> &nbsp;
	</c:if>	
	<%-- 이전그룹이 없다면 --%>
	<c:if test="${ !((currentPage - 10) lt startPage and (currentPage - 10) gt 1) }">
		[이전그룹] &nbsp;
	</c:if>	
	
	<%-- 현재 페이지가 속한 페이지그룹 페이지 숫자 출력 --%>	
	<c:forEach begin="${ startPage }" end="${ endPage }" step="1" var="p">
		<c:if test="${ p eq currentPage }">
			<font color="blue" size="4"><b>${ p }</b></font>
		</c:if>	
		<c:if test="${ p ne currentPage }">
			<a href="/ssm/${ urlMapping }?page=${ p }&id=${loginUser.id}">${ p }</a>
		</c:if>
	</c:forEach>
	
	
	<%-- 다음 페이지 그룹으로 이동 --%>
	<%-- 다음그룹이 있다면 --%>
	<c:if test="${ (currentPage + 10) gt startPage and (currentPage + 10) lt maxPage }">
		<a href="/ssm/${ urlMapping }?page=${ startPage + 10 }&id=${loginUser.id}">[다음그룹]</a> &nbsp;
	</c:if>
	<%--다음그룹이 없다면 --%>
	<c:if test="${ !((currentPage + 10) gt startPage and (currentPage + 10) lt maxPage) }">
		[다음그룹] &nbsp;
	</c:if>
	
	<%-- 맨끝 페이지로 이동 --%>
	<c:if test="${ currentPage >= maxPage }">
		[맨끝] &nbsp;
	</c:if>
	<c:if test="${ !(currentPage >= maxPage) }">
		<a href="/ssm/${ urlMapping }?page=${ maxPage }&id=${loginUser.id}">[맨끝]</a> &nbsp;
	</c:if>
</div>
</c:if>


<%-- 검색(제목, 작성자, 내용) 페이징 처리 --%>

<div style="text-align:center;">
	<c:if test="${ not empty action and not empty keyword}">
	<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>	
	<c:if test="${ currentPage gt 1 }">
		<a href="/ssm/${ urlMapping }?page=1&action=${ action }&keyword=${ keyword }&id=${loginUser.id}">[맨처음]</a> &nbsp;
	</c:if>
	
	<%-- 이전 페이지 그룹으로 이동 --%>
	<%-- 이전그룹이 있다면 --%>
	<c:if test="${ (currentPage - 10) lt startPage and (currentPage - 10) gt 1 }">
		<c:url var="um1" value="${ urlMapping }">
			<c:param name="page" value="${ startPage - 10 }" />
			<c:param name="action" value="${ action }" />
			<c:param name="keyword" value="${ keyword }" />
		</c:url>
		<a href="${ um1 }&id=${loginUser.id}">[이전그룹]</a> &nbsp;
	</c:if>
	<%-- 이전그룹이 없다면 --%>
	<c:if test="${ !((currentPage - 10) lt startPage and (currentPage - 10) gt 1) }">
		[이전그룹] &nbsp;
	</c:if>	
	
	<%-- 현재 페이지가 속한 페이지그룹 숫자 출력 --%>	
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<font color="blue" size="4"><b>${ p }</b></font>
		</c:if>	
		<c:if test="${ p ne currentPage }">
			<a href="/ssm/${ urlMapping }?page=${ p }&action=${ action }&keyword=${ keyword }&id=${loginUser.id}">${ p }</a>
		</c:if>
	</c:forEach>	
	
	<%-- 다음 페이지 그룹으로 이동 --%>
	<%-- 다음그룹이 있다면 --%>
	<c:if test="${ (currentPage + 10) > endPage && (currentPage + 10) < maxPage }">
		<a href="/ssm/${ urlMapping }?page=${ startPage + 10 }&action=${ action }&keyword=${ keyword }&id=${loginUser.id}">[다음그룹]</a> &nbsp;
	</c:if>
	<%-- 다음그룹이 없다면 --%>
	<c:if test="${ !((currentPage + 10) > endPage && (currentPage + 10) < maxPage) }">
		[다음그룹] &nbsp;
	</c:if>		
	
	<c:if test="${ currentPage >= maxPage }">
		[맨끝] &nbsp;
	</c:if>	
	<c:if test="${ currentPage < maxPage }">
		<a href="/ssm/${ urlMapping }?page=${ maxPage }&action=${ action }&keyword=${ keyword }&id=${loginUser.id}">[맨끝]</a> &nbsp;
	</c:if>
	</c:if>
</div>


<%-- 검색(등록날짜) 페이징 처리 --%>
<c:if test="${ !empty action and action eq 'date' or action eq 'enrolldate' }">
<div style="text-align:center;">
	
	<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>	
	<c:if test="${ currentPage gt 1 }">
		<a href="/ssm/${ urlMapping }?page=1&action=${ action }&begin=${ begin }&end=${ end }&id=${loginUser.id}">[맨처음]</a> &nbsp;
	</c:if>
	
	<%-- 이전 페이지 그룹으로 이동 --%>
	<%-- 이전그룹이 있다면 --%>
	<c:if test="${ (currentPage - 10) < startPage && (currentPage - 10) > 1 }">
		<a href="/ssm/${ urlMapping }?page=${ startPage - 10 }&action=${ action }&begin=${ begin }&end=${ end }&id=${loginUser.id}">[이전그룹]</a> &nbsp;
	</c:if>
	<%-- 이전그룹이 없다면 --%>
	<c:if test="${ !((currentPage - 10) < startPage && (currentPage - 10) > 1) }">
		[이전그룹] &nbsp;
	</c:if>	
	
	<%-- 현재 페이지가 속한 페이지그룹 숫자 출력 --%>	
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<font color="blue" size="4"><b>${ p }</b></font>
		</c:if>	
		<c:if test="${ p ne currentPage }">
			<a href="/ssm/${ urlMapping }?page=${ p }&action=${ action }&begin=${ begin }&end=${ end }&id=${loginUser.id}">${ p }</a>
		</c:if>	
	</c:forEach>
	
	<%-- 다음 페이지 그룹으로 이동 --%>
	<%-- 다음그룹이 있다면 --%>
	<c:if test="${ (currentPage + 10) > endPage && (currentPage + 10) < maxPage }">
		<a href="/ssm/${ urlMapping }?page=${ startPage + 10 }&id=${loginUser.id}">[다음그룹]</a> &nbsp;
	</c:if>
	<%-- 다음그룹이 없다면 --%>
	<c:if test="${ !((currentPage + 10) > endPage && (currentPage + 10) < maxPage) }">
		[다음그룹] &nbsp;
	</c:if>	
	
	<%-- 맨끝 페이지로 이동 --%>
	<c:if test="${ currentPage >= maxPage }">
		[맨끝] &nbsp;
	</c:if>	
	<c:if test="${ currentPage < maxPage }">
		<a href="/ssm/${ urlMapping }?page=${ maxPage }&action=${ action }&begin=${ begin }&end=${ end }&id=${loginUser.id}">[맨끝]</a> &nbsp;
	</c:if>
	
</div>
</c:if>
        
        
        
        
        
    </c:if>
</div>


<%-- 로그인 했을 때 --%>




<%-- 로그인 안 했을 때 --%>
 <c:if test="<%= !isLoggedIn %>">
<%-- 목록 페이징 처리 : 검색 목록이 아닌 경우 --%>
<c:if test="${ empty action }">
<div style="text-align:center;">
	<%-- 첫 페이지로 이동 --%>	
	<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>	
	<c:if test="${ currentPage gt 1 }">
		<a href="/ssm/${ urlMapping }?page=1">[맨처음]</a> &nbsp;
	</c:if>
	
	<%-- 이전 페이지 그룹으로 이동 --%>
	<%-- 이전그룹이 있다면 --%>
	<c:if test="${ (currentPage - 10) lt startPage and (currentPage - 10) gt 1 }">
		<a href="/ssm/${ urlMapping }?page=${ startPage - 10 }">[이전그룹]</a> &nbsp;
	</c:if>	
	<%-- 이전그룹이 없다면 --%>
	<c:if test="${ !((currentPage - 10) lt startPage and (currentPage - 10) gt 1) }">
		[이전그룹] &nbsp;
	</c:if>	
	
	<%-- 현재 페이지가 속한 페이지그룹 페이지 숫자 출력 --%>	
	<c:forEach begin="${ startPage }" end="${ endPage }" step="1" var="p">
		<c:if test="${ p eq currentPage }">
			<font color="blue" size="4"><b>${ p }</b></font>
		</c:if>	
		<c:if test="${ p ne currentPage }">
			<a href="/ssm/${ urlMapping }?page=${ p }">${ p }</a>
		</c:if>
	</c:forEach>
	
	
	<%-- 다음 페이지 그룹으로 이동 --%>
	<%-- 다음그룹이 있다면 --%>
	<c:if test="${ (currentPage + 10) gt startPage and (currentPage + 10) lt maxPage }">
		<a href="/ssm/${ urlMapping }?page=${ startPage + 10 }">[다음그룹]</a> &nbsp;
	</c:if>
	<%--다음그룹이 없다면 --%>
	<c:if test="${ !((currentPage + 10) gt startPage and (currentPage + 10) lt maxPage) }">
		[다음그룹] &nbsp;
	</c:if>
	
	<%-- 맨끝 페이지로 이동 --%>
	<c:if test="${ currentPage >= maxPage }">
		[맨끝] &nbsp;
	</c:if>
	<c:if test="${ !(currentPage >= maxPage) }">
		<a href="/ssm/${ urlMapping }?page=${ maxPage }">[맨끝]</a> &nbsp;
	</c:if>
</div>
</c:if>


<%-- 검색(제목, 작성자, 내용) 페이징 처리 --%>
<c:if test="${ !empty action and !empty keyword }">
<div style="text-align:center;">
	
	<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>	
	<c:if test="${ currentPage gt 1 }">
		<a href="/ssm/${ urlMapping }?page=1&action=${ action }&keyword=${ keyword }">[맨처음]</a> &nbsp;
	</c:if>
	
	<%-- 이전 페이지 그룹으로 이동 --%>
	<%-- 이전그룹이 있다면 --%>
	<c:if test="${ (currentPage - 10) lt startPage and (currentPage - 10) gt 1 }">
		<c:url var="um1" value="${ urlMapping }">
			<c:param name="page" value="${ startPage - 10 }" />
			<c:param name="action" value="${ action }" />
			<c:param name="keyword" value="${ keyword }" />
		</c:url>
		<a href="${ um1 }">[이전그룹]</a> &nbsp;
	</c:if>
	<%-- 이전그룹이 없다면 --%>
	<c:if test="${ !((currentPage - 10) lt startPage and (currentPage - 10) gt 1) }">
		[이전그룹] &nbsp;
	</c:if>	
	
	<%-- 현재 페이지가 속한 페이지그룹 숫자 출력 --%>	
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<font color="blue" size="4"><b>${ p }</b></font>
		</c:if>	
		<c:if test="${ p ne currentPage }">
			<a href="/ssm/${ urlMapping }?page=${ p }&action=${ action }&keyword=${ keyword }">${ p }</a>
		</c:if>
	</c:forEach>	
	
	<%-- 다음 페이지 그룹으로 이동 --%>
	<%-- 다음그룹이 있다면 --%>
	<c:if test="${ (currentPage + 10) > endPage && (currentPage + 10) < maxPage }">
		<a href="/ssm/${ urlMapping }?page=${ startPage + 10 }&action=${ action }&keyword=${ keyword }">[다음그룹]</a> &nbsp;
	</c:if>
	<%-- 다음그룹이 없다면 --%>
	<c:if test="${ !((currentPage + 10) > endPage && (currentPage + 10) < maxPage) }">
		[다음그룹] &nbsp;
	</c:if>		
	
	<c:if test="${ currentPage >= maxPage }">
		[맨끝] &nbsp;
	</c:if>	
	<c:if test="${ currentPage < maxPage }">
		<a href="/ssm/${ urlMapping }?page=${ maxPage }&action=${ action }&keyword=${ keyword }">[맨끝]</a> &nbsp;
	</c:if>
	
</div>
</c:if>

<%-- 검색(등록날짜) 페이징 처리 --%>
<c:if test="${ !empty action and action eq 'date' or action eq 'enrolldate' }">
<div style="text-align:center;">
	
	<c:if test="${ currentPage eq 1 }">
		[맨처음] &nbsp;
	</c:if>	
	<c:if test="${ currentPage gt 1 }">
		<a href="/ssm/${ urlMapping }?page=1&action=${ action }&begin=${ begin }&end=${ end }">[맨처음]</a> &nbsp;
	</c:if>
	
	<%-- 이전 페이지 그룹으로 이동 --%>
	<%-- 이전그룹이 있다면 --%>
	<c:if test="${ (currentPage - 10) < startPage && (currentPage - 10) > 1 }">
		<a href="/ssm/${ urlMapping }?page=${ startPage - 10 }&action=${ action }&begin=${ begin }&end=${ end }">[이전그룹]</a> &nbsp;
	</c:if>
	<%-- 이전그룹이 없다면 --%>
	<c:if test="${ !((currentPage - 10) < startPage && (currentPage - 10) > 1) }">
		[이전그룹] &nbsp;
	</c:if>	
	
	<%-- 현재 페이지가 속한 페이지그룹 숫자 출력 --%>	
	<c:forEach var="p" begin="${ startPage }" end="${ endPage }" step="1">
		<c:if test="${ p eq currentPage }">
			<font color="blue" size="4"><b>${ p }</b></font>
		</c:if>	
		<c:if test="${ p ne currentPage }">
			<a href="/ssm/${ urlMapping }?page=${ p }&action=${ action }&begin=${ begin }&end=${ end }">${ p }</a>
		</c:if>	
	</c:forEach>
	
	<%-- 다음 페이지 그룹으로 이동 --%>
	<%-- 다음그룹이 있다면 --%>
	<c:if test="${ (currentPage + 10) > endPage && (currentPage + 10) < maxPage }">
		<a href="/ssm/${ urlMapping }?page=${ startPage + 10 }">[다음그룹]</a> &nbsp;
	</c:if>
	<%-- 다음그룹이 없다면 --%>
	<c:if test="${ !((currentPage + 10) > endPage && (currentPage + 10) < maxPage) }">
		[다음그룹] &nbsp;
	</c:if>	
	
	<%-- 맨끝 페이지로 이동 --%>
	<c:if test="${ currentPage >= maxPage }">
		[맨끝] &nbsp;
	</c:if>	
	<c:if test="${ currentPage < maxPage }">
		<a href="/ssm/${ urlMapping }?page=${ maxPage }&action=${ action }&begin=${ begin }&end=${ end }">[맨끝]</a> &nbsp;
	</c:if>
	
</div>
</c:if>
</c:if>
</body>
</html>