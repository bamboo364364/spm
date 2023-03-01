package com.mycompany.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.controller.ReplyController;
import com.mycompany.mapper.AttachMapper;
import com.mycompany.mapper.CartMapper;
import com.mycompany.mapper.OrderMapper;
import com.mycompany.model.AttachImageVO;
import com.mycompany.model.CartDTO;
import com.mycompany.model.GoodVO;
import com.mycompany.model.MemberVO;
import com.mycompany.model.OrderDTO;
import com.mycompany.model.OrderItemDTO;
import com.mycompany.model.OrderPageItemDTO;

@Service
public class OrderServiceImpl implements OrderService {

	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);


@Autowired
private CartMapper cartMapper;
@Autowired
private AttachMapper attachMapper;
@Autowired
private OrderMapper orderMapper;


/* 주문상품정보 */
@Override
	public List<OrderPageItemDTO> getGoodsInfo(List<OrderPageItemDTO> orders){
	
		List<OrderPageItemDTO> result = new ArrayList<OrderPageItemDTO>();

		for (OrderPageItemDTO ord : orders) {
			
			orderMapper.getGoodsInfo(ord.getGoodId());
			
			
			ord.initSaleTotal();

			List<AttachImageVO> imageList = attachMapper.getAttachList(ord.getGoodId());

			ord.setImageList(imageList);

			result.add(ord);
		}

		return result;

	}
	
	
	/* 주문 */
	@Transactional
	@Override
	public void order(OrderDTO od, MemberVO mv){
	
		logger.info(od.toString());
		/* 주문번호생성 */
		Date date= new Date();
		SimpleDateFormat format= new SimpleDateFormat("_yyyyMMddmmss");
		String orderId= mv.getMemberMail()+ format.format(date);
		od.setOrderId(orderId);
		
		orderMapper.order(od);
		
		//orderItem+ 재고+ 카트제거
		for(OrderItemDTO oid: od.getOrders()){
		
		oid.setOrderId(orderId);
		orderMapper.orderItem(oid);
		
		GoodVO gv= new GoodVO();
		gv.setGoodId(oid.getGoodId());
		gv.setGoodStock( oid.getGoodCount() );
		orderMapper.stockChange(gv);
		
		CartDTO cd= new CartDTO();
		cd.setGoodId(oid.getGoodId());
		cd.setMemberMail(mv.getMemberMail());
		orderMapper.cartDel(cd);
		}
		
		//orderPay
		int money= ( mv.getMoney()- od.getOrderFinalSalePrice() );
		int point= ( mv.getPoint()- od.getUsePoint()+ od.getOrderSavePoint() );
		MemberVO mvp= new MemberVO();
		mvp.setMoney(money);
		mvp.setPoint(point);
		mvp.setMemberMail(mv.getMemberMail());
		orderMapper.orderPay(mvp);
		
		
		

	}
	
	
	





}//class
