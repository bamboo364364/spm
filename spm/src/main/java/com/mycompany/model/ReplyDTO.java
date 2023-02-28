package com.mycompany.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class ReplyDTO {

	private int replyId;
	
	private int goodId;
	
	private String memberMail;
	
	private String memberName;

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	@JsonFormat(shape= JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date regDate;
	
	private String replyContent;
	
	private double rating;
	
	private int relevel;
	
	//삭제시사용, 선택 replyId다음 동 레벨리플의 replyId
	private int ntReplyId;


	public int getNtReplyId() {
		return ntReplyId;
	}

	public void setNtReplyId(int ntReplyId) {
		this.ntReplyId = ntReplyId;
	}

	public int getRelevel() {
		return relevel;
	}

	public void setRelevel(int relevel) {
		this.relevel = relevel;
	}

	public int getReplyId() {
		return replyId;
	}

	public void setReplyId(int replyId) {
		this.replyId = replyId;
	}

	public int getGoodId() {
		return goodId;
	}

	public void setGoodId(int goodId) {
		this.goodId = goodId;
	}

	public String getMemberMail() {
		return memberMail;
	}

	public void setMemberMail(String memberMail) {
		this.memberMail = memberMail;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	@Override
	public String toString() {
		return "ReplyDTO [replyId=" + replyId + ", goodId=" + goodId + ", memberMail=" + memberMail + ", memberName="
				+ memberName + ", regDate=" + regDate + ", replyContent=" + replyContent + ", rating=" + rating
				+ ", relevel=" + relevel + ", ntReplyId=" + ntReplyId + "]";
	}	
	
	
	
}
