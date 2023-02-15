package com.mycompany.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.mycompany.model.AttachImageVO;
import com.mycompany.model.Criteria;
import com.mycompany.model.GoodVO;
import com.mycompany.model.PageDTO;
import com.mycompany.service.AdminService;
import com.mycompany.service.AttachService;
import com.mycompany.service.MemberService;

@Controller
public class GoodController {

	private static final Logger logger = LoggerFactory.getLogger(GoodController.class);

	@Autowired
	private MemberService memberService;
	@Autowired
	private AttachService attachService;
	@Autowired
	private AdminService adminService;

	/* 이미지 출력 */
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName) {

		logger.info("getImage()........" + fileName);

		File file = new File("c:\\upload\\" + fileName);

		ResponseEntity<byte[]> result = null;

		try {

			HttpHeaders header = new HttpHeaders();

			header.add("Content-type", Files.probeContentType(file.toPath()));

			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);

		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;

	}//display

	/* 이미지 정보 반환 */
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> getAttachList(int goodId) {

		logger.info("getAttachList.........." + goodId);

		return new ResponseEntity<List<AttachImageVO>>(attachService.getAttachList(goodId), HttpStatus.OK);

	}

	@GetMapping("/search")
	public void searchGet(Criteria cri, Model model) {
		
	logger.info("검색페이지 진입");
	
	/* 상품 리스트 데이터 */
		List list = adminService.goodGetList(cri);

		if (!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
		
		}
	
	model.addAttribute("pageMaker", new PageDTO(cri, adminService.goodGetTotal(cri)));


	}
	
	
	
	@GetMapping("/goodDetail/{goodId}")
	public String goodDetailGet(@PathVariable("goodId") int goodId, Model model){
	logger.info("상품상세 페이지 진입");
	
	
	GoodVO good= adminService.goodGetDetail(goodId);
	
	model.addAttribute("good", good);
	return "/goodDetail";	
	
	
	}//goodDetail
	
	




}// class
