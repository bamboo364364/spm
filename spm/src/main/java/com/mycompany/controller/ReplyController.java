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
	
	/* 리플페이징 */
	@PostMapping("/replyList")
	@ResponseBody
	public List<ReplyDTO> replyListPost(@RequestBody Criteria cri){
	
		return replyService.replyList(cri);
	}
	
	/* 리플등록팝업페이지 */
	@GetMapping("/replyWrite/{goodId}")
	public String replyWriteGet(@PathVariable("goodId") int goodId, int relevel, Model model){
	ReplyDTO dto= new ReplyDTO();
	dto.setGoodId(goodId);
	dto.setRelevel(relevel);
	model.addAttribute("dto", dto);
	return "/replyWrite";
	}
	
	/* 리플등록 */
	@PostMapping("/replyEnroll")
	@ResponseBody
	public void replyEnrollPost(@RequestBody ReplyDTO dto){
	replyService.replyEnroll(dto);

	}
	
	/* 리플수정팝업페이지 */
	@GetMapping("/replyModify/{goodId}")
	public String replyModifyGet(@PathVariable("goodId") int goodId, int replyId, int relevel, int rating, String replyContent, Model model){
	
	ReplyDTO dto= new ReplyDTO();
	dto.setReplyId(replyId);
	dto.setRelevel(relevel);
	dto.setRating(rating);
	dto.setReplyContent(replyContent);
	model.addAttribute("dto", dto);
	return "/replyModify";
	}
	
	
	/* 리플수정 */
	@PostMapping("/replyModify")
	@ResponseBody
	public void replyModify(@RequestBody ReplyDTO dto){

	replyService.replyModify(dto);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}//class
