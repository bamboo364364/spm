package com.mycompany.service;

import java.util.List;

import com.mycompany.model.AttachImageVO;

public interface AttachService {
	
	/* �̹��� ������ ��ȯ */
	public List<AttachImageVO> getAttachList(int bookId);	

}
