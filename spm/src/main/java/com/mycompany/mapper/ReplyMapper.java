package com.mycompany.mapper;

import java.util.List;

import com.mycompany.model.Criteria;
import com.mycompany.model.GoodVO;
import com.mycompany.model.ReplyDTO;

public interface ReplyMapper {

	/* ���� ��� */
	public int replyEnroll(ReplyDTO dto);	
	
	/* ���� ���� üũ */
	public Integer checkReply(ReplyDTO dto);	
	
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
	
	/* ���ü�(�������) */
	public int rootReplyGetTotal(ReplyDTO dto);
	
	/* �������get */
	public double ratingAvgGet(int goodId);
	
	/* �������update */
	public void ratingAvgUpdate(GoodVO gv);
	
	/* ���ð˻� */
	public ReplyDTO replySearch(ReplyDTO dto);
	
	
	/* ���ð˻� ������ */
	public List<ReplyDTO> replySearches(ReplyDTO dto);
	
	
	
	
}
