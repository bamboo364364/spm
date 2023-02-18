package com.mycompany.model;

public class OrderItemDTO {

	/* �ֹ� ��ȣ */
	private String orderId;
	
	/* ��ǰ ��ȣ */
    private int goodId;
    
	/* �ֹ� ���� */
    private int goodCount;
    
	/* spm_orderItem �⺻Ű */
    private int orderItemId;
    
	/* ��ǰ �� �� ���� */
    private int goodPrice;
    
	/* ��ǰ ���� �� */
    private double goodDiscount;
    
	/* ��ǰ �Ѱ� ���� �� ȹ�� ����Ʈ */
    private int savePoint;
    
	/* DB���̺� ���� ���� �ʴ� ������ */
    
	/* ���� ����� ���� */
    private int salePrice;
    
	/* �� ����(���� ����� ���� * �ֹ� ����) */
    private int totalPrice;
    
	/* �� ȹ�� ����Ʈ(��ǰ �Ѱ� ���� �� ȹ�� ����Ʈ * ����) */
    private int totalSavePoint;

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
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

	public void setgoodCount(int goodCount) {
		this.goodCount = goodCount;
	}

	public int getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
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

	public int getSavePoint() {
		return savePoint;
	}

	public void setSavePoint(int savePoint) {
		this.savePoint = savePoint;
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

	public int getTotalSavePoint() {
		return totalSavePoint;
	}

	public void setTotalSavePoint(int totalSavePoint) {
		this.totalSavePoint = totalSavePoint;
	}

	@Override
	public String toString() {
		return "OrderItemDTO [orderId=" + orderId + ", goodId=" + goodId + ", goodCount=" + goodCount + ", orderItemId="
				+ orderItemId + ", goodPrice=" + goodPrice + ", goodDiscount=" + goodDiscount + ", savePoint="
				+ savePoint + ", salePrice=" + salePrice + ", totalPrice=" + totalPrice + ", totalSavePoint="
				+ totalSavePoint + "]";
	}
	
	public void initSaleTotal() {
		this.salePrice = (int) (this.goodPrice * (1-this.goodDiscount));
		this.totalPrice = this.salePrice*this.goodCount;
		this.savePoint = (int)(Math.floor(this.salePrice*0.05));
		this.totalSavePoint =this.savePoint * this.goodCount;
	}		
    
    
	
}
