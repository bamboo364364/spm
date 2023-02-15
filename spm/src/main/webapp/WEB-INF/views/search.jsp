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
			<a href="/admin/goodManage">관리자페이지</a> 
			</c:if>
			<a id="logout">로그아웃</a> <a href="/member/admin/myroom/${member.memberMail}">마이룸</a>
			<a href="/cart/${member.memberMail}">장바구니</a><br />
			<span style='color:red;' >${member.memberName}</span>
			<span>충전금액<fmt:formatNumber value="${member.money}" pattern="\#,###.##"/></span>
			<span>포인트<fmt:formatNumber value="${member.point}" pattern="\#,###.##"/></span>
			
		</c:if>
	</div>
	
	
	<!-- 검색 영역 -->
  
  		<form id="searchForm">
  			<div id='searchDiv'">
  				<select name="type" id="type">
  				<option value="D">등록일자순</option>
  				<option value="C">카테고리정렬</option>
  				<option value="P">가격순</option>
  				<option value="S">재고순</option>
  				</select>
      			<input type="text" name="keyword" value='${pageMaker.cri.keyword}'>
      			<input type="hidden" name="pageNum" value='${pageMaker.cri.pageNum}'>
      			<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
      			<button class='btn search_btn'>검 색</button>                				
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
	<table id='goodListTable'>
	<thead>
		<tr>
			<td>상품번호</td>
			<td>상품이름</td>
			<td>상품분류</td>
			<td>상품가격</td>
			<td>상품재고</td>
			<td>등록일자</td>
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
	
<!-- 페이지 이름 인터페이스 영역 -->s
  	
  		<ul class="pageMaker">
  			
  			<!-- 이전 버튼 -->
  			<c:if test="${pageMaker.prev }">
  				<li class="pageMaker_btn prev">
  					<a href="${pageMaker.pageStart -1}">이전</a>
  				</li>
  			</c:if>
  			
  			<!-- 페이지 번호 -->
  			<c:forEach begin="${pageMaker.pageStart }" end="${pageMaker.pageEnd }" var="num">
  				<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':''}">
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


/* 상품디테일페s이지 이동 */
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
