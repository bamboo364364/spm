package com.mycompany.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mycompany.model.AttachImageVO;
import com.mycompany.model.CateVO;
import com.mycompany.model.Criteria;
import com.mycompany.model.GoodVO;
import com.mycompany.model.PageDTO;
import com.mycompany.service.AdminService;

import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/admin")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	private AdminService adminService;

	/* 관리자메인 이동 */
	@GetMapping("/main")
	public void adminMainGet() throws Exception {
		logger.info("관리자페이지 진입");
	}

	/* 상품등록페이지 이동 */
	@GetMapping("/goodEnroll")
	public void goodEnrollGet(Model model) throws Exception {
		logger.info("상품등록페이지 진입");

		ObjectMapper mapper = new ObjectMapper();
		List list = adminService.cateList();
		String cateList = mapper.writeValueAsString(list);
		model.addAttribute("cv", cateList);
	}

	/* 상품 등록 */
	@PostMapping("/goodEnroll")
	public String goodEnrollPOST(GoodVO good, RedirectAttributes rttr) {
	
		logger.info("goodsEnrollPOST......" + good);
		adminService.goodEnroll(good);
		
		rttr.addFlashAttribute("enrollResult", good.getGoodName());

		return "redirect:/admin/goodManage"; //
	}

	/* 상품 관리(상품목록) 페이지 접속 */
	@GetMapping("/goodManage")
	public void goodManageGET(Criteria cri, Model model) throws Exception {

		logger.info("상품 관리(상품목록) 페이지 접속");
		
		/* 상품 리스트 데이터 */
		List list = adminService.goodGetList(cri);

		if (!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
		
		}
		
		/* 페이지 인터페이스 데이터 */
		
		model.addAttribute("pageMaker", new PageDTO(cri, adminService.goodGetTotal(cri)));

	}// goodManage
	
	@GetMapping("/adminGoodDetail/{goodId}")
	public String adminGoodDetailGet( @PathVariable("goodId") int goodId, Criteria cri, Model model ){
	logger.info("관리.상품상세페이지 진입");
		GoodVO good= adminService.goodGetDetail(goodId);
		model.addAttribute("good", good);
		model.addAttribute("cri", cri);
	
	
return "/admin/adminGoodDetail";

	}
	
	

	/* 수정페이지 */
	@GetMapping("/goodModify/{goodId}")
	public String goodModifyGet(@PathVariable("goodId") int goodId, Criteria cri, Model model) throws JsonProcessingException{
	logger.info("상품수정페이지 진입");
	GoodVO good= adminService.goodGetDetail(goodId);
		model.addAttribute("good", good);
		
		ObjectMapper mapper = new ObjectMapper();
		List list = adminService.cateList();
		String cateList = mapper.writeValueAsString(list);
		model.addAttribute("cv", cateList);
		model.addAttribute("cri", cri);
	
	 return "/admin/goodModify";
	}
	
	
	
	/* 상품 정보 수정 */
	@PostMapping("/goodModify")
	public String goodsModifyPOST(GoodVO gv, Criteria cri, RedirectAttributes rttr) {

		logger.info("goodsModifyPOST.........." + gv);

		int result = adminService.goodModify(gv);

		rttr.addFlashAttribute("modifyResult", result);

		return "redirect:/admin/goodManage?pageNum="+cri.getPageNum()+"&amount="+cri.getAmount()+"&keyword="+cri.getKeyword();

	}
	
	/* 상품삭제 */
	@PostMapping("/goodDelete")
	public String goodDelete(int goodId, Criteria cri, RedirectAttributes rttr){
	logger.info(goodId+"삭제메서드진입");
		int result= adminService.goodDelete(goodId);
		rttr.addFlashAttribute("deleteResult", result);
		return "redirect:/admin/goodManage?type="+cri.getType()+"&keyword="+cri.getKeyword()+"&pageNum="+cri.getPageNum()+"&amount="+cri.getAmount();
	}
	
	
	

	/* 첨부 파일 업로드 */
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {

		logger.info("uploadAjaxActionPOST..........");

		/* 이미지 파일 체크 */
		for (MultipartFile multipartFile : uploadFile) {

			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;

			try {
				type = Files.probeContentType(checkfile.toPath());
				logger.info("MIME TYPE : " + type);
			} catch (IOException e) {
				e.printStackTrace();
			}

			if (!type.startsWith("image")) {

				List<AttachImageVO> list = null;
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);

			}

		} // for

		String uploadFolder = "C:\\upload";

		/* 날짜 폴더 경로 */
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		String str = sdf.format(date);

		String datePath = str.replace("-", File.separator);

		/* 폴더 생성 */
		File uploadPath = new File(uploadFolder, datePath);

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		/* 이미저 정보 담는 객체 */
		List<AttachImageVO> list = new ArrayList();

		// 향상된 for
		for (MultipartFile multipartFile : uploadFile) {

			/* 이미지 정보 객체 */
			AttachImageVO vo = new AttachImageVO();

			/* 파일 이름 */
			String uploadFileName = multipartFile.getOriginalFilename();
			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);

			/* uuid 적용 파일 이름 */
			String uuid = UUID.randomUUID().toString();
			vo.setUuid(uuid);

			uploadFileName = uuid + "_" + uploadFileName;

			/* 파일 위치, 파일 이름을 합친 File 객체 */
			File saveFile = new File(uploadPath, uploadFileName);

			/* 파일 저장 */
			try {

				multipartFile.transferTo(saveFile);

				/* 썸네일 생성(ImageIO) */
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);

				BufferedImage bo_image = ImageIO.read(saveFile);

				// 비율
				double ratio = 3;
				// 넓이 높이
				int width = (int) (bo_image.getWidth() / ratio);
				int height = (int) (bo_image.getHeight() / ratio);

				Thumbnails.of(saveFile).size(width, height).toFile(thumbnailFile);

			} catch (Exception e) {

				e.printStackTrace();

			}

			list.add(vo);

		} // for

		ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list, HttpStatus.OK);

		return result;
	}

	/* 이미지 파일 삭제 */
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName) {

		logger.info("deleteFile........" + fileName);

		File file = null;

		try {
			/* 썸네일 파일 삭제 */
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));

			file.delete();

			/* 원본 파일 삭제 */
			String originFileName = file.getAbsolutePath().replace("s_", "");

			logger.info("originFileName : " + originFileName);

			file = new File(originFileName);

			file.delete();

		} catch (Exception e) {

			e.printStackTrace();

			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);

		} // catch

		return new ResponseEntity<String>("success", HttpStatus.OK);

	}
	
	
	
	

	
	

}// class
