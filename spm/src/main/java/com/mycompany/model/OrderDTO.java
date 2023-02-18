package com.mycompany.model;

import java.util.Date;
import java.util.List;

public class OrderDTO {

	/* �ֹ� ��ȣ */
	private String orderId;

	/* �ֹ� ȸ�� ���� */
	private String memberMail;
	
	/* �����θ� */
	private String memberName;
	
	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	/* �����ȣ */
	private String memberAddr1;
	
	/* ȸ�� �ּ� */
	private String memberAddr2;
	
	/* ȸ�� ���ּ� */
	private String memberAddr3;
	
	/* �ֹ� ���� */
	private String orderState;
	
	/* �ֹ� ��ǰ */
	private List<OrderItemDTO> orders;	
	
	/* ��ۺ� */
	private int deliveryCost;
	
	/* ��� ����Ʈ */
	private int usePoint;
	
	/* �ֹ� ��¥ */
	private Date orderDate;
	
	/* DB���̺� ���� ���� �ʴ� ������ */
	
	/* �ǸŰ�(��� ��ǰ ���) */
	private int orderSalePrice;
	
	/* ���� ����Ʈ */
	private int orderSavePoint;
	
	/* ���� �Ǹ� ��� */
	private int orderFinalSalePrice;

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}


	public String getMemberMail() {
		return memberMail;
	}

	public void setMemberMail(String memberMail) {
		this.memberMail = memberMail;
	}

	public String getMemberAddr1() {
		return memberAddr1;
	}

	public void setMemberAddr1(String memberAddr1) {
		this.memberAddr1 = memberAddr1;
	}

	public String getMemberAddr2() {
		return memberAddr2;
	}

	public void setMemberAddr2(String memberAddr2) {
		this.memberAddr2 = memberAddr2;
	}

	public String getMemberAddr3() {
		return memberAddr3;
	}

	public void setMemberAddr3(String memberAddr3) {
		this.memberAddr3 = memberAddr3;
	}

	public String getOrderState() {
		return orderState;
	}

	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}

	public List<OrderItemDTO> getOrders() {
		return orders;
	}

	public void setOrders(List<OrderItemDTO> orders) {
		this.orders = orders;
	}

	public int getDeliveryCost() {
		return deliveryCost;
	}

	public void setDeliveryCost(int deliveryCost) {
		this.deliveryCost = deliveryCost;
	}

	public int getUsePoint() {
		return usePoint;
	}

	public void setUsePoint(int usePoint) {
		this.usePoint = usePoint;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public int getOrderSalePrice() {
		return orderSalePrice;
	}

	public void setOrderSalePrice(int orderSalePrice) {
		this.orderSalePrice = orderSalePrice;
	}

	public int getOrderSavePoint() {
		return orderSavePoint;
	}

	public void setOrderSavePoint(int orderSavePoint) {
		this.orderSavePoint = orderSavePoint;
	}

	public int getOrderFinalSalePrice() {
		return orderFinalSalePrice;
	}

	public void setOrderFinalSalePrice(int orderFinalSalePrice) {
		this.orderFinalSalePrice = orderFinalSalePrice;
	}

	@Override
	public String toString() {
		return "OrderDTO [orderId=" + orderId + ", memberMail=" + memberMail + ", memberName=" + memberName
				+ ", memberAddr1=" + memberAddr1 + ", memberAddr2=" + memberAddr2 + ", memberAddr3=" + memberAddr3
				+ ", orderState=" + orderState + ", orders=" + orders + ", deliveryCost=" + deliveryCost + ", usePoint="
				+ usePoint + ", orderDate=" + orderDate + ", orderSalePrice=" + orderSalePrice + ", orderSavePoint="
				+ orderSavePoint + ", orderFinalSalePrice=" + orderFinalSalePrice + "]";
	}	
	
	public void getOrderPriceInfo() {
		/* ��ǰ ��� & ��������Ʈ */
			for(OrderItemDTO order : orders) {
				orderSalePrice += order.getTotalPrice();
				orderSavePoint += order.getTotalSavePoint();
			}
		/* ��ۺ�� */
			if(orderSalePrice >= 30000) {
				deliveryCost = 0;
			} else {
				deliveryCost = 3000;
			}
		/* ���� ���(��ǰ ��� + ��ۺ� - ��� ����Ʈ) */
			orderFinalSalePrice = orderSalePrice + deliveryCost - usePoint;
	}	
	
	
}
