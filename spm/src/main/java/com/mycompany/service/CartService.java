package com.mycompany.service;

import java.util.List;

import com.mycompany.model.CartDTO;

public interface CartService {

/* 카트추가 */
	public void addCart(CartDTO dto);
	
	/* 카트리스트 */
	public List<CartDTO> getCart(String memberMail);
	
	/* 카트삭제 */
	public void cartDelete(int cartId);

}
