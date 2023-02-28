package com.mycompany.mapper;

import java.util.List;

import com.mycompany.model.CartDTO;

public interface CartMapper {

	/* 카트추가 */
	public void addCart(CartDTO dto);
	
	/* 카트리스트 */
	public List<CartDTO> getCart(String memberMail);
	
	/* 카트삭제 */
	public void cartDelete(int cartId);
	
	/* 카트중복검색 */
	public int cartDupSearch(CartDTO cd);
	
	/* 카트추가(중복) */
	public int cartAddDup(CartDTO cd);
	
	/* 자기카트 상품수검색 */
	public CartDTO cartCountSearch(CartDTO cd);
	
}
