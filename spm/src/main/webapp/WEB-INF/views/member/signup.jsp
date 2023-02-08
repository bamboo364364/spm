<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signup</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous">
	
</script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<style>
/* span{display: none}; */
</style>
</head>
<body>

	<div>
		<p>회원가입</p>
		<p>회원정보를 입력해주세요</p>
		<form>
			<div id="mail">
				<input type="text" id="mail" name="mail" placeholder="메일주소" /> <br />
				<span class="mailInputRe0">메일주소를 입력해주세요</span> <span
					class="mailInputRe1">이미 존재합니다</span> <span class="mailInputRe2">사용가능</span>
				<br />
				<button id="mailCertBtn" type="button">인증번호 전송</button>
				<br /> <input type="text" id="mailCert" placeholder="인증번호" /> <br />
				<span class="mailCertRe0">인증번호를 입력해주세요</span> <span
					class="mailCertRe2">인증성공</span>
			</div>
			<br />

			<div id="memberPw">
				<input type="text" id="memberPw" name="memberPw"
					placeholder="사용할 비밀번호d" /> <br /> <span class="memberPwInputRe0">비밀번호를
					입력해주세요</span> <span class="memberPwInputRe1">형식에 맞지않습니다</span> <span
					class="memberPwInputRe2">사용가능</span>
			</div>
			<br />

			<div id="memberPwCk">
				<input type="text" id="memberPwCk" name="memberPwCk"
					placeholder="사용할 비밀번호 확인" /> <br /> <span
					class="memberPwCkInputRe0">비밀번호확인을 입력해주세요</span> <span
					class="memberPwCkInputRe1">일치하지않습니다</span> <span
					class="memberPwCkInputRe2">일치</span>
			</div>
			<br />

			<div id="memberAddr">
				<input type="text" id="memberAddr1" name="memberAddr1"
					readonly="readonly" /> <br /> <input type="text" id="memberAddr2"
					name="memberAddr2" readonly="readonly" /> <br /> <input
					type="text" id="memberAddr3" name="memberAddr3"
					placeholder="거주지 주소 상세" /> <br /> <span
					class="memberPwCkInputRe0">상세주소를 입력해주세요</span>
			</div>
			<br />

			<button type="button">완료</button>
		</form>
	</div>



	<!-- 인증버튼 동작  -->
	<script>
		$("#mailCertBtn").on("click", function() {
			var email = $("#mail").val();
			var mailCertBox = $("#mailCert");

			if (mailFormCheck(email)){
				
			}

		});//

		
		/* 입력 이메일 형식 유효성 검사 */
		function mailFormCheck(email) {
			var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
			return form.test(email);
		}
	</script>




	<!-- 완료버튼 동작  -->
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		var code = "";
	</script>



</body>
</html>