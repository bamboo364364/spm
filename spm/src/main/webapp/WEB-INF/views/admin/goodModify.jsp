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
<title>goodModify</title>

<style>

</style>
</head>
<body>
		<%@include file="../includes/adminHeader.jsp" %>
		
	<div class="imageWrap"> 
	<img>
	<button class= 'imgDeleteBtn btn'>x</button>
	</div>

	 
	<form class='enrollForm' action="/admin/goodModify" method='post'>
	<input type="hidden" name='goodId' value='${good.goodId}' />
        <div class="custom-file">
            <input type="file" class="custom-file-input form-control" id="fileInput">
            <label class="custom-file-label" for="customFile">파일선택</label>
        </div>
        <input class='fileName' value='${good.imageList[0].fileName}' type='hidden' name='imageList[0].fileName'>
		<input class='uuid' value='${good.imageList[0].uuid}' type='hidden' name='imageList[0].uuid'>
		<input class='uploadPath' value='${good.imageList[0].uploadPath}' type='hidden' name='imageList[0].uploadPath'>
    


	<table class='table' id='goodListTable'>
	<thead>
		<tr>
			<th scope='col'>상품명</th>
			<th scope='col'>상품분류</th>
			<th scope='col'>상품메이커</th>
			<th scope='col'>등록일자</th>
			<th scope='col'>평점</th>
			<th scope='col'>상품할인</th>
			<th scope='col'>상품가격</th>
			<th scope='col'>상품재고</th>
			
		</tr>
	</thead>
		
		<tr>
			<td><input id='goodName' name='goodName' class="form-control input" type="text" value="<c:out value='${good.goodName}'/>"/>
			<span class='goodNameWarn'></span>
			</td>
			<td>
			<input id='cateShow' class="form-control" type="text" readonly="readonly" value="<c:out value='${good.cateName}'/>"/>
			<select id="cate1" class='form-select input'><option selected value="none">대분류</option></select>
			<select id="cate2" class='form-select input'><option selected value="none">중분류</option></select>
			<select id="cate3" class='form-select input'  name="cateCode"><option selected value="${good.cateCode}">${good.cateName}</option></select>
			<span class='cateCodeWarn'></span>
			</td>
			<td><input id='goodMaker' name='goodMaker' class="form-control input"  type="text" value="<c:out value='${good.goodMaker}'/>"/>
			<span class='goodMakerWarn'></span>
			</td>
			<td><input id='regDate' readonly="readonly" class="form-control input"  type="text" value="<fmt:formatDate value='${good.regDate}' pattern='yyyy-MM-dd HH:ss'/>"/>
			<span style='color:green'>수정불가</span>
			</td>
			<td><input id='ratingAvg' readonly="readonly" class="form-control input"  type="text" value="<c:out value='${good.ratingAvg}'/>"/>
			<span style='color:green'>수정불가</span>
			</td>
			<td><input id='goodDiscountShow'  class="form-control input"  type="text" value="<c:out value='${good.goodDiscount}'/>"/>
			<input type="hidden" id='goodDiscount' name='goodDiscount'/>
			<span class='goodDiscountWarn'></span>
			</td>
			<td><input id='goodPrice' name='goodPrice' class="form-control input"  type="text" value="<fmt:formatNumber value='${good.goodPrice}' pattern='#,###'/>"/>
			<span class='goodPriceWarn'></span>
			</td>
			<td><input id='goodStock' name='goodStock' class="form-control input"  type="text" value="<c:out value='${good.goodStock}'/>"/>
			<span class='goodStockWarn'></span>
			</td>
			
		</tr>
		
	</table>

	
		
  <b>상품상세</b>
  <textarea id='goodContents' name='goodContents' class="form-control input">${good.goodContents}</textarea>
  <span class='goodContentsWarn'></span><br />
  
  	<input type="hidden" name="keyword" value='${cri.keyword}'>
    <input type="hidden" name="pageNum" value='${cri.pageNum}'>
    <input type="hidden" name="amount" value='${cri.amount}'>
    <input type="hidden" name="type" value='${cri.type}'>
	</form>	 <!-- enrollForm -->
	
	<div class='btnArea'>
	<button class='btn-outline-primary btn enrollBtn'>등록</button>
	</div> 

	<script>
	
	sessionStorage.setItem('memberMail', '${member.memberMail}');
	var sessionMemberMail= sessionStorage.getItem('memberMail');
	
	var goodNameCheck= false;
	var cateCodeCheck= false;
	var goodPriceCheck= false;
	var goodStockCheck= false;
	var goodDiscountCheck= false;
	var goodMakerCheck= false;
	var goodContentsCheck= false;
	
	var imageWrap= $('.imageWrap');
	
	/* documentready */
	$(document).ready(function(){
		let uploadPath= $('.uploadPath').val();
		let uuid= $('.uuid').val();
		let fileName= $('.fileName').val();
		imageWrapInsert(uploadPath, uuid, fileName);
		
		inputCheck();
		
	});
	
	
	
	
	/* 공란체크함수 */
	var inputCheck= function(){
		if($('#goodName').val()){
			$('.goodNameWarn').css('color','green');
			$('.goodNameWarn').html('상품명 확인');
			goodNameCheck= true;
		}else{
			$('.goodNameWarn').css('color','red');
			$('.goodNameWarn').html('상품명을 입력해주세요');
			goodNameCheck= false;
		}
		if( $('#cate3').val()!= 'none'){
			$('.cateCodeWarn').css('color','green');
			$('.cateCodeWarn').html('카테고리 확인');
			cateCodeCheck= true;
		}else{
			$('.cateCodeWarn').css('color','red');
			$('.cateCodeWarn').html('카테고리를 입력해주세요');
			cateCodeCheck= false;
		}
		if( !isNaN( $('#goodPrice').val() )&& $('#goodPrice').val() ){
			$('.goodPriceWarn').css('color','green');
			$('.goodPriceWarn').html('상품가격 확인');
			goodPriceCheck= true;
		}else{
			$('.goodPriceWarn').css('color','red');
			$('.goodPriceWarn').html('숫자를 입력해주세요');
			goodPriceCheck= false;
		}
		
		let goodDiscountShow= $("#goodDiscountShow");
		let goodDiscount= $("#goodDiscount");
		let goodDiscountWarn = $(".goodDiscountWarn");
		
		let discountRate = goodDiscountShow.val();	// 사용자가 입력한 할인값
		let sendDiscountRate = discountRate / 100;	//서버전송할할인값
		let goodsPrice = $("#goodPrice").val();		// 원가
		let discountPrice = goodsPrice * (1 - sendDiscountRate);   // 할인가격
		
		if(!isNaN(discountRate)&& discountRate){
			goodDiscountWarn.css('color','green');	
			goodDiscountWarn.html(`할인가격:`+ discountPrice);		
			goodDiscount.val(sendDiscountRate);
			goodDiscountCheck= true;
		}else{
			goodDiscountWarn.css('color','red');
			goodDiscountWarn.html(`숫자를입력해주세요`);
			goodDiscount.val('');
			goodDiscountCheck= false;
		}
		if( !isNaN( $('#goodStock').val() )&& $('#goodStock').val() ){
			$('.goodStockWarn').css('color','green');
			$('.goodStockWarn').html('상품재고 확인');
			goodStockCheck= true;
		}else{
			$('.goodStockWarn').css('color','red');
			$('.goodStockWarn').html('숫자를 입력해주세요');
			goodStockCheck= false;
		}
		if( $('#goodMaker').val() ){
			$('.goodMakerWarn').css('color','green');
			$('.goodMakerWarn').html('메이커명 확인');
			goodMakerCheck= true;
		}else{
			$('.goodMakerWarn').css('color','red');
			$('.goodMakerWarn').html('메이커명을 입력해주세요');
			goodMakerCheck= false;
		}
		if($('#goodContents').val()){
			$('.goodContentsWarn').css('color','green');
			$('.goodContentsWarn').html('상세정보 확인');
			goodContentsCheck= true;
		}else{
			$('.goodContentsWarn').css('color','red');
			$('.goodContentsWarn').html('상세정보를 입력해주세요');
			goodContentsCheck= false;
		}
		
	}
	
	
	/* 카테고리 */
	let cateList = JSON.parse('${cv}');
		
	let cate1Array = new Array();
	let cate2Array = new Array();
	let cate3Array = new Array();
	let cate1Obj = new Object();
	let cate2Obj = new Object();
	let cate3Obj = new Object();
	
	let cateSelect1 = $("#cate1");		
	let cateSelect2 = $("#cate2");
	let cateSelect3 = $("#cate3");
	
	/* 카테고리 배열 초기화 메서드 */
	function makeCateArray(obj,array,cateList, tier){
		for(let i = 0; i < cateList.length; i++){
			if(cateList[i].tier === tier){
				obj = new Object();
				
				obj.cateName = cateList[i].cateName;
				obj.cateCode = cateList[i].cateCode;
				obj.cateParent = cateList[i].cateParent;
				
				array.push(obj);				
				
			}
		}
	}//makeCateArray
	
	/* 배열 초기화 */
	makeCateArray(cate1Obj,cate1Array,cateList,1);
	makeCateArray(cate2Obj,cate2Array,cateList,2);
	makeCateArray(cate3Obj,cate3Array,cateList,3);
	
	/* 대분류 <option> 태그 */
	for(let i = 0; i < cate1Array.length; i++){
		cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>" + cate1Array[i].cateName + "</option>");
	}
	
	/* 중분류 <option> 태그 */
	$(cateSelect1).on("change",function(){
		
		let selectVal1 = $(this).find("option:selected").val();	
		
		cateSelect2.children().remove();
		cateSelect3.children().remove();
		
		cateSelect2.append("<option value='none'>중분류</option>");
		cateSelect3.append("<option value='none'>소분류</option>");
		
		for(let i = 0; i < cate2Array.length; i++){
			if(selectVal1 === cate2Array[i].cateParent){
				cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");	
			}
		}
		
	});
	
	/* 소분류 <option>태그 */
	$(cateSelect2).on("change",function(){
		
		let selectVal2 = $(this).find("option:selected").val();
		
		cateSelect3.children().remove();
		
		cateSelect3.append("<option value='none'>소분류</option>");		
		
		for(let i = 0; i < cate3Array.length; i++){
			if(selectVal2 === cate3Array[i].cateParent){
				cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");	
			}
		}	
		
	});	
	/* cateShow */
	$(cateSelect3).on('change', function(){
		$('#cateShow').val($('#cate3 option:selected').text());
	});
	
	$('.input').on("propertychange change keyup paste input", function(){
		inputCheck();
	});
	$('.input').on("change", function(){
		inputCheck();
	});
	
	
	
	/* enrollBtn동작 */
	$('.enrollBtn').click(function(){
		if(goodNameCheck&&cateCodeCheck&&goodPriceCheck&&goodDiscountCheck&&
			goodPriceCheck&&goodMakerCheck&&goodStockCheck&&goodContentsCheck){
			$('.enrollForm').submit(); 
		}else{
			alert('다시 입력해주세요');
		}
	});
	
	/* x버튼 동작 */
	$('.imgDeleteBtn').click(function(){
		deleteFile();
	});
	
	/* 이미지 삽입 함수  */
	var imageWrapInsert= function(uploadPath, uuid, fileName){
		$('.uploadPath').val(uploadPath);
		$('.uuid').val(uuid);
		$('.fileName').val(fileName);
		if(uploadPath){  
		let fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
		imageWrap.find("img").attr('src', '/display?fileName=' + fileCallPath);
	} else {
		imageWrap.find("img").attr('src', '/resources/img/goodsNoImage.png'); 
	}	
	}
	
	
	
	/* 이미지 업로드 */
	$("#fileInput").on("change", function(e){
		 console.log($(this)[0].files[0]);
		 
		/* 이미지 존재시 삭제 */
		if($('.uploadPath').val()){
			deleteFile();
		}
		
		let formData = new FormData();
		let fileInput = $(this);
		let fileList = fileInput[0].files;
		let fileObj = fileList[0] ;
		
		if(!fileCheck(fileObj.name, fileObj.size)){
			return false;
		}
		
		formData.append("uploadFile", fileObj);
		
		$.ajax({
			url: '/admin/uploadAjaxAction',
	    	processData : false,
	    	contentType : false,
	    	data : formData,
	    	type : 'POST',
	    	dataType : 'json',
	    	success : function(result){
	    		console.log(result);
	    		if(!result || result.length == 0){return}
	    		imageWrapInsert(result[0].uploadPath, result[0].uuid, result[0].fileName);
	    	},
	    	error : function(result){
	    		alert("이미지 파일이 아닙니다.");
	    	}
		});		

		
	}); //imgUpload
	
		
	/* var, method related with attachFile */
	let regex = new RegExp("(.*?)\.(jpg|png|jpeg)$");
	let maxSize = 1048576; //1MB	
	
	function fileCheck(fileName, fileSize){

		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
			  
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		
		return true;		
		
	}	
	
	
	
	
	

	
	/* 파일 삭제 메서드 */
	function deleteFile(){
if(!$('.uploadPath').val()){return false;}
	let targetFile = encodeURIComponent($('.uploadPath').val()+ "/s_" + $('.uuid').val() + "_" + $('.fileName').val());

		
		$.ajax({
			url: '/admin/deleteFile',
			data : {fileName : targetFile},
			dataType : 'text',
			type : 'POST',
			success : function(result){
				console.log(result);
				imageWrapInsert();
				
				$('#fileInput').val('');
				
			},
			error : function(result){
				console.log(result);
				
				alert("파일을 삭제하지 못하였습니다.")
			}
		});
	}
	

</script>
	



</body>
</html>
