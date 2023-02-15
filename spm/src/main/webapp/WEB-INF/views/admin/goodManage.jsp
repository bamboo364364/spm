<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goodManage</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous">
	
</script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<style>th, td {padding: 15px;} li{display: inline;} #sideNavLi1{background-color: gray;}
</style>
</head>
<body>
	<p>상품관리페이지입니다</p>

	<%@include file="../includes/adminHeader.jsp" %>
	
	
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
			<td><a href="/admin/goodDetail${list.goodName}"><c:out value='${list.goodName}'></c:out></a></td>
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
	let eResult = '<c:out value="${enroll_result}"/>';
	checkResult(eResult);
	function checkResult(result){
		
		if(result === ''){
			return;
		}
		
		alert("상품'"+ eResult +"'을 등록하였습니다.");
		
	}
	
	/* 수정 성공 이벤트 */
	let modify_result = '${modify_result}';
	
	if(modify_result == 1){
		alert("수정 완료");
	}	
	
	/* 삭제 결과 경고창 */
	let delete_result = '${delete_result}';
	
	if(delete_result == 1){
		alert("삭제 완료");
	}	
	
	
	

});//documentReady

/* 페이지 이동 버튼 */
$(".pageMaker_btn a").on("click", function(e){
	
	e.preventDefault();
	
	$('#moveForm').find("input[name='pageNum']").val($(this).attr("href"));
	
	$('#moveForm').submit();
	
});


	
	
</script>


</body>
</html>