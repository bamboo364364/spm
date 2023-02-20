package com.mycompany.service;

import java.util.List;

import com.mycompany.model.Criteria;
import com.mycompany.model.GoodVO;
import com.mycompany.model.ReplyDTO;

public interface ReplyService {


/* ���� ��� */
	public int replyEnroll(ReplyDTO dto);

/* ���� ����¡ */
	public List<ReplyDTO> replyList(Criteria cri);
	
	/* ���� ���� */
	public void replyModify(ReplyDTO dto);
	
	/* ���û��� */
	public void replyDelete(ReplyDTO dto);
	
	/* ������ ��� */
	public void rReplyEnroll(ReplyDTO dto);
	
	/* �����õڿ��ִ� replyId �о��ֱ� */
	public void pushReplyId(int replyId);


	/* ���ü�(���������) */
	public int replyGetTotal(ReplyDTO dto);
	
	
	
	
	
	
	
	
	
	
	
	
	
}
