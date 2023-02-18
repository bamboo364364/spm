<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goodDetail</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous">
	
</script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<style>
h1, #upNav {display: inline;}
#upNav {float: right;}
.red{color:red;}
#box1, #box2, #box3{float: left; margin-right: 20%; margin-bottom: 30%;}
#box4{clear:both;}
</style>
</head>
<body>
	<h1><a href="/">쇼핑몰</a></h1>
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
	</div>

	<br /><br />
	<div class="imageWrap" goodId="${good.imageList[0].goodId}"
	 path="${good.imageList[0].uploadPath}"
	 uuid="${good.imageList[0].uuid}" fileName="${good.imageList[0].fileName}">
	<img></div>			
	
	<div id='box1'>
	<div id="goodId">상품명</div>
	<div class="red">${good.goodId}</div><br />
	<div id="goodId">상품분류</div>
	<div class="red">${good.cateCode}</div><br />
	<div id="goodId">상품메이커</div>
	<div class="red">${good.goodMaker}</div><br />
	<div id="goodId">등록일자</div>
	<div class="red"><fmt:formatDate value='${good.regDate}'
	pattern="yyyy-MM-dd"/></div><br />
	<div id="goodId">평점</div>
	<div class="red">${good.ratingAvg}</div><br />
	</div>
	<div id="box2">
	<div id="goodId">상품할인(%)</div>
	<div class="red">${good.goodDiscount}</div><br />
	<div id="goodId">상품가격</div>
	<div class="red"><del>${good.goodPrice}</del>
	<span style='color:blue;'><fmt:formatNumber value='114514' pattern="#,###" /></span>
	</div><br />
	<div id="goodId">적립포인트</div>
	<div class="red">point</div><br />
	<div id="goodId">상품재고</div>
	<div class="red">${good.goodStock}</div><br />
	</div>
	<div id='box3'>
	주문수량
	<input type="text" id="quantityInput" value="1">
		<button id="plusBtn">+</button>
		<button id="minusBtn">-</button><br /><br />
	<button id='cartBtn'>카트에 담기</button> <br /><br />
	<button id='buyBtn'>바로 구매</button>
	</div>
	
	<script>
	var quantity= $('#quantityInput').val() ;
	$('#plusBtn').click(function(){
		
		$('#quantityInput').val(++quantity)
		});
		
		
		$("#minusBtn").click(function(){
	if(quantity > 1){
		$("#quantityInput").val(--quantity);	
		}
	});
	</script>
	
	
	

	
	
	
	<div id='box4'>상품상세 </div>
	<div>${good.goodContents}</div><br />
	
	
	<c:if test='${member != null}'>
	<button id='replyBtn'>리뷰작성</button><br /><br />
	</c:if>
	

	
	<div id='replyDiv'>
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
								class="pageMakerBtn ${pageMaker.cri.pageNum == num ? 'active':''}">
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
	

	
	
	
/* 	$('#moveForm').submit(); */
 
/* 	replyHtmlInit(); */

	
});//pageMaker
	
	
	
	
	
	
	
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
	
	
	
	
	/* 페이지리로드리플보여주기 */
	$(document).on('ready',function(){

		replyHtmlInit();
	
	});
	

	
	
	$('#replyBtn').on('click', function(){

 let url='/replyWrite/${good.goodId}?memberMail='+sessionMemberMail+'&relevel=0';
 
 window.open(url, "replyWrite","width = 500, height = 500, top = 100, left = 200, location = no");
		
	}); //replyBtn
	

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
					alert("완료 replyHtmlInit");
						
				
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
		
			html+= `<div id='reply' style='border: 1px solid black;'
			class='`+obj.relevel+`' relevel= '`+obj.relevel+`' memberMail= '`+obj.memberMail+`' replyId='`+obj.replyId+`' rating='`+obj.rating+`' replyContent='`+obj.replyContent+`'>                                 
			리플번호: '`+obj.replyId+`'<br />
			작성자: '`+obj.memberMail+`' <br />
			작성일: '`+obj.regDate+`' <br />
			평점: '`+obj.rating+`' <br />
			리레벨: '`+obj.relevel+`'<br />
			`+obj.replyContent+`<br />
			<button id='modBtn'>수정</button><button id='delBtn'>삭제</button> <button id='repBtn'>댓글달기</button>
			</div> `
	
		});//each
		
		$('#replyDiv').html(html);
		
	}; //replyHtmlMake
	
	
	
	/* 리플수정 */
	$(document).on('click','#modBtn', function(e){
		
		e.preventDefault();
		
		alert('modBtn');
		
		if( $(this).parent().attr('memberMail')== sessionMemberMail )
		{let url='/replyModify/${good.goodId}?replyId='+$(this).parent().attr('replyId')+'&memberMail='+sessionMemberMail+'&relevel=0&rating='+$(this).parent().attr('rating')+ '&replyContent=' +$(this).parent().attr('replyContent')                      
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
				ntReplyId: ntReplyId			
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
					alert('replyDeleteBtnSuc');
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
		
		
	}); //delBtn
	
	
	/* 리리플 */
	
	$(document).on('click','#repBtn', function(){
		
	alert('리리플');
	/* let pRelevel=String( parseInt( $(this).parent().attr('class'))+ 1 ) ;
	alert(pRelevel);

	alert(typeof(pRelevel));
	
	alert( $(this).parent().prev(`.`+pRelevel).attr('replyId') );  */
	let pRelevel= $(this).parent().attr('class');
	let rRelevel= String( parseInt( pRelevel )+ 1 );
	let pReplyId= $(this).parent().attr('replyId');
	let rReplyId= '0'; 
	let npReplyId= $( `.`+pRelevel ).eq( $( `.`+pRelevel ).index( $(this).parent() )+ 1  ).attr('replyId');
	
	let gRelevel= parseInt(pRelevel)- 1 ;
	/* let gReplyId= $( `.`+pRelevel ).eq( $( `.`+pRelevel ).index( $(this).parent() )+ 1  ).attr('replyId'); */
	
	
	let ngReplyId= $(this).parent().nextAll( `.`+ gRelevel ).first().attr('replyId');
	alert('시'+ngReplyId); 
	/* alert( '인접'+ $( `.`+pRelevel ).eq( $( `.`+pRelevel ).index( $(this).parent() )+ 1  ).attr('replyId') ) */
	/* let gRelevel= String( (parseInt(pRelevel)- 1) ); */
	
	/* alert( '는'+ $(`.`+gRelevel).eq(`.`+gRele) ) */
	
	         
 	 
	
	if(npReplyId){if( parseInt(gRelevel)< 0  ||  parseInt(npReplyId)> parseInt(ngReplyId) ){
		rReplyId= String( parseInt(npReplyId) +1 );
		alert('1은'+rReplyId)
		
		
	}} else{
		rReplyId= String( parseInt(pReplyId) );
		alert('2는'+rReplyId)
	} 
	
	let url= '/rReplyWrite/'+ ${good.goodId}+ '?rReplyId='+ rReplyId+ '&memberMail='+ sessionMemberMail+ '&rRelevel='+ rRelevel;          
     alert('?') 	
		window.open(url, "rReplyWrite","width = 500, height = 500, top = 100, left = 200, location = no");
	
	
	
	

	
	/* let url=
'/rReplyWrite/${good.goodId}?rReplyId='+rReplyId+'&memberMail='+sessionMemberMail+'&rRelevel='+rRelevel ;          
 	window.open(url, "rReplyWrite","width = 500, height = 500, top = 100, left = 200, location = no");  */

	/* $(".class").eq( $(".class").index( $(element) ) + 1 ) */
	
	});//repBtn
	
	
	
	$('#cartBtn').click(function(){
		console.log('cartBtn')
		
		if(! sessionMemberMail){
			alert('로그인해주세요')
			return false;
		}
		
		let form={
			goodId: ${good.goodId},
			memberMail:  sessionMemberMail,
			goodCount: $('#quantityInput').val()
		}
		alert('goodId'+${good.goodId}+'memberMail'+ sessionMemberMail+'quan'+$('#quantityInput').val())
		
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
			}); //ajax
		
	}); //cartBtn
		
		
	
		
	
		
	
	
		
		
	
	
	
	
	</script>
	



</body>
</html>
