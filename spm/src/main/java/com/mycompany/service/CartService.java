package com.mycompany.service;

import java.util.List;

import com.mycompany.model.CartDTO;

public interface CartService {

/* īƮ�߰� */
	public void addCart(CartDTO dto);
	
	/* īƮ����Ʈ */
	public List<CartDTO> getCart(String memberMail);
	
	/* īƮ���� */
	public void cartDelete(int cartId);

}
