package com.mycompany.mapper;

import java.util.List;

import com.mycompany.model.AttachImageVO;
import com.mycompany.model.CateVO;
import com.mycompany.model.Criteria;
import com.mycompany.model.GoodVO;

public interface AdminMapper {

	/* ī�װ� ����Ʈ */
	public List<CateVO> cateList();
	
	/* ������ ��¥ �̹��� ����Ʈ */
	public List<AttachImageVO> checkFileList();
	
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
	
	/* ��ǰ�� �̹����߰� */
	public List<AttachImageVO> getAttachInfo(int goodId);
	
	/* �̹��� ��� */
	public void imageEnroll(AttachImageVO vo);
	
	/* ���� ��ǰ �̹��� ��ü ���� */
	public void deleteImageAll(int goodId);
	
	
	


}//class
