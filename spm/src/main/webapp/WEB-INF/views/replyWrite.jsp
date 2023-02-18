<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>replyWrite</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous">
	
</script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<style>

</style>
</head>
<body>
<div>
	
	
	<select name="rating" id="rating">
	<option value="0">0</option>
	<option value="0.5">0.5</option>
	<option value="1">1</option>
	<option value="1.5">1.5</option>
	<option value="2">2</option>
	<option value="2.5">2.5</option>
	<option value="3">3</option>
	</select>
</div>
<div>
	<textarea name="replyContent" id="replyContent" cols="30" rows="10">
	
	</textarea>
</div>		



	<button id='replyEnrollBtn' type='button'>투고</button>

	

	<script>
	
	sessionStorage.setItem('memberMail', '${member.memberMail}');
	var sessionMemberMail= sessionStorage.getItem('memberMail');
	
	$(document).ready(function(){
		alert(sessionMemberMail);
	});
	
	$('#replyEnrollBtn').on('click',function(){
		alert('투고');
		
		let form={
			memberMail: sessionMemberMail,
			goodId: ${dto.goodId},
			relevel: ${dto.relevel},
			rating: $('#rating').val(),
			replyContent: $('#replyContent').val()
		}
		
		$.ajax({
				url : '/replyEnroll',
				type : 'post',
				async : false,
				data : JSON.stringify(form),
				contentType : "application/json;charset=UTF-8",
				dataType : 'json',
				success : function(result) {
					
					alert("완료");
					$(opener.location).attr("href", "javascript:replyHtmlInit();");	
				
					/* window.close(); */
			
 let close=   function(){
       window.open('', '_self').close();
       return false;
    }
				 close();
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

	}); 
	
	</script>
	




</body>
</html>
