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
 <!-- 다음주소 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<style>
h1{
	display: inline; 
}

#upNav {
	float: right;
}
.clearFix{
clear: both;
}
#listDiv, #addrDiv{
 float: left; width: 50%; border: 1px solid black;
}
#calDiv, #memPayDiv{
float:right; width: 30%; border: 1px solid black;
}
</style>
</head>
<body>
	<a href="/"><h1>쇼핑몰</h1></a>
	
	<div id="upNav">
		<c:if test="${member==null}">
		<a href="/member/join">회원가입</a> <a href="/member/login">로그인</a>
		</c:if>
		<c:if test="${member!=null}">
			<c:if test="${member.adminCk==1}">
			<a href="/admin/goodManage">관리자페이지</a> 
			</c:if>
			<a id="logout">로그아웃</a> <a href="/member/admin/myroom?memberMail=${member.memberMail}">마이룸</a>
			<a href="/cart/cartView?memberMail=${member.memberMail}">카트</a><br />
			<span style='color:red;' >${member.memberName}</span>
			<span>충전금액<fmt:formatNumber value="${member.money}" pattern="\#,###.##"/></span>
			<span>포인트<fmt:formatNumber value="${member.point}" pattern="\#,###.##"/></span>
			
		</c:if>
	</div> <!-- upNav -->
	<h2>주문</h2>
	
	<div class="clearFix"></div>
	
	<div id="addrDiv">
		<p>	수취인명: <input type="text" id="memberName" name='memberName' value='${memberInfo.memberName}' /> </p>
		
				<input type="text" id="memberAddr1" name="memberAddr1" readonly="readonly" value='${memberInfo.memberAddr1}'/>                      
				<br />
				<input type="text" id="memberAddr2" name="memberAddr2" readonly="readonly" value='${memberInfo.memberAddr2}'/>
				<br />
				<button type="button" onclick="executionDaumAddress()">주소찾기</button>
				<br />
				<input type="text" id="memberAddr3" name="memberAddr3" readonly="readonly" placeholder="거주지 주소 상세" value='${memberInfo.memberAddr3}' />
				<br /> <div class="memberAddr3Warn"></div>
			
		
	</div> <!-- AddrDiv -->
	
	<div id='listDiv'>
  		<!-- 오더리스트 -->
  		<c:choose> 
	<c:when test="${orderList == 'empty'}">
<div>등록된 상품이 없습니다</div>
	</c:when> 
	<c:otherwise> 
	<div>
	
	
	


		<table id='orderListTable'>
	<colgroup>
    <col width="20%" />
    <col width="20%" />
    <col width="20%" />
    <col width="20%" />
  	</colgroup>
	<c:forEach items='${orderList}' var='list'>
	<tr>
	<td>
	<a href="/goodDetail/${list.goodId}">${list.goodName}</a>
	</td>
	<td>
		<div class='imageWrap' goodId='${list.imageList[0].goodId}' path="${list.imageList[0].uploadPath}"
		 uuid="${list.imageList[0].uuid}" fileName="${list.imageList[0].fileName}">
		<img>
		</div>
	</td>
	<td class='infoTd'>
		<fmt:formatNumber value="${list.salePrice}" pattern="#,### 원" /><br />
		수량
		<input type="text" value="${list.goodCount}" class="quantityInput">
		<p class='quantityInputWarn'></p>
			<button class="quantityBtn plusBtn">+</button>
			<button class="quantityBtn minusBtn">-</button>
										
			<input type="hidden" id='goodPrice' value='${list.goodPrice}'/>
			<input type="hidden" id='salePrice' value='${list.salePrice}'/>
			<input type="hidden" id='goodCount' value='${list.goodCount}'/>
			<input type="hidden" id='point' value='${list.point}'/>
			<input type="hidden" id='goodId' value='${list.goodId}'/>
			<input type="hidden" id='goodStock' value='${list.goodStock}'/>
	</td>
		
	
	</tr>
	</c:forEach>
		</table>
	</div>
		
		
		
	</c:otherwise> 
</c:choose>  
  		
  	</div>	<!-- listDiv -->
  	
  	<script>
  	
  	
  	$('.plusBtn').click(function(){
  	let qV= parseInt( $(this).siblings('.quantityInput').val() );
  	if(qV+ 1> $(this).siblings('#goodStock').val() ){
  		$(this).siblings('.quantityInputWarn').html('상품재고부족');
  		$(this).siblings('.quantityInput').val(qV);
  	}else{ $(this).siblings('.quantityInputWarn').html('');
  	$(this).siblings('.quantityInput').val(++qV); 
  	$(this).siblings('#goodCount').val( $(this).siblings('.quantityInput').val() )
  	setTotalInfo();
  	}
  	
  	});
  	
  	$('.minusBtn').click(function(){
  	let qV= parseInt( $(this).siblings('.quantityInput').val() );
  		if(qV> 1){
  	$(this).siblings('.quantityInput').val(--qV);
  	$(this).siblings('#goodCount').val( $(this).siblings('.quantityInput').val() );
  		setTotalInfo();
  			}	if( qV<= $(this).siblings('#goodStock').val() ){
  				$(this).siblings('.quantityInputWarn').html('');
  			}
  	}); 
  	
  	$('.quantityInput').on('change', function(){
  		let qV= parseInt( $(this).val() );
  		if( isNaN(qV) ){
  			$(this).siblings('.quantityInputWarn').html('숫자입력');
  		}
  		if( qV< 1 ){
  			$(this).val(1);
  		}
  		if( qV> $(this).siblings('#goodStock').val() ){
  			$(this).siblings('.quantityInputWarn').html('상품재고부족');
  		}else{
  		
  		$(this).siblings('#goodCount').val( qV );
  		$(this).siblings('.quantityInputWarn').html('');
  		setTotalInfo();
  		}
  	}); //quantityInputs
  	
  	
  	
  
  	
  	</script>
  	
  	
  	<div id="calDiv">
  	<p id='totalPriceP'></p>
  	
  	<p id='deliveryPriceP'></p>
  	
  	<p id='totalCountP'></p>
  	
  	<p id='finalTotalPriceP'></p>
  	
  	<p id='totalPointP'></p>
  	
  	
  	<button class='orderBtn' >결재하기</button>
  	

  	
  	</div>
  	
   	<!-- orderPost전달폼 -->
  	<form action='/order/order' method='post' class='orderForm'>
  	<input type="hidden" name='usePoint' class='orderFormUsePoint'/>
  	<input type="hidden" name='memberAddr1' class='orderFormMemberAddr1'/>
  	<input type="hidden" name='memberAddr2' class='orderFormMemberAddr2'/>
  	<input type="hidden" name='memberAddr3' class='orderFormMemberAddr3'/>
  	<input type="hidden" name='memberName' class='orderFormMemberName'/>
  	<input type="hidden" name='memberMail' class='orderFormMemberMail'/>
  	<input type="hidden" name='money' class='orderFormMoney'/>
  	<input type="hidden" name='point' class='orderFormPoint'/>
  	</form>
  	
  	
  	
  	

  	<div id="memPayDiv">
  	충전금액 사용
  	<p class='memPayDivMoney'>
  	${memberInfo.money}
  	<span class='memPayDivMoneyConsume'></span>
  	<span class='memPayDivMoneyPoint'></span>
  	<span class='memPayDivMoneyResult'></span>
  	</p>       			
  	<p>사용포인트 <input type="text" class='memPayDivPoint' value='0' /> </p>
  	
  	<p class='memPayDivPointWarn'>${memberInfo.point}</p>
  	</div>
	
	
	
	
	
	
	
	
	
	<script>
	
	sessionStorage.setItem('memberMail', '${member.memberMail}');
	sessionStorage.setItem('money', '${member.money}');
	sessionStorage.setItem('point', '${member.point}');
	var sessionMemberMail= sessionStorage.getItem('memberMail');
	var sessionMoney= sessionStorage.getItem('money');
	var sessionPoint= sessionStorage.getItem('point');
	
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
	
	
	
	
	 /* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
function setTotalInfo(){
	
	var totalPrice = 0;				// 총 가격
	var totalPriceB = 0;				// 총 가격
	var totalCount = 0;				// 총 갯수
	var totalPoint = 0;				// 총 마일리지
	var deliveryPrice = 0;			// 배송비
	var finalTotalPrice = 0; 		// 최종 가격(총 가격 + 배송비)

	
	$('.infoTd').each(function(i, e){
		
			//할인전총가격
			totalPriceB+= parseInt( $(e).find("#goodPrice").val() )* parseInt( $(e).find("#goodCount").val() );
			// 총 가격
			totalPrice += parseInt( $(e).find("#salePrice").val() )* parseInt( $(e).find("#goodCount").val() );
			// 총 갯수
			totalCount += parseInt($(e).find("#goodCount").val());
			// 총 포인트
			totalPoint += parseInt($(e).find("#point").val())* parseInt( $(e).find("#goodCount").val() );	
		

	}); 
	
	/* 배송비 결정 */
	if(totalPrice >= 30000){
		deliveryPrice = 0;
	} else if(totalPrice == 0){
		deliveryPrice = 0;
	} else {
		deliveryPrice = 3000;	
	}
		finalTotalPriceB= totalPriceB+ 3000;
		finalTotalPrice = totalPrice + deliveryPrice;
	
	/* ※ 세자리 컴마 Javscript Number 객체의 toLocaleString() */
	
	// 총 가격

	$("#totalPriceP").html('총 상품가격: <del>'+ totalPriceB.toLocaleString() +'</del><br/>'+ totalPrice.toLocaleString() );
	// 총 갯수
	$("#totalCountP").text('총상품 수: '+ totalCount);
	// 총 마일리지
	$("#totalPointP").text('적립 예상포인트: '+ totalPoint.toLocaleString());
	// 배송비
	$("#deliveryPriceP").text('배송비: '+ deliveryPrice);	
	// 최종 가격(총 가격 + 배송비)
	$("#finalTotalPriceP").html('총결제 예상금액: <del>'+finalTotalPriceB+'</del><br />' + finalTotalPrice.toLocaleString());		
	
	$('.memPayDivMoneyConsume').html('-'+ finalTotalPrice)
	var moneyUse= finalTotalPrice - parseInt( $('.memPayDivPoint').val() );
	var remMoney=  parseInt( sessionMoney )- parseInt(moneyUse) ;
	$('.memPayDivMoneyPoint').html('+'+ $('.memPayDivPoint').val() ) 
	$('.memPayDivMoneyResult').html('='+ remMoney ) 
	
	
	} //setTotalInfo

	
	
	
	
	
	
	
	
	
	
	
	
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
							$("#memberAddr1").val(data.zonecode);
							//$("[name=memberAddr1]").val(data.zonecode);	// 대체가능
							$("#memberAddr2").val(addr);
							//$("[name=memberAddr2]").val(addr);			// 대체가능
							// 상세주소 입력란 disabled 속성 변경 및 커서를 상세주소 필드로 이동한다.
							$("#memberAddr3").attr("readonly", false);
							$("#memberAddr3").focus();

						}
					}).open();

		}//daum
		
		
	
		/* 포인트사용, 사용 돈정보 */
	$('.memPayDivPoint').on("propertychange change keyup paste input",function(){
		
		if( $(this).val()> ${memberInfo.point} ){ 
			$('.memPayDivPointWarn').html('포인트부족'); $('.orderBtn').attr('disabled', 'disabled');
		}else if( isNaN( $(this).val()) ){
			$('.memPayDivPointWarn').html('숫자를 입력해주세요'); $('.orderBtn').attr('disabled', 'disabled');
		}else{
		$('.memPayDivPointWarn').html(''); $('.orderBtn').removeAttr('disabled');
		setTotalInfo()
		
		
		}
	
	});//memPayDivPoint
	
	
	
  	<!-- orderPost전달폼 작성 -->
  	$('.orderBtn').click(function(){
  		if( !sessionMemberMail ){alert('다시 로그인해주세요')}else{
  		
  		$('.orderForm').find('.orderFormUsePoint').val( $('.memPayDivPoint').val() );
  		$('.orderForm').find('.orderFormMemberAddr1').val( $('#memberAddr1').val() );
  		$('.orderForm').find('.orderFormMemberAddr2').val( $('#memberAddr2').val() );
  		$('.orderForm').find('.orderFormMemberAddr3').val( $('#memberAddr3').val() );
  		$('.orderForm').find('.orderFormMemberName').val( $('#memberName').val() );
  		$('.orderForm').find('.orderFormMemberMail').val( sessionMemberMail );
  		$('.orderForm').find('.orderFormMoney').val( sessionMoney );
  		$('.orderForm').find('.orderFormPoint').val( sessionPoint );
  		
  		$('.infoTd').each(function(i,e){
  			let goodIdInput= `<input type="hidden" name= 'orders[`+i+`].goodId' value= '`+$(this).find("#goodId").val()+`'/>`                                     
  			let goodCountInput= `<input type="hidden" name= 'orders[`+i+`].goodCount' value= '`+$(this).find("#goodCount").val()+`'/>`                                     
  			$('.orderForm').append(goodIdInput);
  			$('.orderForm').append(goodCountInput);
  			///
  		});//infoTd
  	
  		
  			 $('.orderForm').submit(); 
  		}//else
  	});//orderBtn
  	
  	// point, addr, name,( goodId, count,) indexinput 
  	
	
		
		

	
	
	

	
	
	</script>




</body>
</html>
