package com.mycompany.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.controller.ReplyController;
import com.mycompany.mapper.AttachMapper;
import com.mycompany.mapper.CartMapper;
import com.mycompany.model.AttachImageVO;
import com.mycompany.model.CartDTO;

@Service
public class CartServiceImpl implements CartService {

	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);


@Autowired
private CartMapper cartMapper;
@Autowired
private AttachMapper attachMapper;



	/* īƮ�߰� */
	@Override
	public void addCart(CartDTO dto){
	
	cartMapper.addCart(dto);
	}
	
	
	/* īƮ����Ʈ */
	@Override
	public List<CartDTO> getCart(String memberMail){
	List<CartDTO> list= cartMapper.getCart(memberMail);
	
	for(CartDTO dto : list) {
			
			/* ���� ���� �ʱ�ȭ */
			dto.initSaleTotal();
			
			/* �̹��� ���� ��� */
			int goodId = dto.getGoodId();
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(goodId);
			
			dto.setImageList(imageList);
		}
		return list;
	}
	
	/* īƮ���� */
	@Override
	public void cartDelete(int cartId){
	cartMapper.cartDelete(cartId);
	}






}//class
