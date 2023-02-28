<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
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
<title>home</title>

<style>

</style>
</head>
<body>
	
			<%@include file="./includes/header.jsp" %>
	

	
	
	<!-- 검색 영역 -->
  
  		<form id="searchForm" action='/search' method='get'>
  			<div id='searchDiv'>
  				<select class='form-select' name="type" id="type">
  				<option value="D">등록일자순</option>
  				<option value="C">카테고리정렬</option>
  				<option value="P">가격순</option>
  				<option value="S">재고순</option>
  				</select>
      			<input class='form-control ' type="text" name="keyword" placeholder="상품이름" value=''>
      			<input type="hidden" name="pageNum" value='${pageMaker.cri.pageNum}'>
      			<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
      			<button class='btn btn-outline-primary search_btn'>검 색</button>                				
  			</div>
  		</form>
	
	
	
	
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
