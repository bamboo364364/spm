package com.mycompany.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.mapper.MemberMapper;
import com.mycompany.model.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;

	// 메일중복체크
	@Override
	public int memberMailDupCheck(String memberMail) {
		return memberMapper.memberMailDupCheck(memberMail);
	};

	// 회원가입동작
	@Override
	public int memberJoin(MemberVO vo){
		return memberMapper.memberJoin(vo);
	};
	
	//로그인작동
	@Override
	public MemberVO memberLogin(MemberVO vo){
	return memberMapper.memberLogin(vo);
	};
	
	/*회원정보*/
	@Override
	public MemberVO getMemberInfo(String memberMail){
	return memberMapper.getMemberInfo(memberMail);
	};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}// class
