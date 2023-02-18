package com.mycompany.service;

import java.util.List;

import javax.mail.Session;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.controller.ReplyController;
import com.mycompany.mapper.ReplyMapper;
import com.mycompany.model.Criteria;
import com.mycompany.model.ReplyDTO;

@Service
public class ReplyServiceImpl implements ReplyService {

	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);


@Autowired
private ReplyMapper replyMapper;


/* 리플 등록 */
@Override
	public int replyEnroll(ReplyDTO dto){
	return replyMapper.replyEnroll(dto);
	};


/* 리플 페이징 */
@Override
	public List<ReplyDTO> replyList(Criteria cri){
	return replyMapper.replyList(cri);
	}
	
	
/* 리플 수정 */
@Override
	public void replyModify(ReplyDTO dto){
	replyMapper.replyModify(dto);
	
	};

/* 리플삭제 */
@Override
	public void replyDelete(ReplyDTO dto){
	
	replyMapper.replyDelete(dto);
	
	}
	
	
	/* 리리플 등록 */
	@Override
	public void rReplyEnroll(ReplyDTO dto){
	replyMapper.rReplyEnroll(dto);
	}
	
	/* 리리플뒤에있는 replyId 밀어주기 */
	@Override
	public void pushReplyId(int replyId){
	replyMapper.pushReplyId(replyId);
	}
	


	/* 리플수(페이지계산) */
	@Override
	public int replyGetTotal(int goodId){
	return replyMapper.replyGetTotal(goodId);
	}







}//class
