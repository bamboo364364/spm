package com.mycompany.mapper;

import java.util.List;

import com.mycompany.model.Criteria;
import com.mycompany.model.GoodVO;
import com.mycompany.model.ReplyDTO;

public interface ReplyMapper {

	/* 리플 등록 */
	public int replyEnroll(ReplyDTO dto);	
	
	/* 리플 존재 체크 */
	public Integer checkReply(ReplyDTO dto);	
	
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
	
	/* 리플수(평점계산) */
	public int rootReplyGetTotal(ReplyDTO dto);
	
	/* 평점계산get */
	public double ratingAvgGet(int goodId);
	
	/* 평점계산update */
	public void ratingAvgUpdate(GoodVO gv);
	
	/* 리플검색 */
	public ReplyDTO replySearch(ReplyDTO dto);
	
	
	/* 리플검색 여러개 */
	public List<ReplyDTO> replySearches(ReplyDTO dto);
	
	
	
	
}
