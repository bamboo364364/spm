<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- bootStrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">


<meta charset="UTF-8">
<title>adminMain</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous">
<meta name="viewport" content="width=device-width, initial-scale=1">

</script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>



</head>
<body>
	<h1><a href="/">쇼핑몰</a></h1>
	<div id="nav" align="right" >
		<a class='mx-4' href="/">홈페이지</a>
		<c:if test="${member==null}">
		<a class='mx-4' href="/member/join">회원가입</a> <a class='mx-4' href="/member/login">로그인</a>
		</c:if>
		<c:if test="${member!=null}">
			<c:if test="${member.adminCk==1}">
				<a class='mx-4' href="/admin/goodManage">관리자페이지</a> 
			</c:if>
			<a class='mx-4' href="/member/admin/myroom?memberMail=${member.memberMail}">마이룸</a>
			<a class='mx-4' href="/cart/cartView?memberMail=${member.memberMail}">카트</a>
			<a class='mx-4' id="logout">로그아웃</a> 
			<form class='form-inline'>
			<span class='mx-4'>이름<input class='form-control' type="text" readonly="readonly" value='${member.memberName}'/></span>
			<span class='mx-4' >충전금액 <input class='form-control' type="text" readonly="readonly" value='<fmt:formatNumber value="${member.money}" pattern="#,###.##"/>' /></span>
			<span class='mx-4' >포인트<input class='form-control' type="text" readonly="readonly" value='<fmt:formatNumber value="${member.point}" pattern="#,###.##"/>'/></span>
			</form>
		
		</c:if>
	</div>
	
	

	

	 


		
		

	
		

	
	<script>
	
	
	</script>


</body>
</html>