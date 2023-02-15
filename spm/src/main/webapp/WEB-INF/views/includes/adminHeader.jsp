<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminMain</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous">
	
</script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<style>
#upNav {
	float: right;
}
</style>
</head>
<body>

	<div id="upNav">
		<a href="/">홈페이지</a> <a href="/member/logoutRedirect">로그아웃</a>
	</div>

	<div id="sideNav" aaa='bbb'>
		
			<div><a id="sideNavLi1" href="/admin/goodManage">상품관리</a></div>
			<div><a id="sideNavLi2" href="/admin/goodEnroll">상품등록</a></div>
			<div><a id="sideNavLi3" href="/admin/memberManage">회원관리</a></div>
			<div><a id="sideNavLi4" href="/admin/orderList">주문현황</a></div>
		
	</div>
	
	<script>
	
	
	</script>


</body>
</html>