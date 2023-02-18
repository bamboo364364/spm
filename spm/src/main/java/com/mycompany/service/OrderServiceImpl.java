package com.mycompany.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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


/* �ֹ���ǰ���� */
@Override
	public List<OrderPageItemDTO> getGoodsInfo(List<OrderPageItemDTO> orders){
	
	
		List<OrderPageItemDTO> result = new ArrayList<OrderPageItemDTO>();

		for (OrderPageItemDTO ord : orders) {

			OrderPageItemDTO goodsInfo = orderMapper.getGoodsInfo(ord.getGoodId());

			goodsInfo.setGoodCount(ord.getGoodCount());

			goodsInfo.initSaleTotal();

			List<AttachImageVO> imageList = attachMapper.getAttachList(goodsInfo.getGoodId());

			goodsInfo.setImageList(imageList);

			result.add(goodsInfo);
		}

		return result;

	}
	
	
	/* �ֹ� */
	@Override
	public void order(OrderDTO od, MemberVO mv){
	
	
		/* �ֹ���ȣ���� */
		Date date= new Date();
		SimpleDateFormat format= new SimpleDateFormat("_yyyyMMddmmss");
		String orderId= mv.getMemberMail()+ format.format(date);
		od.setOrderId(orderId);
		
		//���� GoodVOList
		List<GoodVO> lgv= new ArrayList<GoodVO>();
		
		//īƮ���ſ� CartDTOList
		List<CartDTO> lcd= new ArrayList<CartDTO>();
		//OrderDTO �ȿ� OrderItemDTO ���+ �ֹ���ȣ�Է�+ ���� GoodVOList����+ īƮ���ſ� CartDTOList����
		for(OrderItemDTO oid: od.getOrders()){
		oid.setOrderId(orderId);
		oid.initSaleTotal();
		
		GoodVO gv= new GoodVO();
		gv.setGoodId(oid.getGoodId());
		gv.setGoodCount(oid.getGoodCount());
		lgv.add(gv);
		
		CartDTO cd= new CartDTO();
		cd.setGoodId(oid.getGoodId());
		cd.setMemberMail(mv.getMemberMail());
		lcd.add(cd);
		}
		//OrderDTO���
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
		//�����
		for(GoodVO gv: lgv){
		orderMapper.stockChange(gv);
		}
		
		//īƮ����  īƮ1�������κ���! īƮ���1����? ordealert
		for(CartDTO cd: lcd){
			orderMapper.cartDel(cd);
		}
		
		

	}//order //transaction
	
	
	





}//class
