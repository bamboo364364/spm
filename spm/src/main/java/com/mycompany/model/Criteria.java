package com.mycompany.model;

import java.util.Arrays;

public class Criteria {

	/* ���� ������ ��ȣ */
	private int pageNum;
	
	/* ������ ǥ�� ���� */
	private int amount;
	
	/* �˻� Ÿ�� */
	private String type;
	
	/* �˻� Ű���� */
	private String keyword;
	
	/* �۰� ����Ʈ */
	private String[] authorArr;
	
	/*�˻�ī��*/
	private String searchCateCode;
	
	public String getSearchCateCode() {
		return searchCateCode;
	}

	public void setSearchCateCode(String searchCateCode) {
		this.searchCateCode = searchCateCode;
	}
	
	/*kjb.�Խ�������*/
	private int kjbId;
	
	public int getKjbId() {
		return kjbId;
	}

	public void setKjbId(int kjbId) {
		this.kjbId = kjbId;
	}
	
	
	
	private String contentId;
	
	
	
	
	/*private String[] memberArr;
	
	public String[] getMemberArr() {
		return memberArr;
	}
	
	public void setMemberArr(String[] memberArr) {
		this.memberArr = memberArr;
	}*/

	

	

	

	public String getContentId() {
		return contentId;
	}

	public void setContentId(String contentId) {
		this.contentId = contentId;
	}

	/* ī�װ� �ڵ� */
	private String cateCode;

	
	/* ��ǰ ��ȣ(��� ��ɿ��� ���) */
	private int bookId;
	
	private String memberId;
	
	public String getMemberId() {
		return memberId;
	}
	
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	public String getMemberAddr2() {
		return memberAddr2;
	}
	
	public void setMemberAddr2(String memberAddr2) {
		this.memberAddr2 = memberAddr2;
	}
	
	private String memberAddr2;
	
	/* Criteria ������ */
	public Criteria(int pageNum, int amount/*, String keyword, int kjdId, String type*/) {
		this.pageNum = pageNum;
		this.amount = amount;
		
		/*this.keyword= keyword;
		this.kjbId= kjdId;
		this.type= type;*/
		
		 
	}
	
	/* Criteria �⺻ ������ */
	public Criteria(){
		this(1, 10/*,"",1,"C"*/);
	}
	
	/* �˻� Ÿ�� ������ �迭 ��ȯ */
	public String[] getTypeArr() {
		return type == null? new String[] {}:type.split("");
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String[] getAuthorArr() {
		return authorArr;
	}

	public void setAuthorArr(String[] authorArr) {
		this.authorArr = authorArr;
	}

	public String getCateCode() {
		return cateCode;
	}

	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
	}
	
	public int getBookId() {
		return bookId;
	}

	public void setBookId(int bookId) {
		this.bookId = bookId;
	}

	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", type=" + type + ", keyword=" + keyword
				+ ", authorArr=" + Arrays.toString(authorArr) + ", searchCateCode=" + searchCateCode + ", kjbId="
				+ kjbId + ", contentId=" + contentId + ", cateCode=" + cateCode + ", bookId="
				+ bookId + ", memberId=" + memberId + ", memberAddr2=" + memberAddr2 + "]";
	}


	
	
	/*
		@Override
		public String toString() {
			return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", type=" + type + ", keyword=" + keyword
					+ ", authorArr=" + Arrays.toString(authorArr) + ", kjbId="+ kjbId +", searchCateCode="+searchCateCode+",  cateCode=" + cateCode + ", bookId=" + bookId + "]";
		}*/



	
	
}
