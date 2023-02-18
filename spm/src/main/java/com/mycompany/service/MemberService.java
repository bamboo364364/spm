package com.mycompany.service;

import com.mycompany.model.MemberVO;

public interface MemberService {

	// 메일중복체크
	public int memberMailDupCheck(String memberMail);

	// 회원가입동작
	public int memberJoin(MemberVO vo);


	//로그인작동
	public MemberVO memberLogin(MemberVO vo);
	
	/*회원정보*/
	public MemberVO getMemberInfo(String memberMail);





}//class
