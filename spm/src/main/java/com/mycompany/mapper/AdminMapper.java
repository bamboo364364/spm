package com.mycompany.mapper;

import java.util.List;

import com.mycompany.model.AttachImageVO;
import com.mycompany.model.CateVO;
import com.mycompany.model.Criteria;
import com.mycompany.model.GoodVO;

public interface AdminMapper {

	/* 카테고리 리스트 */
	public List<CateVO> cateList();
	
	/* 어제자 날짜 이미지 리스트 */
	public List<AttachImageVO> checkFileList();
	
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
	
	/* 상품상세 이미지추가 */
	public List<AttachImageVO> getAttachInfo(int goodId);
	
	/* 이미지 등록 */
	public void imageEnroll(AttachImageVO vo);
	
	/* 지정 상품 이미지 전체 삭제 */
	public void deleteImageAll(int goodId);
	
	
	


}//class
