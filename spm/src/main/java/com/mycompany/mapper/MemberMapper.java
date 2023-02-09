package com.mycompany.mapper;

import com.mycompany.model.MemberVO;

public interface MemberMapper {

	//회원가입동작
	public int memberJoin(MemberVO vo);

	//메일중복체크
	public int memberMailDupCheck(String memberMail);
	
	//로그인작동
	public MemberVO memberLogin(MemberVO vo);

	
	
}//cls
