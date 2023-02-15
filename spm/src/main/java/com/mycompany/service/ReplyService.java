package com.mycompany.service;

import java.util.List;

import com.mycompany.model.Criteria;
import com.mycompany.model.ReplyDTO;

public interface ReplyService {


/* ���� ��� */
	public int replyEnroll(ReplyDTO dto);

/* ���� ����¡ */
	public List<ReplyDTO> replyList(Criteria cri);
	
	/* ���� ���� */
	public void replyModify(ReplyDTO dto);


}
