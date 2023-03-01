package com.mycompany.service;

import java.util.List;

import com.mycompany.model.GoodVO;
import com.mycompany.model.MemberVO;
import com.mycompany.model.OrderDTO;
import com.mycompany.model.OrderPageItemDTO;

public interface OrderService {

	/* 주문상품정보 */
	public List<OrderPageItemDTO> getGoodsInfo(List<OrderPageItemDTO> orders);	


	/* 주문 */
	public void order(OrderDTO od, MemberVO mv);







}

	
