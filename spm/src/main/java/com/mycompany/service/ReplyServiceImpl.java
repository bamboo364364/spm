package com.mycompany.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.controller.ReplyController;
import com.mycompany.mapper.ReplyMapper;
import com.mycompany.model.Criteria;
import com.mycompany.model.GoodVO;
import com.mycompany.model.ReplyDTO;

@Service
public class ReplyServiceImpl implements ReplyService {

	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);


@Autowired
private ReplyMapper replyMapper;


/* 리플 등록 */
@Override
	public int replyEnroll(ReplyDTO dto){
	logger.info("리플등록 메서드 진입");
	logger.info("dto는"+ dto.toString());
	double avg= replyMapper.ratingAvgGet(dto.getGoodId());
	logger.info("ratingAvgGet은"+ avg);
	double nAvg= dto.getRating() ;
	int repTotal= replyMapper.rootReplyGetTotal(dto);
	logger.info("total는"+ repTotal);
	double rAvg= (avg*repTotal+ nAvg)/(repTotal+ 1); 
	logger.info("rAvg는"+ rAvg);
	GoodVO gv= new GoodVO();
	gv.setGoodId(dto.getGoodId());
	gv.setRatingAvg(rAvg);
	logger.info("gv는"+ gv.toString());
	replyMapper.ratingAvgUpdate(gv);
	
	return replyMapper.replyEnroll(dto);
	
	};


/* 리플 페이징 */
@Override
	public List<ReplyDTO> replyList(Criteria cri){
	return replyMapper.replyList(cri);
	}
	
	
/* 리플 수정 */
@Override
	public void replyModify(ReplyDTO dto){
	logger.info("리플수정 메서드 진입");
	ReplyDTO oDto= replyMapper.replySearch(dto);
	double oAvg= oDto.getRating();
	
	double avg= replyMapper.ratingAvgGet(dto.getGoodId());
	
	double nAvg= dto.getRating() ;
	
	int repTotal= replyMapper.rootReplyGetTotal(dto);
	
	double rAvg= ( avg*repTotal- oAvg+ nAvg )/ repTotal ;
	
	
	GoodVO gv= new GoodVO();
	gv.setGoodId(dto.getGoodId());
	gv.setRatingAvg(rAvg);
	logger.info("gv"+gv);
	replyMapper.ratingAvgUpdate(gv);
	
	replyMapper.replyModify(dto);
	
	};

/* 리플삭제 */
@Override
	public void replyDelete(ReplyDTO dto){
	logger.info("리플삭제 메서드 진입");
	List<ReplyDTO>dDtoL= replyMapper.replySearches(dto);
	
	double avg= replyMapper.ratingAvgGet(dto.getGoodId());

	int repTotal= replyMapper.rootReplyGetTotal(dto);
	
	double avgRt= avg* repTotal;
	
	double dAvg= 0.0;
	
	for(ReplyDTO dDto: dDtoL){
		dAvg+= dDto.getRating();
		
	}
	
	double rAvg=0.0;
	if( repTotal- dDtoL.size()== 0 ){rAvg= 0.0;}else{
	rAvg= (avgRt- dAvg)/(repTotal- dDtoL.size()); }//else
	
	GoodVO gv= new GoodVO();
	gv.setGoodId(dto.getGoodId());
	gv.setRatingAvg(rAvg);
	replyMapper.ratingAvgUpdate(gv);
	if( dto.getNtReplyId()==0 ){ dto.setNtReplyId(-1);}
	replyMapper.replyDelete(dto);
	
	}
	
	
	/* 리리플 등록 */
	@Override
	public void rReplyEnroll(ReplyDTO dto){
	replyMapper.rReplyEnroll(dto);
	}
	
	/* 리리플뒤에있는 replyId 밀어주기 */
	@Override
	public void pushReplyId(int replyId){
	replyMapper.pushReplyId(replyId);
	}
	


	/* 리플수(페이지계산) */
	@Override
	public int replyGetTotal(ReplyDTO dto){
	return replyMapper.replyGetTotal(dto);
	}
	
	
	







}//class
