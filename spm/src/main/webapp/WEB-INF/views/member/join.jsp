<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous">
	
</script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

</head>
<body>

	<div>
		<p>회원가입</p>
		<p>회원정보를 입력해주세요</p>
		<form id="joinForm" action="/member/join" method="post">
			<div>
				<input type="text" id="memberMail" name="memberMail" placeholder="메일주소" />
				<br /> <div class="memberMailWarn"></div>
				
				<button id="memberMailCertBtn" type="button" disabled="disabled">인증번호 전송</button>
				<br />
				<input type="text" id="memberMailCert" placeholder="인증번호" disabled="disabled" />
				<br /> <div class="memberMailCertWarn"></div>

			</div>
			<br />

			<div>
				<input type="text" id="memberPw" name="memberPw" placeholder="사용할 비밀번호" />
				<br /> <div class="memberPwWarn"></div> 
			</div>
			<br />

			<div>
				<input type="text" id="memberPwCk" name="memberPwCk" placeholder="사용할 비밀번호 확인" />
				<br /> <div class="memberPwCkWarn"></div>
			</div>
			<br />

			<div>
				<input type="text" id="memberName" name="memberName" placeholder="이름" />
				<br /> <div class="memberNameWarn"></div>

			</div>
			<br />

			<div>
				<input type="text" id="memberAddr1" name="memberAddr1" readonly="readonly" />
				<br />
				<input type="text" id="memberAddr2" name="memberAddr2" readonly="readonly" />
				<br />
				<button type="button" onclick="executionDaumAddress()">주소찾기</button>
				<br />
				<input type="text" id="memberAddr3" name="memberAddr3" readonly="readonly" placeholder="거주지 주소 상세" />
				<br /> <div class="memberAddr3Warn"></div>
			</div>
			<br />

			<button id="doneBtn" type="button">완료</button>
		</form>
	</div>







	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>




	<script>
		

		var code = ""; //메일전송인증번호저장용 코드

		var memberMailCheck = false;
		/* var memberMailDupCheck = false; */  //메일중복
		var memberMailCertCheck = false; //메일 인증번호
		var memberPwCheck = false;
		var memberPwCkCheck = false;  //비번확인
		/* var memberPwCorCheck = false; */ //비번 비번확인 일치
		var memberNameCheck = false;
		var memberAddr3Check = false;

		/* 완료버튼동작(공란검사) */
		$(document).ready(function() {
				
				$('.memberMailWarn').css('color','red');
				$('.memberMailWarn').html('메일을 입력해주세요');
				
				$('.memberMailCertWarn').css('color','red');
				$('.memberMailCertWarn').html('인증번호를 입력해주세요');
						
				$('.memberPwWarn').css('color','red');
				$('.memberPwWarn').html('비밀번호를 입력해주세요');
				
				$('.memberPwCkWarn').css('color','red');
				$('.memberPwCkWarn').html('비밀번호확인을 입력해주세요');
				
				$('.memberNameWarn').css('color','red');
				$('.memberNameWarn').html('이름을 입력해주세요');
				
				$('.memberAddr3Warn').css('color','red');
				$('.memberAddr3Warn').html('주소를 입력해주세요');
				
				
				});//documentReady
				
				/* $('#memberMail').on("propertychange change keyup paste input",function(){
						if($('#memberMail').val() == '') {
							$('.memberMailWarn').css('color','red');
							$('.memberMailWarn').html('메일을 입력해주세요');
							memberMailCheck = false; 
						}
						});//propertyChange */
				
				$('#memberPw').on("propertychange change keyup paste input",function(){
						if($('#memberPw').val()) {
							$('.memberPwWarn').css('color', 'green');
							$('.memberPwWarn').html('비밀번호 입력확인');
							memberPwCheck = true;
						}else{
							$('.memberPwWarn').css('color','red');
							$('.memberPwWarn').html('비밀번호를 입력해주세요');
							memberPwCheck = false;
						}
						});//propertyChange
						
				$('#memberName').on("propertychange change keyup paste input",function(){
						if($('#memberName').val()) {
							$('.memberNameWarn').css('color', 'green');
							$('.memberNameWarn').html('이름 입력확인');
							memberNameCheck = true;
						}else{
							$('.memberNameWarn').css('color','red');
							$('.memberNameWarn').html('이름을 입력해주세요');
							memberNameCheck = false;
						}
						});//propertyChange
						
				$('#memberAddr3').on("propertychange change keyup paste input",function(){
						if($('#memberAddr3').val()) {
							$('.memberAddr3Warn').css('color', 'green');
							$('.memberAddr3Warn').html('주소 입력확인');
							memberAddr3Check = true;
						}else{
							$('.memberAddr3Warn').css('color','red');
							$('.memberAddr3Warn').html('주소를 입력해주세요');
							memberAddr3Check = false;
						}
						});//propertyChange
						
						
						
						
						
							
						
						

		/* 메일검사(형식 중복) */
		$('#memberMail').on("propertychange change keyup paste input",
						function() {
					
							let memberMail = $('#memberMail').val();
							
							let data = {memberMail : memberMail};
							
						
							
							
							//형식
							if( mailFormCheck(memberMail) ){
							
							$.ajax({
										type : 'post',
										url : '/member/memberMailDupCheck',
										data : data,
										success : function(result) {
											
									
											if (result != 'fail') {
												$('.memberMailWarn').css('color','green');
												$('.memberMailWarn').html('사용가능!');
												memberMailCheck = true; 
												$('#memberMailCertBtn').removeAttr('disabled');
											} else {
												$('.memberMailWarn').css('color','red');
												$('.memberMailWarn').html('이미 가입된 메일!');
												memberMailCheck = false;
												$('#memberMailCertBtn').attr('disabled', 'disabled');
												
											}
											}//sucess
									
										,
										error: function(x, e) {
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
												alert('Unknow Error.n'
														+ x.responseText);
											}
										} //err
									}); //ajx
									
							}//if
							else{
								$('.memberMailWarn').html('메일형식에 맞지않습니다');
								$('.memberMailWarn').css('color','red');
								$('#memberMailCertBtn').attr('disabled', 'disabled');
								memberMailCheck = false;
							}
				
						});//propertyChange

						
		/* 입력 메일 형식 유효성 검사 */
		function mailFormCheck(memberMail) {
			var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
			return form.test(memberMail);
		}

		/* 인증번호이메일전송 */
		$("#memberMailCertBtn").on("click", function() {
			$('#memberMailCert').removeAttr('disabled');
			$('.memberMailCertWarn').css('color','black');
      $('.memberMailCertWarn').html("인증번호가 발송되었습니다");
			let memberMail = $("#memberMail").val();
			let memberMailCert = $("#memberMailCert");
			

			$.ajax({
				type : 'get',
				url : '/member/mailCert?memberMail=' + memberMail,
				success : function(data) {
					/* console.log("data:" + data); */
					$("#memberMailCert").attr("disabled", false);
					code = data;
				}

			});//ajx

		});//malcrtbtn

		/* 메일 인증번호 비교 */
		$("#memberMailCert").blur(function() {

			let memberMailCert = $("#memberMailCert").val();
			let memberMailCertWarn = $(".memberMailCertWarn");

			if (memberMailCert == code && memberMailCert!='') {
				 memberMailCertWarn.css('color','green');
				memberMailCertWarn.html("인증번호 일치");
				memberMailCertCheck = true;
			} else {
				memberMailCertWarn.css('color','red');
				memberMailCertWarn.html("인증번호 불일치");
				memberMailCertCheck = false;
			}

		});

		/* 비번 비번확인일치검사 */
		$('#memberPwCk, #memberPw').on("propertychange change keyup paste input",
				function() {

					let memberPw = $('#memberPw').val();
					let memberPwCk = $('#memberPwCk').val();

					

					if (memberPw == memberPwCk) {
						$(".memberPwCkWarn").css('color', 'green');
						$(".memberPwCkWarn").html('일치합니다!');
						
						memberPwCkCheck = true;
					} else {
						$(".memberPwCkWarn").css('color', 'red');
						$(".memberPwCkWarn").html('불일치!');
						memberPwCkCheck = false;
					}
				}); 

		/* 다음주소연동 */

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
		
		//완료
		$('#doneBtn').on('click', function(){
			
			if(memberMailCheck&&memberMailCertCheck&&memberPwCheck&&memberPwCkCheck&&memberNameCheck&&memberAddr3Check){
				alert('회원가입 성공, 로그인해주세요');
				$('#joinForm').submit();
			}
			else{alert('다시 입력해주세요');
			}
		});
	</script>



</body>
</html>