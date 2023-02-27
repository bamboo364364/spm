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

	/* ī�װ� ����Ʈ */
	@Override
	public List<CateVO> cateList() {
		return adminMapper.cateList();
	}


	/* ��ǰ��� */
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
		
		

	/* ��ǰ����Ʈ */
	@Override
	public List<GoodVO> goodGetList(Criteria cri) {
		return adminMapper.goodGetList(cri);
	}

	@Override
	/* ��ǰ����Ʈ ī��Ʈ(����������) */
	public int goodGetTotal(Criteria cri) {
		return adminMapper.goodGetTotal(cri);
	}

	@Override
	/* ��ǰ�� */
	public GoodVO goodGetDetail(int goodId) {
	
	GoodVO vo= adminMapper.goodGetDetail(goodId);
	vo.setImageList(adminMapper.getAttachInfo(goodId));
		return vo;
	}

	/* ��ǰ���� */
	@Override
	public int goodModify(GoodVO vo) {
		return adminMapper.goodModify(vo);
	};

	/* ��ǰ���� */
	@Override
	public int goodDelete(int goodId) {
		return adminMapper.goodDelete(goodId);
	};
	

	
	

}// class
