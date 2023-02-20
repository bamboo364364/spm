package com.mycompany.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.controller.ReplyController;
import com.mycompany.mapper.AttachMapper;
import com.mycompany.mapper.CartMapper;
import com.mycompany.mapper.OrderMapper;
import com.mycompany.model.AttachImageVO;
import com.mycompany.model.CartDTO;
import com.mycompany.model.GoodVO;

@Service
public class CartServiceImpl implements CartService {

	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);


@Autowired
private CartMapper cartMapper;
@Autowired
private AttachMapper attachMapper;
@Autowired
private OrderMapper orderMapper;



	/* 카트추가 */
	@Override
	public int addCart(CartDTO dto){
	logger.info(dto.toString());
	
	int stock= cartMapper.stockSearch(dto);
	int count= dto.getGoodCount();
	if(stock< count){ return 0;}
	else{
	GoodVO gv= new GoodVO();
	gv.setGoodId(dto.getGoodId());
	gv.setGoodStock(stock- count);
	orderMapper.stockChange(gv);
	cartMapper.addCart(dto); 
	return 1;
	}//else
	}//addCart
	
	
	/* 카트리스트 */
	@Override
	public List<CartDTO> getCart(String memberMail){
	List<CartDTO> list= cartMapper.getCart(memberMail);
	
	for(CartDTO dto : list) {
			
			/* 종합 정보 초기화 */
			dto.initSaleTotal();
			
			/* 이미지 정보 얻기 */
			int goodId = dto.getGoodId();
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(goodId);
			
			dto.setImageList(imageList);
		}
		return list;
	}
	
	/* 카트삭제 */
	@Override
	public void cartDelete(int cartId){
	cartMapper.cartDelete(cartId);
	}






}//class
