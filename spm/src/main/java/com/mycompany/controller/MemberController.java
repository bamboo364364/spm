package com.mycompany.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

// @Autowired private MemberService memberservice; 

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private BCryptPasswordEncoder pwEncoder;

	// 회원가입
	@GetMapping("/join")
	public void joinGet() {
		logger.info("회원가입페이지 진입");
	}

	// 메일중복검사
	@PostMapping("/mailDupCheck")
	@ResponseBody
	public String mailDupCheckPost(String memberMail) throws Exception {
		logger.info("mailDupCheckPost() 진입");
		int result = memberService.mailDupCheck(memberMail);
		logger.info("결과값" + result);
		if (result != 0) {
			return "fail";
		} else {
			return "success"; // 중복메일x
		}
	}//maldupck

	
	
	
	
	
	
	
	
	
	
	
	
	
	
}// class
