package com.mycompany.service;

import java.util.List;

import com.mycompany.model.GoodVO;
import com.mycompany.model.MemberVO;
import com.mycompany.model.OrderDTO;
import com.mycompany.model.OrderPageItemDTO;

public interface OrderService {

	/* �ֹ���ǰ���� */
	public List<OrderPageItemDTO> getGoodsInfo(List<OrderPageItemDTO> orders);	


	/* �ֹ� */
	public void order(OrderDTO od, MemberVO mv);







}

	
