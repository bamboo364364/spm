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
<title>goodDetail</title>

<style>

</style>
</head>
<body>

	<%@include file="./includes/header.jsp" %>
	<div class='container'>	
	<div class='row'>
	<div class="imageWrap col-4" goodId="${good.imageList[0].goodId}"
	 path="${good.imageList[0].uploadPath}"
	 uuid="${good.imageList[0].uuid}" fileName="${good.imageList[0].fileName}">
	<img class='img-fluid' alt="Responsive image">		
	</div>
	<div class='form-group col-8'><p></p>
	 
	<div class="form-group col-sm-3">
        <div class="input-group"> <span class="input-group-addon">가격</span>
            <input id='salePriceInput' type="text" class="form-control" readonly='readonly' value='${oid.salePrice}' data-saleprice='${oid.salePrice}'/>
        </div>                                                                                              
    </div>
	 
	 <div class="center">
	<p></p>
	 <div class="input-group">
	     <span class="input-group-btn">
	     <button type="button" class="btn btn-outline-primary btn-number"  data-type="minus" data-field="quant[2]">
	     <span class="glyphicon glyphicon-minus"></span>
	     </button>
	 </span>
	 <input type="text" name="quant[2]" class="form-control input-number" value="1" min="1" max="${good.goodStock}">
	  <span class="input-group-btn">
	  <button type="button" class="btn btn-outline-primary btn-number" data-type="plus" data-field="quant[2]">
	     <span class="glyphicon glyphicon-plus"></span>
	 </button>
	 </span>
	     </div>
	<p></p>
	</div>

	</div>
	  
	</div>
	</div>
	</div>
	
	<table class='table' id='goodTable'>
	<thead>
		<tr>
			<th scope='col'>상품명</th>
			<th scope='col'>상품분류</th>
			<th scope='col'>상품메이커</th>
			<th scope='col'>등록일자</th>
			<th scope='col'>평점</th>
			<th scope='col'>상품할인률</th>
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
			<td><input class="form-control" readonly="readonly" type="text" value="<c:out value='${good.goodDiscount*100}%'/>"/></td>
			<td><input class="form-control" readonly="readonly" type="text" value="<fmt:formatNumber value='${good.goodPrice}' pattern='#,###'/>"/></td>
			<td><input class="form-control" readonly="readonly" type="text" value="<c:out value='${good.goodStock}'/>"/></td>
		</tr>
		
	</table>
	
	<b>상품상세</b>
  <textarea rows='16' readonly="readonly" class="form-control">${good.goodContents}</textarea>
	
	<div>
	<button class='btn btn-outline-success' id='cartBtn'>카트에담기</button>
	<button class='btn btn-outline-success' id='buyBtn'>바로구매</button>
	<c:if test='${member != null}'>
	<button class='btn btn-outline-info' id='replyBtn'>리뷰작성</button><br /><br />
	</c:if>
	</div>
	
	
	
	<div class='border row' id='replyDiv'>
	
	</div>
	
	
	

		<!--리플 페이지 이동 인터페이스 -->
		<div class="pageMakeWrap">
			<ul class="pageMaker">

				<!-- 이전 버튼 -->
				<c:if test="${pageMaker.prev }">
					<li class="pageMakerBtn prev"><a
						href="${pageMaker.pageStart -1}">이전</a></li>
				</c:if>

				<!-- 페이지 번호 -->
				<c:forEach begin="${pageMaker.pageStart }"
					end="${pageMaker.pageEnd }" var="num">
					<li
						class="btn btn-outline-light pageMakerBtn ${pageMaker.cri.pageNum == num ? 'active':''}">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>

				<!-- 다음 버튼 -->
				<c:if test="${pageMaker.next}">
					<li class="pageMakerBtn next"><a
						href="${pageMaker.pageEnd + 1 }">다음</a></li>
				</c:if>
			</ul>
		</div>
				
				
				
	

	<script>
	sessionStorage.setItem('memberMail', '${member.memberMail}');
	var sessionMemberMail= sessionStorage.getItem('memberMail');
	
	
		/*리플 페이지 이동 버튼 */
 $(document).on('click','.pageMakerBtn a', function(e){
	
	e.preventDefault();
	
	
	replyHtmlInit($(this).attr("href"), ${pageMaker.cri.amount});
	

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
	
	
	
	 var quantity= $('#quantityInput').val() ;
	$('#plusBtn').click(function(){
		
		$('#quantityInput').val(++quantity)
		});
		
		
		$("#minusBtn").click(function(){
	if(quantity > 1){
		$("#quantityInput").val(--quantity);	
		}
	}); 
	
	

	$(document).on('ready',function(){

		replyHtmlInit();
	});
	

	
	
	$('#replyBtn').on('click', function(){

 	let url='/replyWrite/${good.goodId}?memberMail='+sessionMemberMail+'&relevel=0';
 
 	window.open(url, "replyWrite","width = 500, height = 500, top = 100, left = 200, location = no");
		
	}); 
	

	/* 리플생성지시함수 */
	var replyHtmlInit= function(pageNum, amount){
		
		let form={
			goodId: ${goodId},
			pageNum: pageNum,
			amount: amount
		}
		
		$.ajax({
				url : '/replyList',
				type : 'post',
				async : false,
				data : JSON.stringify(form),
				contentType : "application/json;charset=UTF-8",
				dataType : 'json',
				success : function(result) {
					replyHtmlMake(result); 
					/* alert("완료 replyHtmlInit"); */
						
				
				},	
				error : function(x, e) {
					if (x.status == 0) {
						alert('You are offline!!n Please Check Your Network.');
					} else if (x.status == 404) {
						alert('Requested URL not found.');
					} else if (x.status == 500) {
						alert('Internel Server Error.');
					} else if (e == 'parsererror') {
						alert('Error.nParsing JSON Request failed.');
					} else if (e == 'timeout') {
						alert('Request Time out.');
					} else {
						alert('Unknow Error.n' + x.responseText);
					}
				}
			}); //ajax
	}//replyHtmlInit
		
	
	/* 리플생성함수 */
	var replyHtmlMake= function(result){
		
		let html= ''
		
		$.each(result, function(i, obj){
		/* `+String((obj.relevel)*5)+` */
			html+=` 
			<div class='ps-3 border col-7 offset-`+String((obj.relevel))+`'>
			<div id='reply' class='`+obj.relevel+`' memberMail= '`+obj.memberMail+`' replyId='`+obj.replyId+`' rating='`+obj.rating+`' replyContent='`+obj.replyContent+`'>
	
	<form class="form-inline" role="form">
	<div class="row">`
	if(obj.relevel==0){
				html+= `
    <div class="form-group col-sm-3">
        <div class="input-group"> <span class="input-group-addon">평점</span>
            <input type="text" class="form-control" readonly='readonly' value= '`+obj.rating+`' />
        </div>
    </div>
		`}
		html+=`
    <div class="form-group col-sm-3">
        <div class="input-group"> <span class="input-group-addon">작성자</span>
            <input type="text" class="form-control" readonly='readonly' value= '`+obj.memberName+`' />
        </div>
    </div>
    <div class="form-group col-sm-3">
        <div class="input-group"> <span class="input-group-addon">작성일</span>
            <input type="text" class="form-control" readonly='readonly' value= '`+obj.regDate+`' />
        </div>
    </div>
    	<div class="form-group col-sm-12 mt-3">
    	<div class='input-group'>
      		<textarea readonly="readonly" class="form-control">`+obj.replyContent+`</textarea>
 		</div>
      	</div>
  </div> </form>

			
			<button type='button' class='btn btn-outline-primary' id='modBtn'>수정</button><button class='btn btn-outline-danger' id='delBtn'>삭제</button> <button class='btn btn-outline-info' id='repBtn'>댓글달기</button>
			
			
			</div>
			</div>
			`
	
		});//each
		
		$('#replyDiv').html(html);
		
	}; //replyHtmlMake
	
	
	
	/* 리플수정 */
	$(document).on('click','#modBtn', function(e){
		
		e.preventDefault();
		
		
		
		if( $(this).parent().attr('memberMail')== sessionMemberMail )
		{ 
			let url='/replyModify/${good.goodId}?replyId='+$(this).parent().attr('replyId')+'&memberMail='+sessionMemberMail+'&rating='+ $(this).parent().attr('rating') + '&replyContent=' +$(this).parent().attr('replyContent')+ '&relevel='+ $(this).parent().attr('class')        
		                                                                                                                  
 	window.open(url, "replyModify","width = 500, height = 500, top = 100, left = 200, location = no");
				}else{alert('작성자가 아닙니다');}
		

	});//modBtn
	
	
	/* 리플삭제 */
	
	$(document).on('click','#delBtn', function(e){
		
		let replyId= $(this).parent().attr('replyId');
		let tRelevel= $(this).parent().attr('class');
		let ntReplyId= $( `.`+tRelevel ).eq( $( `.`+tRelevel ).index( $(this).parent() )+ 1  ).attr('replyId');
		let form= {
				replyId: replyId,
				ntReplyId: ntReplyId,
				goodId: ${good.goodId}
		}
		if( $(this).parent().attr('memberMail')== sessionMemberMail ){
		$.ajax({
				url : '/replyDelete',
				type : 'post',
				async : false,
				data : JSON.stringify(form),
				contentType : "application/json;charset=UTF-8",
				dataType : 'json',
				success : function() {
					alert('리플삭제 완료');
					replyHtmlInit();
			
				
				},	
				error : function(x, e) {
					if (x.status == 0) {
						alert('You are offline!!n Please Check Your Network.');
					} else if (x.status == 404) {
						alert('Requested URL not found.');
					} else if (x.status == 500) {
						alert('Internel Server Error.');
					} else if (e == 'parsererror') {
						alert('Error.nParsing JSON Request failed.');
					} else if (e == 'timeout') {
						alert('Request Time out.');
					} else {
						alert('Unknow Error.n' + x.responseText);
					}
				}
			});  //ajax
			
		}//if
		else{alert('작성자가 아닙니다')}
		
		
	}); 
	
	
	/* 리리플 */
	
	$(document).on('click','#repBtn', function(){
	if(!sessionMemberMail){alert('로그인해주세요') }else{
	
	let pRelevel= $(this).parent().attr('class');
	let rRelevel= String( parseInt( pRelevel )+ 1 );
	let pReplyId= $(this).parent().attr('replyId');
	let rReplyId= '0'; 
	let npReplyId= $(this).parent().nextAll( `.`+ pRelevel ).first().attr('replyId');
	
	if(!npReplyId){ 
		if( !$(this).parent().next().attr('replyId') ){rReplyId= pReplyId ;} 
		else{ rReplyId= $(this).parent().nextAll().last().attr('replyId'); } 
	}//if!npReplyId
	else{
		
	let gRelevel= parseInt(pRelevel)- 1 ;
	let ngReplyId= '0';
	
	if(gRelevel< 0){ngReplyId= parseInt(npReplyId)-1 }
	else{ngReplyId= parseInt( $(this).parent().nextAll( `.`+ gRelevel ).first().attr('replyId') );}
	
	if(npReplyId> ngReplyId){rReplyId= String( parseInt(npReplyId)+1 ) ;} //
	else{
		if( $(this).parent().nextAll( `.`+ rRelevel ).last().attr('replyId') ){
		rReplyId= $(this).parent().nextAll( `.`+ rRelevel ).last().attr('replyId')  ;}
		else{rReplyId= pReplyId;}	
	}
	
	}//else npReplyId
	
	
	
	
	
	
	
	let url= '/rReplyWrite/'+ ${good.goodId}+ '?rReplyId='+ rReplyId+ '&memberMail='+ sessionMemberMail+ '&rRelevel='+ rRelevel;          
  
		window.open(url, "rReplyWrite","width = 500, height = 500, top = 100, left = 200, location = no");
	
	
	}//else sessionMail
	
	});//repBtn
	
	
	//카트에담기 버튼
	$('#cartBtn').click(function(){
		console.log('cartBtn')
		
		if(! sessionMemberMail){
			alert('로그인해주세요')
			return false;
		}
		if( parseInt( $('#quantityInput').val() )> ${good.goodStock} ){alert('재고부족') }else{
		
		let form={
			goodId: ${good.goodId},
			memberMail: sessionMemberMail,
			goodCount: $('.input-number').val(),
			goodStock: $('.input-number').attr('max')
		}
		
		$.ajax({
				url : '/cart/add',
				type : 'post',
				async : false,
				data : JSON.stringify(form),
				contentType : "application/json;charset=UTF-8",
				dataType : 'json',
				success : function(result) {
					alert("카트에 추가했습니다");
				},	
				error : function(x, e) {
					if (x.status == 0) {
						alert('You are offline!!n Please Check Your Network.');
					} else if (x.status == 404) {
						alert('Requested URL not found.');
					} else if (x.status == 500) {
						alert('Internel Server Error.');
					} else if (e == 'parsererror') {
						alert('Error.nParsing JSON Request failed.');
					} else if (e == 'timeout') {
						alert('Request Time out.');
					} else {
						alert('Unknow Error.n' + x.responseText);
					}
				}
			}); 
		} 
	});
		
		
	$('.btn-number').click(function(e){
    e.preventDefault();
    
    fieldName = $(this).attr('data-field');
    type      = $(this).attr('data-type');
    var input = $("input[name='"+fieldName+"']");
    var currentVal = parseInt(input.val());
    if (!isNaN(currentVal)) {
        if(type == 'minus') {
            
            if(currentVal > input.attr('min')) {
                input.val(currentVal - 1).change();
            } 
            if(parseInt(input.val()) == input.attr('min')) {
                $(this).attr('disabled', true);
            }

        } else if(type == 'plus') {

            if(currentVal < input.attr('max')) {
                input.val(currentVal + 1).change();
            }
            if(parseInt(input.val()) == input.attr('max')) {
                $(this).attr('disabled', true);
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
    
    let count= $('.input-number').val(); 
    $('#salePriceInput').val($('#salePriceInput').data('saleprice')*count );
    
    
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
