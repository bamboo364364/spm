package com.mycompany.mapper;

import java.util.List;

import com.mycompany.model.AttachImageVO;

public interface AttachMapper {

	/* �̹��� ������ ��ȯ */
	public List<AttachImageVO> getAttachList(int bookId);	
	
}
