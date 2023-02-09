package com.mycompany.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mycompany.model.MemberVO;
import com.mycompany.service.MemberService;

@Controller
@RequestMapping(value = "/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private BCryptPasswordEncoder pwEncoder;

	/* 회원가입 페이지 */
	@GetMapping("/join")
	public void joinGet() {
		logger.info("회원가입페이지 진입");
	}

	/* 회원가입작동 */
	@PostMapping("/join")
	public String joinPOST(MemberVO vo) throws Exception {

		String rawPw = ""; // 인코딩 전 비밀번호
		String encodePw = ""; // 인코딩 후 비밀번호

		rawPw = vo.getMemberPw(); // 비밀번호 데이터 얻음
		encodePw = pwEncoder.encode(rawPw); // 비밀번호 인코딩
		vo.setMemberPw(encodePw); // 인코딩된 비밀번호 member객체에 다시 저장

		/* 회원가입 쿼리 실행 */
		memberService.memberJoin(vo);

		return "redirect:/";

	}

	/* 메일중복검사 */
	@PostMapping("/memberMailDupCheck")
	@ResponseBody
	public String mailDupCheckPost(String memberMail) throws Exception {
		logger.info("mailDupCheckPost메서드진입");
		int result = memberService.memberMailDupCheck(memberMail);
		if (result != 0) {
			return "fail"; // 중복메일o
		} else {
			return "success";
		}
	}// maldupck

	/* 메일인증 */
	@GetMapping("/mailCert")
	@ResponseBody
	public String mailCertGet(String memberMail) {
		logger.info("메일전송확인");
		logger.info("메일:" + memberMail);

		/* 인증번호(난수) 생성 */
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		logger.info("인증번호 " + checkNum);

		/* 이메일 보내기 */
		String setFrom = "asd19974@naver.com";
		String toMail = memberMail;
		String title = "회원가입 인증 이메일 입니다.";
		String content = "홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "인증 번호는 " + checkNum + "입니다." + "<br>"
				+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

		String num = Integer.toString(checkNum);

		return num;
	}// malCeert

	/* 로그인페이지 */
	@GetMapping("/login")
	public void memberLoginGet() {
		logger.info("로그인페이지 진입");
	}
	
	/* 로그인작동 */
	@PostMapping("/login")
	public String memberLoginPOST(HttpServletRequest request, MemberVO vo, RedirectAttributes rttr) throws Exception {

		HttpSession session = request.getSession();
		String rawPw = "";
		String encodePw = "";

		MemberVO lvo = memberService.memberLogin(vo); // 제출한아이디와 일치하는 메일 있는지

		if (lvo != null) { // 일치하는 메일 존재시

			rawPw = vo.getMemberPw(); // 사용자가 제출한 비밀번호
			encodePw = lvo.getMemberPw(); // 데이터베이스에 저장한 인코딩된 비밀번호

			if (true == pwEncoder.matches(rawPw, encodePw)) { // 비밀번호 일치여부 판단

				lvo.setMemberPw(""); // 인코딩된 비밀번호 정보 지움
				session.setAttribute("member", lvo); // session에 사용자의 정보 저장
				return "redirect:/"; // 메인페이지 이동

			} else {

				rttr.addFlashAttribute("result", 0);
				logger.info("비번확인!!!!!!!");
				return "redirect:/member/login"; // 로그인 페이지로 이동
				

			}

		} else { // 일치하는 아이디가 존재하지 않을 시 (로그인 실패)

			rttr.addFlashAttribute("result", 0);
			logger.info("메일확인!!!!!!!");
			return "redirect:/member/login"; // 로그인 페이지로 이동

		}

	}//lginzkdn
	
	/* 로그아웃작동.홈페이지 */
	@PostMapping("/logoutHome")
	@ResponseBody
	public void logoutHomePost(HttpServletRequest request) throws Exception{
		logger.info("logoutHomePost메서드 진입");
		HttpSession session= request.getSession();
		session.invalidate();
	
		
	}
	
	/* 로그아웃작동.홈페이지아닌데서 */
	@GetMapping("/logoutRedirect")
	public String logoutHomeGet(HttpServletRequest request) throws Exception{
		logger.info("logoutHomePost메서드 진입");
		HttpSession session= request.getSession();
		session.invalidate();
		return "redirect:/";
		
	}
	
	/* 마이룸이동 */
	
	
	
	
	
	
	
	
	

}// class
