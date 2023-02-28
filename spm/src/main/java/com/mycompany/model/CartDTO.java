package com.mycompany.model;

import java.util.List;

public class CartDTO {

private int cartId;

private String memberMail;

private int goodId;

private int goodCount;

private String goodName;

private int goodPrice;

private double goodDiscount;

private int salePrice;

private int totalPrice;

private int point;

private int totalPoint;


private int goodStock;

public int getGoodStock() {
	return goodStock;
}

public void setGoodStock(int goodStock) {
	this.goodStock = goodStock;
}

private List<AttachImageVO> imageList;

public int getCartId() {
	return cartId;
}

public void setCartId(int cartId) {
	this.cartId = cartId;
}

public String getMemberMail() {
	return memberMail;
}

public void setMemberMail(String memberMail) {
	this.memberMail = memberMail;
}

public int getGoodId() {
	return goodId;
}

public void setGoodId(int goodId) {
	this.goodId = goodId;
}

public int getGoodCount() {
	return goodCount;
}

public void setGoodCount(int goodCount) {
	this.goodCount = goodCount;
}

public String getGoodName() {
	return goodName;
}

public void setGoodName(String goodName) {
	this.goodName = goodName;
}

public int getGoodPrice() {
	return goodPrice;
}

public void setGoodPrice(int goodPrice) {
	this.goodPrice = goodPrice;
}

public double getGoodDiscount() {
	return goodDiscount;
}

public void setGoodDiscount(double goodDiscount) {
	this.goodDiscount = goodDiscount;
}

public int getSalePrice() {
	return salePrice;
}

public void setSalePrice(int salePrice) {
	this.salePrice = salePrice;
}

public int getTotalPrice() {
	return totalPrice;
}

public void setTotalPrice(int totalPrice) {
	this.totalPrice = totalPrice;
}

public int getPoint() {
	return point;
}

public void setPoint(int point) {
	this.point = point;
}

public int getTotalPoint() {
	return totalPoint;
}

public void setTotalPoint(int totalPoint) {
	this.totalPoint = totalPoint;
}

public List<AttachImageVO> getImageList() {
	return imageList;
}

public void setImageList(List<AttachImageVO> imageList) {
	this.imageList = imageList;
}


public void initSaleTotal() {
		this.salePrice = (int) (this.goodPrice * (1-this.goodDiscount));
		this.totalPrice = this.salePrice*this.goodCount;
		this.point = (int)(Math.floor(this.salePrice*0.05));
		this.totalPoint =this.point * this.goodCount;		
	}

@Override
public String toString() {
	return "CartDTO [cartId=" + cartId + ", memberMail=" + memberMail + ", goodId=" + goodId + ", goodCount="
			+ goodCount + ", goodName=" + goodName + ", goodPrice=" + goodPrice + ", goodDiscount=" + goodDiscount
			+ ", salePrice=" + salePrice + ", totalPrice=" + totalPrice + ", point=" + point + ", totalPoint="
			+ totalPoint + ", goodStock=" + goodStock + ", imageList=" + imageList + "]";
}








}
