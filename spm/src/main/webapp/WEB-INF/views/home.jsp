<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous">
	
</script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<style>
h1, #upNav {
	display: inline;
}

#upNav {
	float: right;
}
</style>
</head>
<body>
	<h1>쇼핑몰</h1>
	<div id="upNav">
		<c:if test="${member==null}">
		<a href="/member/join">회원가입</a> <a href="/member/login">로그인</a>
		</c:if>
		<c:if test="${member!=null}">
			<c:if test="${member.adminCk==1}">
			<a href="/admin/main">관리자페이지</a> 
			</c:if>
			<a id="logout">로그아웃</a> <a href="/member/admin/myroom/${member.memberMail}">마이룸</a>
			<a href="/cart/${member.memberMail}">장바구니</a><br />
			<span>충전금액<fmt:formatNumber value="${member.money}" pattern="\#,###.##"/></span>
			<span>포인트<fmt:formatNumber value="${member.point}" pattern="\#,###.##"/></span>
			
		</c:if>
	</div>
	
	<script>
	
	/* 로그아웃작동 */
	$("#logout").click(function(){
		$.ajax({
			type:'post',
			url:'/member/logoutHome',
			success: function(data){
				alert("로그아웃성공");
				document.location.reload();
			}
			
		});//ajx
			});//lgout
	
	
	</script>




</body>
</html>
