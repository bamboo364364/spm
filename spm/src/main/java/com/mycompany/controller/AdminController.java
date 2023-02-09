package com.mycompany.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mycompany.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	private AdminService adminService;
	
	
	/* 관리자메인 이동 */
	@GetMapping("/main")
	public void adminMainGet() throws Exception{
		logger.info("관리자페이지 진입");
	}
	
	/* 상품등록페이지 이동 */
	@GetMapping("/goodsEnroll")
	public void goodsEnrollGet(Model model) throws Exception{
		logger.info("상품등록페이지 진입");
		
		ObjectMapper mapper= new ObjectMapper();
		List list= adminService.cateList();
		String cateList= mapper.writeValueAsString(list);
		model.addAttribute("cateList", cateList);
	}
	
	
	
	











}//clss
