package com.mycompany.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.model.Criteria;
import com.mycompany.model.ReplyDTO;
import com.mycompany.service.AdminService;
import com.mycompany.service.ReplyService;


@Controller
public class ReplyController {

	@Autowired
	AdminService adminService;
	@Autowired
	ReplyService replyService;
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	/* ��������¡ */
	@PostMapping("/replyList")
	@ResponseBody
	public List<ReplyDTO> replyListPost(@RequestBody Criteria cri){
	
		return replyService.replyList(cri);
	}
	
	/* ���õ���˾������� */
	@GetMapping("/replyWrite/{goodId}")
	public String replyWriteGet(@PathVariable("goodId") int goodId, int relevel, Model model){
	ReplyDTO dto= new ReplyDTO();
	dto.setGoodId(goodId);
	dto.setRelevel(relevel);
	model.addAttribute("dto", dto);
	return "/replyWrite";
	}
	
	/* ���õ�� */
	@PostMapping("/replyEnroll")
	@ResponseBody
	public void replyEnrollPost(@RequestBody ReplyDTO dto){
	logger.info(dto.toString());
	replyService.replyEnroll(dto);

	}
	
	/* ���ü����˾������� */
	@GetMapping("/replyModify/{goodId}")
	public String replyModifyGet(@PathVariable("goodId") int goodId, int replyId, int relevel, double rating, String replyContent, Model model){
	
	ReplyDTO dto= new ReplyDTO();
	dto.setReplyId(replyId);
	dto.setRelevel(relevel);
	dto.setRating(rating);
	dto.setReplyContent(replyContent);
	dto.setGoodId(goodId);
	model.addAttribute("dto", dto);
	return "/replyModify";
	}
	
	
	/* ���ü��� */
	@PostMapping("/replyModify")
	@ResponseBody
	public void replyModify(@RequestBody ReplyDTO dto){
	logger.info(dto.toString());
	replyService.replyModify(dto);
	}
	
	/* ���û��� */
	@PostMapping("/replyDelete")
	@ResponseBody
	public void replyDelete(@RequestBody ReplyDTO dto){
	logger.info(dto.toString());
		replyService.replyDelete(dto);
	}
	
	
	/* �������˾������� */
	@GetMapping("/rReplyWrite/{goodId}")
	public String rReplyWriteGet(@PathVariable("goodId") int goodId, int rReplyId, int rRelevel, Model model){
	
	ReplyDTO dto= new ReplyDTO();
	dto.setReplyId(rReplyId);
	dto.setRelevel(rRelevel);
	dto.setGoodId(goodId);
	model.addAttribute("dto", dto);
	return "/rReplyWrite";
	}
	
	/* �����õ�� */
	@PostMapping("/rReplyEnroll")
	@ResponseBody
	public void rReplyEnrollPost(@RequestBody ReplyDTO dto){
	logger.info("�����õ��");
	logger.info("����"+dto.toString());
	replyService.pushReplyId(dto.getReplyId());
	replyService.rReplyEnroll(dto);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}//class
