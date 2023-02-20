package com.mycompany.service;

import java.util.List;

import com.mycompany.model.Criteria;
import com.mycompany.model.GoodVO;
import com.mycompany.model.ReplyDTO;

public interface ReplyService {


/* 리플 등록 */
	public int replyEnroll(ReplyDTO dto);

/* 리플 페이징 */
	public List<ReplyDTO> replyList(Criteria cri);
	
	/* 리플 수정 */
	public void replyModify(ReplyDTO dto);
	
	/* 리플삭제 */
	public void replyDelete(ReplyDTO dto);
	
	/* 리리플 등록 */
	public void rReplyEnroll(ReplyDTO dto);
	
	/* 리리플뒤에있는 replyId 밀어주기 */
	public void pushReplyId(int replyId);


	/* 리플수(페이지계산) */
	public int replyGetTotal(ReplyDTO dto);
	
	
	
	
	
	
	
	
	
	
	
	
	
}
