<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cartView</title>
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

#upNav, #CalDiv {
	float: right; background-color: red;
}

#listDiv{
	clear: both;
	width: 60%;
}

#cartListTable{
	width: 90%;
}

</style>
</head>
<body>
	<a href="/"><h1>쇼핑몰</h1></a>
	<h2>카트</h2>
	
	
	<div id="upNav">
		<c:if test="${member==null}">
		<a href="/member/join">회원가입</a> <a href="/member/login">로그인</a>
		</c:if>
		<c:if test="${member!=null}">
			<c:if test="${member.adminCk==1}">
			<a href="/admin/goodManage">관리자페이지</a> 
			</c:if>
			<a id="logout">로그아웃</a> <a href="/member/admin/myroom/${member.memberMail}">마이룸</a>
			<a href="/cart/${member.memberMail}?">카트</a><br />
			<span style='color:red;' >${member.memberName}</span>
			<span>충전금액<fmt:formatNumber value="${member.money}" pattern="\#,###.##"/></span>
			<span>포인트<fmt:formatNumber value="${member.point}" pattern="\#,###.##"/></span>
			
		</c:if>
	</div>

	
  	<div id='listDiv'>
  		<!-- 카트리스트 -->
  		<c:choose> 
	<c:when test="${cartInfo == 'empty'}">
<div>등록된 상품이 없습니다</div>
	</c:when> 
	<c:otherwise> 
	<div>
	
		<table id='cartListTable'>
	<colgroup>
    <col width="20%" />
    <col width="20%" />
    <col width="20%" />
    <col width="20%" />
  	</colgroup>
	<thead>
		<tr>
			<th>전체선택 <input type="checkbox" class='selectAll'/></th>
			<th></th>
			<th>카트번호</th>
			<th>상품이름</th>
			<th>상품수량</th>
			<th>상품가격</th>
			<th></th>
		</tr>
	</thead>
		<c:forEach items='${cartInfo}' var='list'>  <!-- cartId memberMail goodId goodCount goodName
		goodPrice goodDiscount -->
		<tr>
			<td class='infoTd'>
			<input type="checkbox" class='checkbox' checked="checked"/>
			<input type="hidden" id='goodPrice' value='${list.goodPrice}'/>
			<input type="hidden" id='salePrice' value='${list.salePrice}'/>
			<input type="hidden" id='goodCount' value='${list.goodCount}'/>
			<input type="hidden" id='totalPriceB' value='${list.goodPrice * list.goodCount}'/>
			<input type="hidden" id='totalPrice' value='${list.salePrice * list.goodCount}'/>
			<input type="hidden" id='point' value='${list.point}'/>
			<input type="hidden" id='totalPoint' value='${list.totalPoint}'/>
			<input type="hidden" id='goodId' value='${list.goodId}'/>
			</td>
			
			<td>
			<div class='imageWrap' goodId='${list.imageList[0].goodId}' path="${list.imageList[0].uploadPath}"
	 		uuid="${list.imageList[0].uuid}" fileName="${list.imageList[0].fileName}">
	 		<img>
	 		
	 		</div>
	 		</td>
	 		
			
			<td><c:out value='${list.cartId}'></c:out></td>
			<td> <a href="/goodDetail/${list.goodId}"> <c:out value='${list.goodName}'></c:out> </a> </td>
			<td><c:out value='${list.goodCount}'></c:out></td>
			<td><c:out value='${list.goodPrice}'></c:out></td>
			<td><button class='delBtn' cartId='${list.cartId}' >삭제</button></td>
			
		</tr>
		</c:forEach>
		</table>
	</div>
		
		
		
	</c:otherwise> 
</c:choose>  
  		
  	</div>	<!-- listDiv -->
  	
  	<div id="CalDiv">
  	<p id='totalPriceP'></p>
  	
  	<p id='deliveryPriceP'></p>
  	
  	<p id='totalCountP'></p>
  	
  	<p id='finalTotalPriceP'></p>
  	
  	<p id='totalPointP'></p>
  	
  	
  	<button class='orderBtn'>주문페이지로</button>
  	
  	
  	</div>
  	
  	<!-- 삭제 form -->
				<form action="/cart/delete" method="post" class="delForm">
					<input type="hidden" name="cartId" class="delFormCartId">
					<input type="hidden" name="memberMail" value="${member.memberMail}">
				</form>
				
	<!-- 주문 form -->
	<form action="/order/orderView" method="get"
		class="orderForm"></form>
  	
 
	

	
	
	<script>
	
	
	sessionStorage.setItem('memberMail', '${member.memberMail}');
	var sessionMemberMail= sessionStorage.getItem('memberMail');
	
	$(document).ready(function(){
		
	/* 계산 */	
	setTotalInfo();
		
		/* 이미지 삽입 */
	/* var imageWrap = $(".imageWrap"); */
 $(".imageWrap").each(function(){
	if( $(this).attr("goodId") ){
		let uploadPath = $(this).attr("path");
		let uuid = $(this).attr("uuid");
		let fileName = $(this).attr("fileName");
		
		let fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
		
		$(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
	} else {
		$(this).find("img").attr('src', '/resources/img/goodsNoImage.png');
	} 
	
});
 

	
	}); //document
	
	
	
	
	/* 체크박스 전체 선택 */
	  
	
	$(".selectAll").click(function(){
	
			/* 체크박스 체크/해제 */
		if( $(this). is(':checked') ){
		$('.checkbox').prop('checked', true);
		}else{$('.checkbox').prop('checked', false)
		}
			setTotalInfo('.infoTd');
	}); //selectAll
	
	$('.checkbox').click(function(){
		let total= $('.checkbox').length;
		let checked= $('.checkbox:checked').length;
		if(total!= checked){
			$('.selectAll').prop('checked', false);
			}else{
				$('.selectAll').prop('checked', true);
			}
		
		setTotalInfo('.infoTd');
	}); //checkbox
	
	
	
	
	
	 /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
function setTotalInfo(){
	
	let totalPrice = 0;				// 총 가격
	let totalCount = 0;				// 총 갯수
	let totalPoint = 0;				// 총 마일리지
	let deliveryPrice = 0;			// 배송비
	let finalTotalPrice = 0; 		// 최종 가격(총 가격 + 배송비)

	
	$('.infoTd').each(function(i, e){
		
		if( $(e).find(".checkbox").is(":checked") === true ){	//체크여부
			// 총 가격 
			
			totalPrice += parseInt( $(e).find("#totalPrice").val() );
			// 총 갯수
			totalCount += parseInt($(e).find("#goodCount").val());
			// 총 마일리지
			totalPoint += parseInt($(e).find("#totalPoint").val());			
		}

	}); 
	
	/* 배송비 결정 */
	if(totalPrice >= 30000){
		deliveryPrice = 0;
	} else if(totalPrice == 0){
		deliveryPrice = 0;
	} else {
		deliveryPrice = 3000;	
	}
	
		finalTotalPrice = totalPrice + deliveryPrice;
	
	/* ※ 세자리 컴마 Javscript Number 객체의 toLocaleString() */
	
	// 총 가격
	$("#totalPriceP").text('총 상품가격: '+ totalPrice.toLocaleString() );
	// 총 갯수
	$("#totalCountP").text('총상품 수: '+ totalCount);
	// 총 마일리지
	$("#totalPointP").text('적립 예상포인트: '+ totalPoint.toLocaleString());
	// 배송비
	$("#deliveryPriceP").text('배송비: '+ deliveryPrice);	
	// 최종 가격(총 가격 + 배송비)
	$("#finalTotalPriceP").text('총결제 예상금액: '+ finalTotalPrice.toLocaleString());		
} //setTotalInfo


	$('.delBtn').click(function(){
		let cartId= $(this).attr('cartId');
	
		$('.delFormCartId').val(cartId);
		$('.delForm').submit();

	}); //delBtn
	
	
	
	/* 주문 페이지 이동 */	
$(".orderBtn").on("click", function(){
	
	const query = '.checkbox:checked';
	
	 const selectedElements = document.querySelectorAll(query);
	 const sEN= selectedElements.length;
	 
	 if(sEN== 0){
	 	alert("상품x");
		return;
	 	}  
	
		
	  
			
		  
			 
				

	let formContents ='';
	let orderNumber = 0;
	
	formContents+= "<input type='hidden' name='memberMail' value='"+sessionMemberMail+"'>";
	
	$(".infoTd").each(function(index, element){
		
		if($(element).find(".checkbox").is(":checked") === true){	//체크여부
			
			let goodId = $(element).find("#goodId").val();
			let goodCount = $(element).find("#goodCount").val();
			
			let goodIdInput = "<input name='orders[" + orderNumber + "].goodId' type='hidden' value='" + goodId + "'>";
			formContents += goodIdInput;
			
			let goodCountInput = "<input name='orders[" + orderNumber + "].goodCount' type='hidden' value='" + goodCount + "'>";
			formContents += goodCountInput;
			
			orderNumber += 1;
			
		}
	});	

	$(".orderForm").html(formContents);
	$(".orderForm").submit();
	
	
	
}); //orderBtn
		
		
	
	

	
			
	
	
	</script>




</body>
</html>
