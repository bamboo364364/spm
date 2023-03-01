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

<style>
.nav > a{
  margin-left:30px;
  margin-right:30px;
}
</style>

</head>
<body>

	<div id="upNav" align="right" padding='10px;'>
		<a class='mx-4' href="/">홈페이지</a><a class='mx-4' href="/member/logoutRedirect">로그아웃</a>
	</div>
			
	

<div class='d-flex justify-content-start'>
	<nav class="nav nav-pills nav-fill ">
	
  <a class="nav-item nav-link" href="/admin/goodManage">상품관리</a>
  <a class="nav-item nav-link" href="/admin/goodEnroll">상품등록</a>
  <a class="nav-item nav-link" href='/admin/memberManage'>회원관리</a>
  <a class="nav-item nav-link" href="/admin/orderList">주문관리</a>

	</nav>
</div>
	 


		
		

	
		

	<script>
	$(document).ready(function(){ 
		let path= (window.location.href).substr(16);
	$('.nav').find('a[href="'+path+'"]').attr('class','nav-item nav-link active');
	});
	
	</script>


</body>
</html>