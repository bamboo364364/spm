package com.mycompany.mapper;

import java.util.List;

import com.mycompany.model.Criteria;
import com.mycompany.model.ReplyDTO;
import com.mycompany.model.UpdateReplyDTO;

public interface ReplyMapper {

	/* 리플 등록 */
	public int replyEnroll(ReplyDTO dto);	
	
	/* 리플 존재 체크 */
	public Integer checkReply(ReplyDTO dto);	
	
	/* 리플 페이징 */
	public List<ReplyDTO> replyList(Criteria cri);
	
	/* 리플 수정 */
	public void replyModify(ReplyDTO dto);
	
	
	
	
	
	
}
