package com.mycompany.service;

import com.mycompany.model.MemberVO;

public interface MemberService {

	// �����ߺ�üũ
	public int memberMailDupCheck(String memberMail);

	// ȸ�����Ե���
	public int memberJoin(MemberVO vo);


	//�α����۵�
	public MemberVO memberLogin(MemberVO vo);
	
	/*ȸ������*/
	public MemberVO getMemberInfo(String memberMail);





}//class
