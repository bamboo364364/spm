package com.mycompany.mapper;

import java.util.List;

import com.mycompany.model.CartDTO;

public interface CartMapper {

	/* īƮ�߰� */
	public void addCart(CartDTO dto);
	
	/* īƮ����Ʈ */
	public List<CartDTO> getCart(String memberMail);
	
	/* īƮ���� */
	public void cartDelete(int cartId);
	
	/* īƮ�ߺ��˻� */
	public int cartDupSearch(CartDTO cd);
	
	/* īƮ�߰�(�ߺ�) */
	public int cartAddDup(CartDTO cd);
	
	/* �ڱ�īƮ ��ǰ���˻� */
	public CartDTO cartCountSearch(CartDTO cd);
	
}
