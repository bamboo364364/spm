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
<title>search</title>

<style>

</style>
</head>
<body>
	
	<%@include file="./includes/header.jsp" %>
	
	
	<!-- 검색 영역 -->
  
  		<form id="searchForm">
  			<div id='searchDiv'">
  				<select class='form-select' name="type" id="type">
  				<option value="D">등록일자순</option>
  				<option value="C">카테고리정렬</option>
  				<option value="P">가격순</option>
  				<option value="S">재고순</option>
  				</select>
      			<input class='form-control' type="text" name="keyword" value='${pageMaker.cri.keyword}'>
      			<input type="hidden" name="pageNum" value='1'>
      			<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
      			<button class='btn btn-outline-primary search_btn'>검 색</button>                				
  			</div>
  		</form>
  		
  		<!-- 검색카테유지 -->
  		<script>
  		$(window).on('load', function(){
  			$("#type").val('${pageMaker.cri.type}');
  		});
  		</script>
  		
  	


  		
  		
  		<c:if test="${listCheck == 'empty'}">
	<div>등록된 상품이 없습니다</div>
    </c:if>
    
    <c:if test="${listCheck != 'empty'}">
	<table class='table' id='goodListTable'>
	<thead>
		<tr>
			<th scope='col'>상품번호</th>
			<th scope='col'>상품이름</th>
			<th scope='col'>상품분류</th>
			<th scope='col'>상품가격</th>
			<th scope='col'>상품재고</th>
			<th scope='col'>등록일자</th>
		</tr>
	</thead>
		<c:forEach items='${list}' var='list'>
		<tr>
			<td><c:out value='${list.goodId}'></c:out></td>
			<td> <a href='/goodDetail/${list.goodId}' > <c:out value='${list.goodName}'></c:out> </a> </td>
			<td><c:out value='${list.cateName}'></c:out></td>
			<td><c:out value='${list.goodPrice}'></c:out></td>
			<td><c:out value='${list.goodStock}'></c:out></td>
			<td><c:out value='${list.regDate}'></c:out></td>
			
		</tr>
		</c:forEach>
	</table>
	
<!-- 페이지 이름 인터페이스 영역 -->
  	
  		<ul class="pageMaker">
  			
  			<!-- 이전 버튼 -->
  			<c:if test="${pageMaker.prev }">
  				<li class="pageMaker_btn prev">
  					<a href="${pageMaker.pageStart -1}">이전</a>
  				</li>
  			</c:if>
  			
  			<!-- 페이지 번호 -->
  			<c:forEach begin="${pageMaker.pageStart }" end="${pageMaker.pageEnd }" var="num">
  				<li style='display: inline;'
  				class="btn btn-outline-light pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':''}">
  					<a href="${num}">${num}</a> 
  				</li>	
  			</c:forEach>
  		
       	<!-- 다음 버튼 -->
       	<c:if test="${pageMaker.next}">
       		<li class="pageMaker_btn next">
       			<a href="${pageMaker.pageEnd + 1 }">다음</a>
       		</li>
       	</c:if>
       </ul>

		</c:if>
		
		<!-- 이동폼 -->
	<form id='moveForm'>
		<input name='pageNum' type="hidden" value='${pageMaker.cri.pageNum}'/>
		<input name='amount' type="hidden" value='${pageMaker.cri.amount}'/>
		<input name='keyword' type="hidden" value='${pageMaker.cri.keyword}'/>
		<input name='type' type="hidden" value='${pageMaker.cri.type}'/>
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
	
	
			
	/* 페이지 이동 버튼 */
$(".pageMaker_btn a").on("click", function(e){
	
	e.preventDefault();
	
	$('#moveForm').find("input[name='pageNum']").val($(this).attr("href"));
	
	$('#moveForm').submit();
	
});//pageMaker


/* 상품디테일페이지 이동 */
/* $('#goodListTable').find('a').on('click', function(e){
	e.preventDefault();
	
	$('#moveForm').attr('action','/goodDetail/'+ $(this).attr("href"))
	$('#moveForm').children().remove();
	alert('w');
	$('#moveForm').submit(); 
}); */


			
	</script>




</body>
</html>
