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
	
	
		/* 주문번호생성 */
		Date date= new Date();
		SimpleDateFormat format= new SimpleDateFormat("_yyyyMMddmmss");
		String orderId= mv.getMemberMail()+ format.format(date);
		od.setOrderId(orderId);
		
		//재고용 GoodVOList
		List<GoodVO> lgv= new ArrayList<GoodVO>();
		
		//카트제거용 CartDTOList
		List<CartDTO> lcd= new ArrayList<CartDTO>();
		//OrderDTO 안에 OrderItemDTO 계산+ 주문번호입력+ 재고용 GoodVOList생성+ 카트제거용 CartDTOList생성
		for(OrderItemDTO oid: od.getOrders()){
		oid.setOrderId(orderId);
		oid.initSaleTotal();
		
		GoodVO gv= new GoodVO();
		gv.setGoodId(oid.getGoodId());
		gv.setGoodStock( gv.getGoodStock()- oid.getGoodCount() );
		lgv.add(gv);
		
		CartDTO cd= new CartDTO();
		cd.setGoodId(oid.getGoodId());
		cd.setMemberMail(mv.getMemberMail());
		lcd.add(cd);
		}
		//OrderDTO계산
		od.getOrderPriceInfo();
		
		orderMapper.order(od);
		
		//orderPay
		int money= ( mv.getMoney()- od.getOrderFinalSalePrice() );
		int point= ( mv.getPoint()- od.getUsePoint()+ od.getOrderSavePoint() );
		MemberVO mvp= new MemberVO();
		mvp.setMoney(money);
		mvp.setPoint(point);
		mvp.setMemberMail(mv.getMemberMail());
		orderMapper.orderPay(mvp);
		logger.info("lgv는"+ lgv.toString());
		//재고변동
		for(GoodVO gv: lgv){
		orderMapper.stockChange(gv);
		}
		
		//카트제거  카트1개씩으로변경! 카트재고1문제? ordealert
		for(CartDTO cd: lcd){
			orderMapper.cartDel(cd);
		}
		
		

	}//order //transaction
	
	
	





}//class
