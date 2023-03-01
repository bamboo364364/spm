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
<title>goodManage</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" /> 
	
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
	
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>


</head>
<body>

	

	<%@include file="../includes/adminHeader.jsp" %>
	

	
	

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
			<td><a class='agdBtn' href="/admin/adminGoodDetail/${list.goodId}"><c:out value='${list.goodName}'></c:out></a></td>
			<td><c:out value='${list.cateName}'></c:out></td>
			<td><c:out value='${list.goodPrice}'></c:out></td>
			<td><c:out value='${list.goodStock}'></c:out></td>
			<td><c:out value='${list.regDate}'></c:out></td>
			
		</tr>
		</c:forEach>
	</table>
	
	<script>
	
	// 관리자상품상세페이지 이동버튼
	$('.agdBtn').click(function(e){
		e.preventDefault();
		$('#searchForm').attr('action', $(this).attr('href') );
		$('#searchForm').submit();
	});
	
	</script>
	
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
	
	
	
	<!-- 검색 영역 -->
  
  		<form id="searchForm" class='form-inline'>
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
  
	
	
                
	<!-- 이동폼 -->
	<form id='moveForm'>
		<input name='pageNum' type="hidden" value='${pageMaker.cri.pageNum}'/>
		<input name='amount' type="hidden" value='${pageMaker.cri.amount}'/>
		<input name='keyword' type="hidden" value='${pageMaker.cri.keyword}'/>
		<input name='type' type="hidden" value='${pageMaker.cri.type}'/>
	</form>


	
<script>
$(document).ready(function(){
	/* 등록 성공 이벤트 */
	if('${enrollResult}'){
			alert("상품'"+ ${enrollResult} +"'을 등록하였습니다.");
		}
 
	/* 수정 성공 이벤트 */	
	if('${modifyResult}' == 1){
		alert("수정 완료");
	}	
	
	/* 삭제 결과 경고창 */
	if('${deleteResult}' == 1){
		alert("삭제 완료");
	}	

});

/* 페이지 이동 버튼 */
$(".pageMaker_btn a").on("click", function(e){
	
	e.preventDefault();
	
	$('#moveForm').find("input[name='pageNum']").val($(this).attr("href"));
	
	$('#moveForm').submit();
	
});


	
	
</script>


</body>
</html>