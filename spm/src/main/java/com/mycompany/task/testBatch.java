package com.mycompany.task;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



@Component
public class testBatch {
	
private static final Logger logger = LoggerFactory.getLogger(testBatch.class);

@Scheduled(cron= "0 * * * * *")
public void testMethod()throws Exception{
logger.warn("123");
}
	
		
	

}
