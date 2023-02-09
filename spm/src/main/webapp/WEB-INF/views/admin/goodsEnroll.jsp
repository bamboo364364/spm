<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>goodsEnroll</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous">
	
</script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

</head>
<body>
	<p>상품등록 페이지입니다</p>

	<%@include file="../includes/adminHeader.jsp" %>
	<div id="center" style="text-align: center">
	<form id="goodsEnrollForm" action="/admin/goodsEnroll" method="post">
		<input id="goodName" name="goodName" type="text" placeholder="상품명" />
		<p id="goodNameWarn"></p>
		<p>대분류</p><select id="cate1"><option selected value="none">선택</option></select>
		<p>중분류</p><select id="cate2"><option selected value="none">선택</option></select>
		<p>소분류</p><select id="cate3" name="cateCode"><option selected value="none">선택</option></select>
		<p id="cateCodeWarn"></p><br />
		<input id="goodPrice" name="goodPrice" type="text" placeholder="가격" />
		<p id="goodPriceWarn"></p>
		<input id="goodStock" name="goodStock" type="text" placeholder="재고" />
		<p id="goodStockWarn"></p>
		<input id="goodDiscountShow" type="text" placeholder="할인율" />
		<input id="goodDiscountSend" name="goodDiscount" type="hidden"/>
		<p id="goodDiscountInfo"></p>
		<p id="goodDiscountWarn"></p>
		<input id="goodMaker" name="goodMaker" type="text" placeholder="메이커"/> 
		<p id="goodMakerWarn"></p><br />
		<label>상세정보</label>
		<div id="goodContentsDiv">
		<textarea name="goodContents" id="goodContents"></textarea>
		<p id="goodContentsWarn"></p>
		</div>
		
		<label>상품 이미지</label>
		<input type="file" id ="fileItem" name='uploadFile'><br /><br />
          <button type="button" id="enrollBtn">등록</button>  
          </div>  			
	</form>
	

	
</div>

<script src="https://cdn.ckeditor.com/ckeditor5/26.0.0/classic/ckeditor.js"></script>
<script>

var goodNameCheck= false;
var cateCodeCheck= false;
var goodPriceCheck= false;
var goodStockCheck= false;
var goodDiscountCheck= false;
var goodMakerCheck= false;
var goodContentsCheck= false;


/* 위지윅 적용 */
 
	/* 상세정보 */
	ClassicEditor
		.create(document.querySelector('#goodContents'))
		.catch(function(error){
			console.error(error);
		});
		
		$("#enrollBtn").on("click", function(){
			if($("#goodName").val()){
				$("#goodNameWarn").html("");
				goodNameCheck= true;
			}else{
				$("#goodNameWarn").html("상품명을 입력해주세요");
				goodNameCheck= false;
			}
			
			if($("#cate3").val()!='none'){
				$("#cateCodeWarn").html("");
				cateCodeCheck= true;
			}else{
				$("#cateCodeWarn").html("카테고리선택해주세요");
				cateCodeCheck= false;
			}
			
			if($("#goodPrice").val()){
				$("#goodPriceWarn").html("");
				goodPriceCheck= true;
			}else{
				$("#goodPriceWarn").html("상품가격을 입력해주세요");
				goodPriceCheck= false;
			}
			
			if($("#goodStock").val()){
				$("#goodStockWarn").html("");
				goodStockCheck= true;
			}else{
				$("#goodStockWarn").html("상품재고를 입력해주세요");
				goodStockCheck= false;
			}
			
			if($("#goodDiscountSend").val()){
				$("#goodDiscountWarn").html("");
				goodDiscountCheck= true;
			}else{
				$("#goodDiscountWarn").html("상품할인율을 입력해주세요");
				goodDiscountCheck= false;
			}
			
			if($("#goodMaker").val()){
				$("#goodMakerWarn").html("");
				goodMakerCheck= true;
			}else{
				$("#goodMakerWarn").html("메이커명을 입력해주세요");
				goodMakerCheck= false;
			}
			
			if($("#goodContentsDiv").html()!= '<br data-cke-filler="true">'){
				$("#goodContentsWarn").html("");
				goodContentsCheck= true;
			}else{
				$("#goodContentsWarn").html("상세정보를 입력해주세요");
				goodContentsCheck= false;
			}
			
			if(goodNameCheck&&cateCodeCheck&&goodPriceCheck&&goodStockCheck&&goodDiscountCheck&&goodMakerCheck&&goodContentsCheck){
				$("#enrolllForm").submit();
			}else{
				return false;
			}
		});//enrlbtn
		
		
		
	/* 카테고리 */
	let cateList = JSON.parse('${cateList}');
		
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
	}//fncmkctarr	
	
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
		
		cateSelect2.append("<option value='none'>선택</option>");
		cateSelect3.append("<option value='none'>선택</option>");
		
		for(let i = 0; i < cate2Array.length; i++){
			if(selectVal1 === cate2Array[i].cateParent){
				cateSelect2.append("<option value='"+cate2Array[i].cateCode+"'>" + cate2Array[i].cateName + "</option>");	
			}
		}// for
		
	});//cs1
	
	/* 소분류 <option>태그 */
	$(cateSelect2).on("change",function(){
		
		let selectVal2 = $(this).find("option:selected").val();
		
		cateSelect3.children().remove();
		
		cateSelect3.append("<option value='none'>선택</option>");		
		
		for(let i = 0; i < cate3Array.length; i++){
			if(selectVal2 === cate3Array[i].cateParent){
				cateSelect3.append("<option value='"+cate3Array[i].cateCode+"'>" + cate3Array[i].cateName + "</option>");	
			}
		}// for		
		
	});	//cs2
	
	
	/* 할인율 Input 설정 */
	
	$("#goodDiscountShow").on("propertychange change keyup paste input", function(){
		console.log("할인율작동");
		let goodDiscountShow= $("#goodDiscountShow");
		let goodDiscountSend= $("#goodDiscountSend");
		let goodDiscountInfo = $("#goodDiscountInfo");
		
		
		let discountRate = goodDiscountShow.val();					// 사용자가 입력한 할인값
		let sendDiscountRate = discountRate / 100;			//서버전송할할인값
		let goodsPrice = $("#goodPrice").val();			// 원가
		let discountPrice = goodsPrice * (1 - sendDiscountRate);		// 할인가격
		
		if(!isNaN(discountRate)){
			goodDiscountInfo.html(`할인가격:`+ discountPrice);		
			goodDiscountSend.val(sendDiscountRate);				
		}else{
			goodDiscountInfo.html(`숫자를입력해주세요`);
			goodDiscountSend.val('');
		}
	
	});	//diCPRCF
	
	
	
	/* 이미지 업로드 */
	$("input[type='file']").on("change", function(e){
		
		/* 이미지 존재시 삭제 */
		if($(".imgDeleteBtn").length > 0){
			deleteFile();
		}
		
		let formData = new FormData();
		let fileInput = $('input[name="uploadFile"]');
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];
		
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
	    		showUploadImage(result);
	    	},
	    	error : function(result){
	    		alert("이미지 파일이 아닙니다.");
	    	}
		});		

		
	});
		
	/* var, method related with attachFile */
	let regex = new RegExp("(.*?)\.(jpg|png)$");
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
	
	
	/* 이미지 출력 */
	function showUploadImage(uploadResultArr){
		
		/* 전달받은 데이터 검증 */
		if(!uploadResultArr || uploadResultArr.length == 0){return}
		
		let uploadResult = $("#uploadResult");
		
		let obj = uploadResultArr[0];
		
		let str = "";
		
		let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
		//replace 적용 하지 않아도 가능
		//let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
		
		str += "<div id='result_card'>";
		str += "<img src='/display?fileName=" + fileCallPath +"'>";
		str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
		str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
		str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
		str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";		
		str += "</div>";		
		
   		uploadResult.append(str);     
        
	}	
	
	
	/* 이미지 삭제 버튼 동작 */
	$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
		
		deleteFile();
		
	});
	
	/* 파일 삭제 메서드 */
	function deleteFile(){
		
		let targetFile = $(".imgDeleteBtn").data("file");
		
		let targetDiv = $("#result_card");
		
		$.ajax({
			url: '/admin/deleteFile',
			data : {fileName : targetFile},
			dataType : 'text',
			type : 'POST',
			success : function(result){
				console.log(result);
				
				targetDiv.remove();
				$("input[type='file']").val("");
				
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