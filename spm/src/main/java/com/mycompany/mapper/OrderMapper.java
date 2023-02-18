package com.mycompany.mapper;

import com.mycompany.model.CartDTO;
import com.mycompany.model.GoodVO;
import com.mycompany.model.MemberVO;
import com.mycompany.model.OrderDTO;
import com.mycompany.model.OrderPageItemDTO;

public interface OrderMapper {
	
	/* 주문상품정보 */
	public OrderPageItemDTO getGoodsInfo(int goodId);
	
	
	/* 주문. 주문테이블에 정보추가 */
	public void order(OrderDTO od);
	
	/* 주문. 회원 재화차감 */
	public void orderPay(MemberVO mvp);
	
	
	/* 주문. 재고변동 */
	public void stockChange(GoodVO gv);
	
	
	/* 주문. 카트제거 */
	public void cartDel(CartDTO cd);
	
}

	