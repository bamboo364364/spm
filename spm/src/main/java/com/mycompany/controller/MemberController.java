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

	/* ȸ������ ������ */
	@GetMapping("/join")
	public void joinGet() {
		logger.info("ȸ������������ ����");
	}

	/* ȸ�������۵� */
	@PostMapping("/join")
	public String joinPOST(MemberVO vo) throws Exception {

		String rawPw = ""; // ���ڵ� �� ��й�ȣ
		String encodePw = ""; // ���ڵ� �� ��й�ȣ

		rawPw = vo.getMemberPw(); // ��й�ȣ ������ ����
		encodePw = pwEncoder.encode(rawPw); // ��й�ȣ ���ڵ�
		vo.setMemberPw(encodePw); // ���ڵ��� ��й�ȣ member��ü�� �ٽ� ����

		/* ȸ������ ���� ���� */
		memberService.memberJoin(vo);

		return "redirect:/";

	}

	/* �����ߺ��˻� */
	@PostMapping("/memberMailDupCheck")
	@ResponseBody
	public String mailDupCheckPost(String memberMail) throws Exception {
		logger.info("mailDupCheckPost�޼�������");
		int result = memberService.memberMailDupCheck(memberMail);
		if (result != 0) {
			return "fail"; // �ߺ�����o
		} else {
			return "success";
		}
	}// maldupck

	/* �������� */
	@GetMapping("/mailCert")
	@ResponseBody
	public String mailCertGet(String memberMail) {
		logger.info("��������Ȯ��");
		logger.info("����:" + memberMail);

		/* ������ȣ(����) ���� */
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		logger.info("������ȣ " + checkNum);

		/* �̸��� ������ */
		String setFrom = "asd19974@naver.com";
		String toMail = memberMail;
		String title = "ȸ������ ���� �̸��� �Դϴ�.";
		String content = "Ȩ�������� �湮���ּż� �����մϴ�." + "<br><br>" + "���� ��ȣ�� " + checkNum + "�Դϴ�." + "<br>"
				+ "�ش� ������ȣ�� ������ȣ Ȯ�ζ��� �����Ͽ� �ּ���.";

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

	/* �α��������� */
	@GetMapping("/login")
	public void memberLoginGet() {
		logger.info("�α��������� ����");
	}
	
	/* �α����۵� */
	@PostMapping("/login")
	public String memberLoginPOST(HttpServletRequest request, MemberVO vo, RedirectAttributes rttr) throws Exception {

		HttpSession session = request.getSession();
		String rawPw = "";
		String encodePw = "";

		MemberVO lvo = memberService.memberLogin(vo); // �����Ѿ��̵�� ��ġ�ϴ� ���� �ִ���

		if (lvo != null) { // ��ġ�ϴ� ���� �����

			rawPw = vo.getMemberPw(); // ����ڰ� ������ ��й�ȣ
			encodePw = lvo.getMemberPw(); // �����ͺ��̽��� ������ ���ڵ��� ��й�ȣ

			if (true == pwEncoder.matches(rawPw, encodePw)) { // ��й�ȣ ��ġ���� �Ǵ�

				lvo.setMemberPw(""); // ���ڵ��� ��й�ȣ ���� ����
				session.setAttribute("member", lvo); // session�� ������� ���� ����
				return "redirect:/"; // ���������� �̵�

			} else {

				rttr.addFlashAttribute("result", 0);
				logger.info("���Ȯ��!!!!!!!");
				return "redirect:/member/login"; // �α��� �������� �̵�
				

			}

		} else { // ��ġ�ϴ� ���̵� �������� ���� �� (�α��� ����)

			rttr.addFlashAttribute("result", 0);
			logger.info("����Ȯ��!!!!!!!");
			return "redirect:/member/login"; // �α��� �������� �̵�

		}

	}//lginzkdn
	
	/* �α׾ƿ��۵�.Ȩ������ */
	@PostMapping("/logoutHome")
	@ResponseBody
	public void logoutHomePost(HttpServletRequest request) throws Exception{
		logger.info("logoutHomePost�޼��� ����");
		HttpSession session= request.getSession();
		session.invalidate();
	
		
	}
	
	/* �α׾ƿ��۵�.Ȩ�������ƴѵ��� */
	@GetMapping("/logoutRedirect")
	public String logoutHomeGet(HttpServletRequest request) throws Exception{
		logger.info("logoutHomePost�޼��� ����");
		HttpSession session= request.getSession();
		session.invalidate();
		return "redirect:/";
		
	}
	
	/* ���̷��̵� */
	
	
	
	
	
	
	
	
	

}// class
