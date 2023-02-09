package com.mycompany.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.mapper.AdminMapper;
import com.mycompany.model.CateVO;

@Service
public class AdminServiceImpl implements AdminService {

@Autowired
private AdminMapper adminMapper;
	
	/* ī�װ� ����Ʈ */
	@Override
	public List<CateVO> cateList(){
	return adminMapper.cateList();
	};


}//clss
