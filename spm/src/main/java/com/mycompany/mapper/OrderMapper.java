package com.mycompany.mapper;

import com.mycompany.model.CartDTO;
import com.mycompany.model.GoodVO;
import com.mycompany.model.MemberVO;
import com.mycompany.model.OrderDTO;
import com.mycompany.model.OrderPageItemDTO;

public interface OrderMapper {
	
	/* �ֹ���ǰ���� */
	public OrderPageItemDTO getGoodsInfo(int goodId);
	
	
	/* �ֹ�. �ֹ����̺� �����߰� */
	public void order(OrderDTO od);
	
	/* �ֹ�. ȸ�� ��ȭ���� */
	public void orderPay(MemberVO mvp);
	
	
	/* �ֹ�. ����� */
	public void stockChange(GoodVO gv);
	
	
	/* �ֹ�. īƮ���� */
	public void cartDel(CartDTO cd);
	
}

	