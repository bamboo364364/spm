package com.mycompany.service;

import java.util.List;

import com.mycompany.model.CateVO;
import com.mycompany.model.Criteria;
import com.mycompany.model.GoodVO;

public interface AdminService {

/* 카테고리 리스트 */
	public List<CateVO> cateList();

	/* 상품등록 */
	public int goodEnroll(GoodVO vo);

	/* 상품리스트 */
	public List<GoodVO> goodGetList(Criteria cri);
	
	/* 상품리스트 카운트 */
	public int goodGetTotal(Criteria cri);
	
	/* 상품상세 */
	public GoodVO goodGetDetail(int goodId);
	
	/* 상품수정 */
	public int goodModify(GoodVO vo);
	
	/* 상품삭제 */
	public int goodDelete(int goodId);
	



}//class
