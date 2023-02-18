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


/* ���� ��� */
@Override
	public int replyEnroll(ReplyDTO dto){
	return replyMapper.replyEnroll(dto);
	};


/* ���� ����¡ */
@Override
	public List<ReplyDTO> replyList(Criteria cri){
	return replyMapper.replyList(cri);
	}
	
	
/* ���� ���� */
@Override
	public void replyModify(ReplyDTO dto){
	replyMapper.replyModify(dto);
	
	};

/* ���û��� */
@Override
	public void replyDelete(ReplyDTO dto){
	
	replyMapper.replyDelete(dto);
	
	}
	
	
	/* ������ ��� */
	@Override
	public void rReplyEnroll(ReplyDTO dto){
	replyMapper.rReplyEnroll(dto);
	}
	
	/* �����õڿ��ִ� replyId �о��ֱ� */
	@Override
	public void pushReplyId(int replyId){
	replyMapper.pushReplyId(replyId);
	}
	


	/* ���ü�(���������) */
	@Override
	public int replyGetTotal(int goodId){
	return replyMapper.replyGetTotal(goodId);
	}







}//class
