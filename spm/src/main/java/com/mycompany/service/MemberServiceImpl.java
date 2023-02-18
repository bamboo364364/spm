package com.mycompany.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.mapper.MemberMapper;
import com.mycompany.model.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper memberMapper;

	// �����ߺ�üũ
	@Override
	public int memberMailDupCheck(String memberMail) {
		return memberMapper.memberMailDupCheck(memberMail);
	};

	// ȸ�����Ե���
	@Override
	public int memberJoin(MemberVO vo){
		return memberMapper.memberJoin(vo);
	};
	
	//�α����۵�
	@Override
	public MemberVO memberLogin(MemberVO vo){
	return memberMapper.memberLogin(vo);
	};
	
	/*ȸ������*/
	@Override
	public MemberVO getMemberInfo(String memberMail){
	return memberMapper.getMemberInfo(memberMail);
	};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}// class
