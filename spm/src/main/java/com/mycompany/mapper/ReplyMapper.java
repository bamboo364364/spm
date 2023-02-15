package com.mycompany.mapper;

import java.util.List;

import com.mycompany.model.Criteria;
import com.mycompany.model.ReplyDTO;
import com.mycompany.model.UpdateReplyDTO;

public interface ReplyMapper {

	/* ���� ��� */
	public int replyEnroll(ReplyDTO dto);	
	
	/* ���� ���� üũ */
	public Integer checkReply(ReplyDTO dto);	
	
	/* ���� ����¡ */
	public List<ReplyDTO> replyList(Criteria cri);
	
	/* ���� ���� */
	public void replyModify(ReplyDTO dto);
	
	
	
	
	
	
}
