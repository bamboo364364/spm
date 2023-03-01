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

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
		<tr class='orderItem'>
			<td>
			<input type="checkbox" class='checkbox form-check-input' checked="checked"/>
			<input type="hidden" id='point' value='${list.point}'/>
			<input type="hidden" id='goodId' value='${list.goodId}'/>
			<input type="hidden" class='goodDiscount' value='${list.goodDiscount}'/>
			</td>
			
			<td>
			<div class='imageWrap' goodId='${list.imageList[0].goodId}' path="${list.imageList[0].uploadPath}"
	 		uuid="${list.imageList[0].uuid}" fileName="${list.imageList[0].fileName}">
	 		<img>
	 		</div>
	 		</td>
			<td><input class='form-control goodName' type="text" readonly="readonly" value= "<c:out value='${list.goodName}'></c:out>"/></td>
			<td><input class='form-control goodStock' type="text" readonly="readonly" value= "<c:out value='${list.goodStock}'></c:out>"/></td>
			
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
  
<div class='row'>
  	<div id="memberInfoDiv" class='border px-3 py-3 col-6'>
		<input type="hidden" id='memberMailInput' value='${memberInfo.memberMail}'/>
		<input type="hidden" id='pointInput' value='${memberInfo.point}'/>
		<input type="hidden" id='moneyInput' value='${memberInfo.money}'/>
  		<div class="form-group col-8">
	    	<div class="input-group"> <span class="input-group-addon">수령인</span>
	        <input id='memberNameInput' type="text" class="form-control" value="${memberInfo.memberName}"/>
	        </div>
	   	</div>
  		<div class="form-group col-8">
	    	<div class="input-group"> <span class="input-group-addon">주소1</span>
	        <input id='memberAddr1Input' type="text" class="form-control" readonly="readonly" value="${memberInfo.memberAddr1}"/>
	        </div>
	   	</div>
  		<div class="form-group col-8">
	    	<div class="input-group"> <span class="input-group-addon">주소2</span>
	        <input id='memberAddr2Input' type="text" class="form-control" readonly="readonly" value="${memberInfo.memberAddr2}"/>
	        </div>
	   	</div>
  		<div class="form-group col-8">
	    	<div class="input-group"> <span class="input-group-addon">주소3</span>
	        <input id='memberAddr3Input' type="text" class="form-control" data-addr= '${memberInfo.memberAddr3}' value="${memberInfo.memberAddr3}"/>
	        </div>
	   	</div>
	   		<span id='memberAddr3InputWarn' style='color:red;'></span>
	   		<button type="button" class='btn btn-outline-primary' onclick="executionDaumAddress()">주소찾기</button>
  	</div>
  	
   <div id="calDiv" class='border px-3 py-3 col-6'>
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
	  	<div class="form-group col-8">
	    	<div class="input-group"> <span class="input-group-addon">사용할포인트</span>
	        <input id='usePointInput' data-oldvalue='0' type="text" class="form-control" value='0' />
	        </div>
	   	</div>
		 <span class='usePointInputWarn' style='color:red;'></span>
	  	<button class='orderBtn btn btn-outline-success'>주문하기</button>
  	
  	</div>

  	</div> <!-- row -->

  	
  	<!-- 삭제 form -->
				<form action="/cart/delete" method="post" class="delForm">
					<input type="hidden" name="cartId" class="delFormCartId">
					<input type="hidden" name="memberMail" value="${member.memberMail}">
					<input type="hidden" name="goodStock" class='delFormGoodStock'>
					<input type="hidden" name="goodCount" class='delFormGoodCount'>
					<input type="hidden" name="goodId" class='delFormGoodId'>
				</form>
				
	<!-- 주문 form -->
	<form action="/order/order" method="post"class="orderForm"></form>



	<script>
	
	
	sessionStorage.setItem('memberMail', '${member.memberMail}');
	var sessionMemberMail= sessionStorage.getItem('memberMail');
	sessionStorage.setItem('point', '${member.point}');
	var sessionPoint= sessionStorage.getItem('point');
	sessionStorage.setItem('money', '${member.money}');
	var sessionMoney= sessionStorage.getItem('money');
	sessionStorage.setItem('memberName', '${member.money}');
	var sessionMoney= sessionStorage.getItem('money');
	
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
	let usePoint= 0;

	
	$('.orderItem').each(function(i, e){
		
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
		
		usePoint= $('#usePointInput').val();
		finalTotalPrice = totalPrice + deliveryPrice- usePoint;
		if(finalTotalPrice< 0){
			$('#usePointInput').val(parseInt(usePoint)+ finalTotalPrice);
			finalTotalPrice= 0;
		}
	
	/* ※ 세자리 컴마 Javscript Number 객체의 toLocaleString() */
	
	// 총 가격
	$("#totalPriceInput").val(totalPrice.toLocaleString() );
	// 총 갯수
	$("#totalCountInput").val(totalCount);
	// 총 마일리지
	$("#totalPointInput").val(totalPoint.toLocaleString());
	// 배송비
	$("#deliveryPriceInput").val( deliveryPrice.toLocaleString());	
	// 최종 가격(총 가격 + 배송비)
	$("#finalTotalPriceInput").val(finalTotalPrice.toLocaleString());	
	
} 
	 
	
	$('#usePointInput').on("change",function(){
		/*  propertychange change keyup paste input */
		let tv= parseInt($(this).val());
		let ov= parseInt($(this).data('oldvalue'));
		let msg= $('#calDiv').nextAll('.usePointInputWarn')
		let ftp= parseInt($(this).parents('#calDiv').find('#finalTotalPriceInput').val().replace(',', ''));
		if(isNaN(tv)){
			msg.html('숫자를 입력해주세요.');
			$(this).val(ov);
		}
		else if(tv> sessionPoint){
			msg.html('포인트가 부족합니다.');
			$(this).val(ov);
		}
		else if(tv> ftp){
			msg.html('결제금액보다 많습니다.');
			$(this).val(ov);
		}else{  
		msg.html('');
		
		$(this).data('oldvalue', tv);
		setTotalInfo();
		}
	});
	

	$('.delBtn').click(function(){
		let cartId= $(this).attr('cartId');
		let goodCount= $(this).parents('orderItem').find('#goodCount').val();
		let goodId= $(this).parents('orderItem').find('#goodId').val();
		let goodStock= $(this).parents('orderItem').find('.input-number').attr('max');
		$('.delFormGoodCount').val(goodCount);
		$('.delFormGoodStock').val(goodStock);
		$('.delFormGoodId').val(goodId);
		$('.delFormCartId').val(cartId);
		$('.delForm').submit();

	});

	
	/* 주문 */	
	$(".orderBtn").on("click", function(){
	
	const query = '.checkbox:checked';
	
	 const selectedElements = document.querySelectorAll(query);
	 const sEN= selectedElements.length;
	 
	 if(sEN== 0){
	 	alert("아무상품도 선택되지않았습니다.");
		return;
	 	}  
	 
	 var formContents ='';
	
$(".orderItem").each(function(i, e){
		
		if($(e).find(".checkbox").is(":checked") === true){
			
			let goodId = $(e).find("#goodId").val();
			let goodCount = $(e).find(".input-number").val();
			let goodStock = $(e).find(".goodStock").val();
			let goodPrice = $(e).find(".goodPrice").data('goodprice');
			let goodDiscount = $(e).find(".goodDiscount").val();
			let savePoint = $(e).find("#point").val();
			
			var inputMaker= function(i, c){
				formContents+="<input name='orders[" + i + "]."+ Object.keys(c)[0] +"' type='hidden' value='" + Object.values(c)[0] + "'>";
			} 
					
			inputMaker(i,{goodId});
			inputMaker(i,{goodCount});
			inputMaker(i,{goodStock});
			inputMaker(i,{goodPrice});
			inputMaker(i,{goodDiscount});
			inputMaker(i,{savePoint});
		}
	
		});  
		
		let orderSavePoint= $("#totalPointInput").val();
		let usePoint= $("#usePointInput").val().replace(",","");
		let orderFinalSalePrice= $("#finalTotalPriceInput").val().replace(",","");
		let memberInfoDiv= $('#memberInfoDiv');
		
		formContents+= "<input type='hidden' name='orderSavePoint' value='"+orderSavePoint+"'>";
		formContents+= "<input type='hidden' name='usePoint' value='"+usePoint+"'>";
		formContents+= "<input type='hidden' name='orderFinalSalePrice' value='"+orderFinalSalePrice+"'>";
		formContents+= "<input type='hidden' name='memberMail' value='"+ memberInfoDiv.find($('#memberMailInput')).val() +"'>";
		formContents+= "<input type='hidden' name='memberName' value='"+ memberInfoDiv.find($('#memberNameInput')).val() +"'>";
		formContents+= "<input type='hidden' name='money' value='"+ memberInfoDiv.find($('#moneyInput')).val()+"'>";
		formContents+= "<input type='hidden' name='point' value='"+memberInfoDiv.find($('#pointInput')).val()+"'>";
		formContents+= "<input type='hidden' name='memberAddr1' value='"+memberInfoDiv.find($('#memberAddr1Input')).val()+"'>";
		formContents+= "<input type='hidden' name='memberAddr2' value='"+memberInfoDiv.find($('#memberAddr2Input')).val()+"'>";
		formContents+= "<input type='hidden' name='memberAddr3' value='"+memberInfoDiv.find($('#memberAddr3Input')).val()+"'>";
		
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
   $(this).data('oldvalue', $(this).val());
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
        $(this).val($(this).data('oldvalue'));
    }
    if(valueCurrent <= maxValue) {
        $(".btn-number[data-type='plus'][data-field='"+name+"']").removeAttr('disabled')
    } else {
        alert('재고가 부족합니다');
        $(this).val($(this).data('oldvalue'));
    }
    
   	let existStock= $(this).attr('max');
   	$(this).parents('.orderItem').find('.goodStock').val(existStock-$(this).val());
   	let goodPriceInput= $(this).parents('.orderItem').find('.goodPrice');
   	let salePriceInput= $(this).parents('.orderItem').find('.salePrice');
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
    
    
    
    /* 다음 주소 연동 */
		function executionDaumAddress() {

			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								// 주소변수 문자열과 참고항목 문자열 합치기
								addr += extraAddr;

							} else {
								addr += ' ';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							$("#memberAddr1Input").val(data.zonecode);
							//$("[name=memberAddr1]").val(data.zonecode);	// 대체가능
							$("#memberAddr2Input").val(addr);
							//$("[name=memberAddr2]").val(addr);			// 대체가능
							// 상세주소 입력란 disabled 속성 변경 및 커서를 상세주소 필드로 이동한다.
							$("#memberAddr3Input").attr("readonly", false);
							$("#memberAddr3Input").focus();

						}
					}).open();

		}//daum
		
		$("#memberAddr3Input").on('change', function(){
			if(!$(this).val()){
				$("#memberAddr3InputWarn").html('주소를 입력해주세요.');
				$(this).val($(this).data('addr'));
			}else{
				$("#memberAddr3InputWarn").html('');
			}
			
		})
		
	
	

	
			
	
	
	</script>




</body>
</html>
