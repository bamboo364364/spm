<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>adminGoodDetail</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous">
	
</script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<style>

</style>
</head>
<body>
	<p>관리- 상품상세페이지입니다</p>
	
		<%@include file="../includes/adminHeader.jsp" %>
		
	<div class="imageWrap" goodId="${good.imageList[0].goodId}"
	path="${good.imageList[0].uploadPath}"
	uuid="${good.imageList[0].uuid}" fileName="${good.imageList[0].fileName}">
	<img></div>
	
	<table class='table' id='goodTable'>
	<thead>
		<tr>
			<th scope='col'>상품명</th>
			<th scope='col'>상품분류</th>
			<th scope='col'>상품메이커</th>
			<th scope='col'>등록일자</th>
			<th scope='col'>평점</th>
			<th scope='col'>상품할인</th>
			<th scope='col'>상품가격</th>
			<th scope='col'>상품재고</th>
			
		</tr>
	</thead>
		
		<tr>
			<td><input class="form-control" readonly="readonly" type="text" value="<c:out value='${good.goodName}'/>"/></td>
			<td><input class="form-control" readonly="readonly" type="text" value="<c:out value='${good.cateName}'/>"/></td>
			<td><input class="form-control" readonly="readonly" type="text" value="<c:out value='${good.goodMaker}'/>"/></td>
			<td><input class="form-control" readonly="readonly" type="text" value="<fmt:formatDate value='${good.regDate}' pattern='yyyy-MM-dd HH:ss'/>"/></td>
			<td><input class="form-control" readonly="readonly" type="text" value="<c:out value='${good.ratingAvg}'/>"/></td>
			<td><input class="form-control" readonly="readonly" type="text" value="<c:out value='${good.goodDiscount}'/>"/></td>
			<td><input class="form-control" readonly="readonly" type="text" value="<fmt:formatNumber value='${good.goodPrice}' pattern='#,###'/>"/></td>
			<td><input class="form-control" readonly="readonly" type="text" value="<c:out value='${good.goodStock}'/>"/></td>
		</tr>
		
	</table>

			
  <b>상품상세</b>
  <textarea readonly="readonly" class="form-control">${good.goodContents}</textarea>
	
	
	
	<div class='btnArea'>
	<button class='btn-outline-primary btn modBtn'>수정</button>
	<button class='btn btn-outline-danger delBtn'>삭제</button>
	</div>
	
	<form class="moveForm" action='/admin/goodModify/${good.goodId}'>
	<input type="hidden" name="keyword" value='${cri.keyword}'>
    <input type="hidden" name="pageNum" value='${cri.pageNum}'>
    <input type="hidden" name="amount" value='${cri.amount}'>
    <input type="hidden" name="type" value='${cri.type}'>
    <input type="hidden" name='goodId' value='${good.goodId}' />
	</form>



	

	

	<script>
	sessionStorage.setItem('memberMail', '${member.memberMail}');
	var sessionMemberMail= sessionStorage.getItem('memberMail');
	
	
	
	$('.modBtn').click(function(){
		$('.moveForm').submit();
	});
	
	$('.delBtn').click(function(){
		$('.moveForm').attr('action', '/admin/goodDelete');
		$('.moveForm').attr('method', 'post');
		$('.moveForm').submit();
	});
	
	
	
		/* 이미지 삽입 */
	var imageWrap = $(".imageWrap");

	if(imageWrap.attr("goodId")){
		const uploadPath = imageWrap.attr("path");
		const uuid = imageWrap.attr("uuid");
		const fileName = imageWrap.attr("fileName");
		
		const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
		
		imageWrap.find("img").attr('src', '/display?fileName=' + fileCallPath);
	} else {
		imageWrap.find("img").attr('src', '/resources/img/goodsNoImage.png');
	}	//image
	

	
	</script>
	



</body>
</html>
