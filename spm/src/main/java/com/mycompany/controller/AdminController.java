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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mycompany.model.AttachImageVO;
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

	/* �����ڸ��� �̵� */
	@GetMapping("/main")
	public void adminMainGet() throws Exception {
		logger.info("������������ ����");
	}

	/* ��ǰ��������� �̵� */
	@GetMapping("/goodEnroll")
	public void goodEnrollGet(Model model) throws Exception {
		logger.info("��ǰ��������� ����");

		ObjectMapper mapper = new ObjectMapper();
		List list = adminService.cateList();
		String cateList = mapper.writeValueAsString(list);
		model.addAttribute("cateList", cateList);
	}

	/* ��ǰ ��� */
	@PostMapping("/goodEnroll")
	public String goodEnrollPOST(GoodVO good, RedirectAttributes rttr) {

		// ckEditor p�±�
		good.setGoodContents(good.getGoodContents().replace("<p>", ""));
		good.setGoodContents(good.getGoodContents().replace("</p>", ""));

		logger.info("goodsEnrollPOST......" + good);
		adminService.goodEnroll(good);
		
		rttr.addFlashAttribute("enroll_result", good.getGoodName());

		return "redirect:/admin/goodManage";
	}

	/* ��ǰ ����(��ǰ���) ������ ���� */
	@GetMapping("/goodManage")
	public void goodManageGET(Criteria cri, Model model) throws Exception {

		logger.info("��ǰ ����(��ǰ���) ������ ����");
	
		/* ��ǰ ����Ʈ ������ */
		List list = adminService.goodGetList(cri);

		if (!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
		
		}
		
		/* ������ �������̽� ������ */
		
		model.addAttribute("pageMaker", new PageDTO(cri, adminService.goodGetTotal(cri)));

	}// goodManage
	
	
	/* ��ǰ ��ȸ ������, ��ǰ ���� ������ */
	@GetMapping({ "/goodsDetail", "/goodsModify" })
	public void goodsGetInfoGET(Criteria cri, Model model) throws JsonProcessingException {

		logger.info("goodsGetInfo()........." + cri.getgoodId());

		ObjectMapper mapper = new ObjectMapper();

		/* ī�װ� ����Ʈ ������ */
		model.addAttribute("cateList", mapper.writeValueAsString(adminService.cateList()));

		/* ��� ������ ���� ���� */
		model.addAttribute("cri", cri);

		/* ��ȸ ������ ���� */
		model.addAttribute("goodsInfo", adminService.goodGetDetail(cri.getgoodId()));

	}//goodInfo
	
	
	/* ��ǰ ���� ���� */
	@PostMapping("/goodsModify")
	public String goodsModifyPOST(GoodVO vo, RedirectAttributes rttr) {

		logger.info("goodsModifyPOST.........." + vo);

		int result = adminService.goodModify(vo);

		rttr.addFlashAttribute("modify_result", result);

		return "redirect:/admin/goodsManage";

	}//goodModify
	
	
	

	/* ÷�� ���� ���ε� */
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {

		logger.info("uploadAjaxActionPOST..........");

		/* �̹��� ���� üũ */
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

		/* ��¥ ���� ��� */
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();

		String str = sdf.format(date);

		String datePath = str.replace("-", File.separator);

		/* ���� ���� */
		File uploadPath = new File(uploadFolder, datePath);

		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}

		/* �̹��� ���� ��� ��ü */
		List<AttachImageVO> list = new ArrayList();

		// ���� for
		for (MultipartFile multipartFile : uploadFile) {

			/* �̹��� ���� ��ü */
			AttachImageVO vo = new AttachImageVO();

			/* ���� �̸� */
			String uploadFileName = multipartFile.getOriginalFilename();
			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);

			/* uuid ���� ���� �̸� */
			String uuid = UUID.randomUUID().toString();
			vo.setUuid(uuid);

			uploadFileName = uuid + "_" + uploadFileName;

			/* ���� ��ġ, ���� �̸��� ��ģ File ��ü */
			File saveFile = new File(uploadPath, uploadFileName);

			/* ���� ���� */
			try {

				multipartFile.transferTo(saveFile);

				/* ����� ����(ImageIO) */
				/*
				 * File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				 * 
				 * BufferedImage bo_image = ImageIO.read(saveFile);
				 * 
				 * //���� double ratio = 3; //���� ���� int width = (int) (bo_image.getWidth() /
				 * ratio); int height = (int) (bo_image.getHeight() / ratio);
				 * 
				 * BufferedImage bt_image = new BufferedImage(width, height,
				 * BufferedImage.TYPE_3BYTE_BGR);
				 * 
				 * Graphics2D graphic = bt_image.createGraphics();
				 * 
				 * graphic.drawImage(bo_image, 0, 0,width,height, null);
				 * 
				 * ImageIO.write(bt_image, "jpg", thumbnailFile);
				 */

				/* ��� 2 */
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);

				BufferedImage bo_image = ImageIO.read(saveFile);

				// ����
				double ratio = 3;
				// ���� ����
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

	/* �̹��� ���� ���� */
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName) {

		logger.info("deleteFile........" + fileName);

		File file = null;

		try {
			/* ����� ���� ���� */
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));

			file.delete();

			/* ���� ���� ���� */
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
