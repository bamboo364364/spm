package com.mycompany.mapper;

import com.mycompany.model.MemberVO;

public interface MemberMapper {

	//ȸ�����Ե���
	public int memberJoin(MemberVO vo);

	//�����ߺ�üũ
	public int memberMailDupCheck(String memberMail);
	
	//�α����۵�
	public MemberVO memberLogin(MemberVO vo);

	
	
}//cls
