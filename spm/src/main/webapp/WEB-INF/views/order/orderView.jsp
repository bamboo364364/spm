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
<title>orderView</title>

<style>

</style>
</head>
<body>

	<%@include file="../includes/header.jsp" %>
	
  	<div id='listDiv'>
  	<c:choose> 
	<c:when test="${list == 'empty'}">
<div>등록된 상품이 없습니다</div>
	</c:when> 
	<c:otherwise> 
	<div>
	<table class='table' id='cartListTable'>
	<colgroup>
    <col width="20%" />
    <col width="20%" />
    <col width="20%" />
    <col width="20%" />
  	</colgroup>
	<thead>
		<tr>
			<th scope='col'>전체선택<p></p><input type="checkbox" class='selectAll form-check-input'/></th>
			<th scope='col'></th>
			<th scope='col'>상품이름</th>
			<th scope='col'>상품재고</th>
			<th scope='col'>상품수량</th>
			<th scope='col'>상품가격</th>
			<th scope='col'></th>
		</tr>
	</thead>
	<c:forEach items='${list}' var='list'>  
		<tr class='cartItem'>
			<td class='infoTd'>
			<input type="checkbox" class='checkbox form-check-input' checked="checked"/>
			<input type="hidden" id='point' value='${list.point}'/>
			<input type="hidden" id='goodId' value='${list.goodId}'/>
			</td>
			
			<td>
			<div class='imageWrap' goodId='${list.imageList[0].goodId}' path="${list.imageList[0].uploadPath}"
	 		uuid="${list.imageList[0].uuid}" fileName="${list.imageList[0].fileName}">
	 		<img>
	 		</div>
	 		</td>
			<td><input class='form-control' type="text" readonly="readonly" value= "<c:out value='${list.goodName}'></c:out>"/></td>
			<td class='goodStockTd'><input class='form-control goodStock' type="text" readonly="readonly" value= "<c:out value='${list.goodStock}'></c:out>"/></td>
			
			<td>
			<div class="center">
				<p></p>
	     		<div class="input-group">
		          	<span class="input-group-btn">
		            <button type="button" class="btn btn-outline-primary btn-number"  data-type="minus" data-field="quant[2]">
		            <span class="glyphicon glyphicon-minus"></span>
		            </button>
		            </span>                                                                                
		            <input id='quant[2]' type="text" class="form-control input-number" value='${list.goodCount}' min="1" max="${list.goodStock+ list.goodCount}">
		            <span class="input-group-btn">
		            <button type="button" class="btn btn-outline-primary btn-number" data-type="plus" data-field="quant[2]">
		            <span class="glyphicon glyphicon-plus"></span>
		            </button>
		            </span>
	            </div>
		        <p></p>
            </div>
			</td>
			
			<td><input data-goodprice='${list.goodPrice}' style="text-decoration: line-through; color: red;" class='form-control goodPrice' type="text" readonly="readonly" value='${list.goodPrice*list.goodCount}'/>
			<input data-saleprice='${list.salePrice}' class='form-control salePrice' type="text" readonly="readonly" value='${list.salePrice*list.goodCount}'/>
			</td>
			<td><button class='delBtn btn btn-outline-danger'<%--  orderId='${list.orderId}' --%> >삭제</button></td>
			
		</tr>
	</c:forEach>
		</table>
	</div>
		
		
		
	</c:otherwise> 
</c:choose>  
  		
  	</div>
  	
   <div id="CalDiv" class='border px-3 py-3 col-7 offset-6'>
	  	<div class="form-group col-8">
	    	<div class="input-group"> <span class="input-group-addon">가격합계</span>
	        <input id='totalPriceInput' type="text" class="form-control" readonly='readonly'/>
	        </div>
	   	</div>
	  	<div class="form-group col-8">
	    	<div class="input-group"> <span class="input-group-addon">수량합계</span>
	        <input id='totalCountInput' type="text" class="form-control" readonly='readonly' />
	        </div>
	   	</div>
	  	<div class="form-group col-8">
	    	<div class="input-group"> <span class="input-group-addon">배송비</span>
	        <input id='deliveryPriceInput' type="text" class="form-control" readonly='readonly'/>
	        </div>
	   	</div>
	  	<div class="form-group col-8">
	    	<div class="input-group"> <span class="input-group-addon">결제금액</span>
	        <input id='finalTotalPriceInput' type="text" class="form-control" readonly='readonly'/>
	        </div>
	   	</div>
	  	<div class="form-group col-8">
	    	<div class="input-group"> <span class="input-group-addon">예상적립포인트</span>
	        <input id='totalPointInput' type="text" class="form-control" readonly='readonly'/>
	        </div>
	   	</div>

	  	<button class='orderBtn btn btn-outline-success'>주문페이지로</button>
  	
  	</div>
  	
  	<!-- 삭제 form -->
				<form action="/cart/delete" method="post" class="delForm">
					<input type="hidden" name="cartId" class="delFormCartId">
					<input type="hidden" name="memberMail" value="${member.memberMail}">
					<input type="hidden" name="goodStock" class='delFormGoodStock'>
					<input type="hidden" name="goodCount" class='delFormGoodCount'>
					<input type="hidden" name="goodId" class='delFormGoodId'>
				</form>
				
	<!-- 주문 form -->
	<form action="/order/orderView" method="get"class="orderForm"></form>
  	
 
	

	
	
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
			setTotalInfo();
	}); 
	$('.checkbox').click(function(){
		let total= $('.checkbox').length;
		let checked= $('.checkbox:checked').length;
		if(total!= checked){
			$('.selectAll').prop('checked', false);
			}else{
				$('.selectAll').prop('checked', true);
			}
		
		setTotalInfo();
	}); 

	
	 /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
function setTotalInfo(){
	
	let totalPrice = 0;				// 총 가격
	let totalCount = 0;				// 총 갯수
	let totalPoint = 0;				// 총 마일리지
	let deliveryPrice = 0;			// 배송비
	let finalTotalPrice = 0; 		// 최종 가격(총 가격 + 배송비)

	
	$('.cartItem').each(function(i, e){
		
		if( $(e).find(".checkbox").is(":checked") === true ){	//체크여부
			// 총 가격 
			totalPrice += parseInt( $(e).find(".salePrice").val() );
			// 총 갯수
			totalCount += parseInt($(e).find(".input-number").val());
			// 총 마일리지
			totalPoint += ($(e).find("#point").val()*$(e).find(".input-number").val());			
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
	$("#totalPriceInput").val('총 상품가격: '+ totalPrice.toLocaleString() );
	// 총 갯수
	$("#totalCountInput").val('총상품 수: '+ totalCount);
	// 총 마일리지
	$("#totalPointInput").val('적립 예상포인트: '+ totalPoint.toLocaleString());
	// 배송비
	$("#deliveryPriceInput").val('배송비: '+ deliveryPrice);	
	// 최종 가격(총 가격 + 배송비)
	$("#finalTotalPriceInput").val('총결제 예상금액: '+ finalTotalPrice.toLocaleString());		
} 

	

	$('.delBtn').click(function(){
		let cartId= $(this).attr('cartId');
		let goodCount= $(this).parents('cartItem').find('#goodCount').val();
		let goodId= $(this).parents('cartItem').find('#goodId').val();
		let goodStock= $(this).parents('cartItem').find('.input-number').attr('max');
		$('.delFormGoodCount').val(goodCount);
		$('.delFormGoodStock').val(goodStock);
		$('.delFormGoodId').val(goodId);
		$('.delFormCartId').val(cartId);
		$('.delForm').submit();

	});
	
	
	
	/* 주문 페이지 이동 */	
$(".orderBtn").on("click", function(){
	
	const query = '.checkbox:checked';
	
	 const selectedElements = document.querySelectorAll(query);
	 const sEN= selectedElements.length;
	 
	 if(sEN== 0){
	 	alert("아무상품도 선택되지않았습니다.");
		return;
	 	}  
	

	let formContents ='';
	
	formContents+= "<input type='hidden' name='memberMail' value='"+sessionMemberMail+"'>";
	
	$(".cartItem").each(function(i, e){
		
		if($(e).find(".checkbox").is(":checked") === true){
			
			let goodId = $(e).find("#goodId").val();
			let goodCount = $(e).find(".input-number").val();
			let goodStock = $(e).find(".goodStock").val();
		
			let goodIdInput = "<input name='orders[" + i + "].goodId' type='hidden' value='" + goodId + "'>";
			formContents += goodIdInput;
			
			let goodCountInput = "<input name='orders[" + i + "].goodCount' type='hidden' value='" + goodCount + "'>";
			formContents += goodCountInput;
			
			let goodStockInput = "<input name='orders[" + i + "].goodStock' type='hidden' value='" + goodCount + "'>";
			formContents += goodStockInput;
			
			
		}
	});	

	$(".orderForm").html(formContents);
	$(".orderForm").submit();
	
	
	
});
	
	
	$('.btn-number').click(function(e){
    e.preventDefault();
    
    fieldName = $(this).attr('data-field');
    type      = $(this).attr('data-type');
    var input = $(this).parent().siblings('.input-number');
    var currentVal = parseInt(input.val());
    if (!isNaN(currentVal)) {
        if(type == 'minus') {
            
            if(currentVal > input.attr('min')) {
                input.val(currentVal - 1).change();
            } 
            if(parseInt(input.val()) == input.attr('min')) {
                $(this).attr('disabled', true);
            }
            if(parseInt(input.val()) < input.attr('max')) {
                $(this).attr('disabled', false);
            }

        } else if(type == 'plus') {

            if(currentVal < input.attr('max')) {
                input.val(currentVal + 1).change();
            }
            if(parseInt(input.val()) == input.attr('max')) {
                $(this).attr('disabled', true);
            }
            if(parseInt(input.val()) > input.attr('min')) {
                $(this).attr('disabled', false);
            }

        }
    } else {
        input.val(0);
    }
});
$('.input-number').focusin(function(){
   $(this).data('oldValue', $(this).val());
});
$('.input-number').change(function() {
    
    minValue =  parseInt($(this).attr('min'));
    maxValue =  parseInt($(this).attr('max'));
    valueCurrent = parseInt($(this).val());
    
    name = $(this).attr('name');
    if(valueCurrent >= minValue) {
        $(".btn-number[data-type='minus'][data-field='"+name+"']").removeAttr('disabled')
    } else {
        alert('1보다 작은값은 입력할수없습니다');
        $(this).val($(this).data('oldValue'));
    }
    if(valueCurrent <= maxValue) {
        $(".btn-number[data-type='plus'][data-field='"+name+"']").removeAttr('disabled')
    } else {
        alert('재고가 부족합니다');
        $(this).val($(this).data('oldValue'));
    }
    
   	let existStock= $(this).attr('max');
   	$(this).parents('.cartItem').find('.goodStock').val(existStock-$(this).val());
   	let goodPriceInput= $(this).parents('.cartItem').find('.goodPrice');
   	let salePriceInput= $(this).parents('.cartItem').find('.salePrice');
   	goodPriceInput.val($(this).val()*goodPriceInput.data('goodprice'));
   	salePriceInput.val($(this).val()*salePriceInput.data('saleprice'));
   	setTotalInfo();
   	
   	
 
});
$(".input-number").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
             // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) || 
             // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
                 // let it happen, don't do anything
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });	
	
	

	
			
	
	
	</script>




</body>
</html>
