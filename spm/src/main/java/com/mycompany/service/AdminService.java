package com.mycompany.service;

import java.util.List;

import com.mycompany.model.CateVO;
import com.mycompany.model.Criteria;
import com.mycompany.model.GoodVO;

public interface AdminService {

/* ī�װ� ����Ʈ */
	public List<CateVO> cateList();

	/* ��ǰ��� */
	public int goodEnroll(GoodVO vo);

	/* ��ǰ����Ʈ */
	public List<GoodVO> goodGetList(Criteria cri);
	
	/* ��ǰ����Ʈ ī��Ʈ */
	public int goodGetTotal(Criteria cri);
	
	/* ��ǰ�� */
	public GoodVO goodGetDetail(int goodId);
	
	/* ��ǰ���� */
	public int goodModify(GoodVO vo);
	
	/* ��ǰ���� */
	public int goodDelete(int goodId);
	



}//class
