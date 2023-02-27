package com.mycompany.service;

import java.util.List;
import java.util.function.Consumer;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.controller.AdminController;
import com.mycompany.mapper.AdminMapper;
import com.mycompany.model.AttachImageVO;
import com.mycompany.model.CateVO;
import com.mycompany.model.Criteria;
import com.mycompany.model.GoodVO;

@Service
public class AdminServiceImpl implements AdminService {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	private AdminMapper adminMapper;

	/* 카테고리 리스트 */
	@Override
	public List<CateVO> cateList() {
		return adminMapper.cateList();
	}


	/* 상품등록 */
	@Override
	public int goodEnroll(GoodVO good) {
	logger.info("img"+ good.toString());
	logger.info("img"+ good.getImageList().get(0).getUuid());
	logger.info("img"+ good.getImageList().get(0).getFileName());
	logger.info("img"+ good.getImageList().get(0).getUploadPath());
	logger.info("img"+ good.getImageList().get(0).getGoodId());
	if(good.getImageList().get(0).getFileName() == "" || good.getImageList().size() <= 0) {
			return adminMapper.goodEnroll(good);
		}
		
		int result= adminMapper.goodEnroll(good);
		
		good.getImageList().forEach(new Consumer<AttachImageVO>() {
			@Override
			public void accept(AttachImageVO attach) {
				
				attach.setGoodId(good.getGoodId());
				adminMapper.imageEnroll(attach);
			}
		});//forEach
		return result;
		}//goodEnroll
		
		

	/* 상품리스트 */
	@Override
	public List<GoodVO> goodGetList(Criteria cri) {
		return adminMapper.goodGetList(cri);
	}

	@Override
	/* 상품리스트 카운트(페이지정보) */
	public int goodGetTotal(Criteria cri) {
		return adminMapper.goodGetTotal(cri);
	}

	@Override
	/* 상품상세 */
	public GoodVO goodGetDetail(int goodId) {
	
	GoodVO vo= adminMapper.goodGetDetail(goodId);
	vo.setImageList(adminMapper.getAttachInfo(goodId));
		return vo;
	}

	/* 상품수정 */
	@Override
	public int goodModify(GoodVO vo) {
		return adminMapper.goodModify(vo);
	};

	/* 상품삭제 */
	@Override
	public int goodDelete(int goodId) {
		return adminMapper.goodDelete(goodId);
	};
	

	
	

}// class
