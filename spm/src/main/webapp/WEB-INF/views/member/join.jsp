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
				<br /> <span class="memberMailInputRe0">메일주소를 입력해주세요</span> <span class="memberMailInputRe1">이미 존재합니다</span> <br />
				<button id="memberMailCertBtn" type="button">인증번호 전송</button>
				<br />
				<input type="text" id="memberMailCert" placeholder="인증번호" />
				<br /> <span class="memberMailCertRe"></span>

			</div>
			<br />

			<div>
				<input type="text" id="memberPw" name="memberPw" placeholder="사용할 비밀번호" />
				<br /> <span class="memberPwInputRe0">비밀번호를 입력해주세요</span> 
			</div>
			<br />

			<div>
				<input type="text" id="memberPwCk" name="memberPwCk" placeholder="사용할 비밀번호 확인" />
				<br /> <span class="memberPwCkInputRe0">비밀번호확인을 입력해주세요</span> <span class="memberPwCkInputRe1">일치하지않습니다</span> 
			</div>
			<br />

			<div>
				<input type="text" id="memberName" name="memberName" placeholder="닉네임" />
				<br /> <span class="memberNameInputRe0">닉네임을 입력해주세요</span>

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
				<br /> <span class="memberAddr3InputRe0">상세주소를 입력해주세요</span>
			</div>
			<br />

			<button id="doneBtn" type="button">완료</button>
		</form>
	</div>







	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>




	<script>
		$("span").css('display', 'none');

		var code = ""; //메일전송인증번호저장용 코드

		var memberMailCheck = false;
		var memberMailDupCheck = false; //메일중복
		var memberMailCertCheck = false; //메일 인증번호
		var memberPwCheck = false;
		var memberPwCkCheck = false; //비번확인
		var memberPwCorCheck = false; //비번 비번확인 일치
		var memberNameCheck = false;
		var memberAddr3Check = false;

		/* 완료버튼동작 */
		$(document)
				.ready(
						function() {
							$("#doneBtn")
									.on(
											"click",
											function() {

												let memberMail = $(
														'#memberMail').val();
												let memberPw = $('#memberPw')
														.val();
												let memberPwCk = $(
														'#memberPwCk').val();
												let memberName = $(
														'#memberName').val();
												let memberAddr3 = $(
														'#memberAddr3').val();

												/* 기본 입력했는지체크들 */
												if (memberMail == '') {
													$('.memberMailInputRe0')
															.css('display',
																	'block');
													memberMailCheck = false;
												} else {
													$('.memberMailInputRe0')
															.css('display',
																	'none');
													memberMailCheck = true;
												}
												if (memberPw == '') {
													$('.memberPwInputRe0').css(
															'display', 'block');
													memberPwCheck = false;
												} else {
													$('.memberPwInputRe0').css(
															'display', 'none');
													memberPwCheck = true;
												}
												if (memberPwCk == '') {
													$('.memberPwCkInputRe0')
															.css('display',
																	'block');
													memberPwCkCheck = false;
												} else {
													$('.memberPwCkInputRe0')
															.css('display',
																	'none');
													memberPwCkCheck = true;
												}
												if (memberName == '') {
													$('.memberNameInputRe0')
															.css('display',
																	'block');
													memberNameCheck = false;
												} else {
													$('.memberNameInputRe0')
															.css('display',
																	'none');
													memberNameCheck = true;
												}
												if (memberAddr3 == '') {
													$('.memberAddr3InputRe0')
															.css('display',
																	'block');
													memberAddr3Check = false;
												} else {
													$('.memberAddr3InputRe0')
															.css('display',
																	'none');
													memberAddr3Check = true;
												}

												/* 최종검사 */
												if (memberMailCheck
														&& memberMailDupCheck
														&& memberMailCertCheck
														&& memberPwCheck
														&& memberPwCkCheck
														&& memberPwCorCheck
														&& memberNameCheck
														&& memberAddr3Check) {
													$("#joinForm").submit();
												}
											
												return false;

											});//jobtn
						});//docredy

		/* 메일중복검사 */
		$('#memberMail')
				.on("propertychange change keyup paste input",
						function() {
							let memberMail = $('#memberMail').val();
							let data = {
								memberMail : memberMail
							};

							$.ajax({
										type : 'post',
										url : '/member/memberMailDupCheck',
										data : data,
										success : function(result) {

											if (result != 'fail') {
												$(".memberMailInputRe1").css(
														"display", "none");
												memberMailDupCheck = true;
											} else {
												$(".memberMailInputRe1").css(
														"display",
														"inline-block");
												memberMailDupCheck = false;
											}
										}//scs
										,
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
												alert('Unknow Error.n'
														+ x.responseText);
											}
										} //err
									})
						});//mmal.prpchng

		/* 입력 메일 형식 유효성 검사 */
		function mailFormCheck(memberMail) {
			var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
			return form.test(memberMail);
		}

		/* 인증번호이메일전송 */
		$("#memberMailCertBtn").on("click", function() {

			let memberMail = $("#memberMail").val();
			let memberMailCertInput = $("#memberMailCert");
			let memberMailCertRe = $(".memberMailCertRe");

			if (mailFormCheck(memberMail)) {
				memberMailCertRe.html("메일이 전송되었습니다, 확인해주세요");
				memberMailCertRe.css("display", "inline-block");
			} else {
				memberMailCertRe.html("올바르지못한 메일형식입니다");
				memberMailCertRe.css("display", "inline-block");
				return false;
			}

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
			let memberMailCertRe = $(".memberMailCertRe");

			if (memberMailCert == code) {
				memberMailCertRe.html("인증번호 일치");
				memberMailCertCheck = true;
			} else {
				memberMailCertRe.html("인증번호 불일치");
				memberMailCertCheck = false;
			}

		});

		/* 비번 비번확인일치검사 */
		$('#memberPwCk').on("propertychange change keyup paste input",
				function() {

					let memberPw = $('#memberPw').val();
					let memberPwCk = $('#memberPwCk').val();

					$(".memberPwCkInputRe0").css('display', 'none');

					if (memberPw == memberPwCk) {
						$(".memberPwCkInputRe1").css('display', 'none');
						$(".memberPwCkInputRe2").css('display', 'block');
						memberPwCorCheck = true;
					} else {
						$(".memberPwCkInputRe1").css('display', 'block');
						$(".memberPwCkInputRe2").css('display', 'none');
						memberPwCorCheck = false;
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

		}//exdamaddr
	</script>



</body>
</html>