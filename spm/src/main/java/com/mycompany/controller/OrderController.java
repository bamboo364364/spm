package com.mycompany.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.model.GoodVO;
import com.mycompany.model.MemberVO;
import com.mycompany.model.OrderDTO;
import com.mycompany.model.OrderPageDTO;
import com.mycompany.service.AdminService;
import com.mycompany.service.AttachService;
import com.mycompany.service.MemberService;
import com.mycompany.service.OrderService;
import com.mycompany.service.ReplyService;

@Controller
@RequestMapping("/order")
public class OrderController {

	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

	@Autowired
	private MemberService memberService;
	@Autowired
	private AttachService attachService;
	@Autowired
	private AdminService adminService;
	@Autowired
	private ReplyService replyService;
	@Autowired
	private OrderService orderService;
	
	@GetMapping("/orderView")
	public void orderGet(String memberMail, OrderPageDTO opd, Model model) {
		logger.info(opd.toString());
		logger.info(memberMail);
		model.addAttribute("list", opd.getOrders());
		model.addAttribute("memberInfo", memberService.getMemberInfo(memberMail));
	
	}
	
	@PostMapping("/order")
	public String orderPost(OrderDTO od, MemberVO mv){
		orderService.order(od, mv);
		return "redirect:/";
	}	
	
	
	
	
	
	










}// class
