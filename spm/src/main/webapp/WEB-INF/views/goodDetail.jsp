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
			<a id="logout">로그아웃</a> <a href="/member/admin/myroom/${member.memberMail}">마이룸</a>
			<a href="/cart/${member.memberMail}">장바구니</a><br />
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
	<button id='cateBtn'>장바구니에 담기</button> <br /><br />
	<button id='buyBtn'>바로 구매</button>
	</div>

	
	
	
	<div id='box4'>상품상세 </div>
	<div>${good.goodContents}</div><br />
	
	
	<c:if test='${member != null}'>
	<button id='replyBtn'>리뷰작성</button><br /><br />
	</c:if>
	

	
	<div id='replyDiv'>
	</div>
	

	<script>
	sessionStorage.setItem('memberMail', '${member.memberMail}');
	var sessionMemberMail= sessionStorage.getItem('memberMail');
	
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
	$(document).ready(function(){

		replyHtmlInit();
		
	});
	
	
	
	$('#replyBtn').on('click', function(){

 let url='/replyWrite/${good.goodId}?memberMail='+sessionMemberMail+'&relevel=0';
 
 window.open(url, "replyWrite","width = 500, height = 500, top = 100, left = 200, location = no");
		
	}); //replyBtn
	

	/* 리플생성지시함수 */
var replyHtmlInit= function(){
		
		let form={
			goodId: ${goodId}	
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
			relevel= '`+obj.relevel+`' memberMail= '`+obj.memberMail+`' replyId='`+obj.replyId+`' rating='`+obj.rating+`' replyContent='`+obj.replyContent+`'>                                 
			리플번호: '`+obj.replyId+`'<br />
			작성자: '`+obj.memberMail+`' <br />
			작성일: '`+obj.regDate+`' <br />
			평점: '`+obj.rating+`' <br />
			`+obj.replyContent+`<br />
			<button id='modBtn'>수정</button><button id='delBtn'>삭제</button> 
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
		
		
		
		
		
	
	
		
		
	
	
	
	
	</script>
	



</body>
</html>
