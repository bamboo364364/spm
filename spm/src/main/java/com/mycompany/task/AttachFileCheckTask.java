package com.mycompany.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.mycompany.mapper.AdminMapper;
import com.mycompany.model.AttachImageVO;

import lombok.extern.log4j.Log4j;

@Component

public class AttachFileCheckTask {
	
	private final Logger logger= LoggerFactory.getLogger(this.getClass());

	@Autowired
	private AdminMapper adminMapper;
	
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}	
	
	@Scheduled(cron="0 * * * * *")
	public void checkFiles() throws Exception{	
		
		logger.warn("File Check Task Run..........");
		logger.warn(/* new Date() */"����newData()������");
		logger.warn("========================================");		
		
		// DB�� ����� ���� ����Ʈ
		List<AttachImageVO> fileList = adminMapper.checkFileList();		
		
		
		// �� ���� ���� ����Ʈ(Path��ü)
		List<Path> checkFilePath = new ArrayList<Path>();
			//���� �̹���
		fileList.forEach(vo -> {
			Path path = Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
			checkFilePath.add(path);
		});		
			//����� �̹���
		fileList.forEach(vo -> {
			Path path = Paths.get("C:\\upload", vo.getUploadPath(), "s_" +  vo.getUuid() + "_" + vo.getFileName());
			checkFilePath.add(path);
		});
		
		
		// ���丮 ���� ����Ʈ
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
		File[] targetFile = targetDir.listFiles();
		
		
		// ���� ��� ���� ����Ʈ(�з�)
		List<File> removeFileList = new ArrayList<File>(Arrays.asList(targetFile));		
		for(File file : targetFile){
			checkFilePath.forEach(checkFile ->{
				if(file.toPath().equals(checkFile)) 
					removeFileList.remove(file);	
			});
		}
		
		
		// ���� ��� ���� ����
		logger.warn("file Delete : ");
		for(File file : removeFileList) {
			logger.warn("file�̿�����");
			file.delete();
		}		
		
		logger.warn("========================================");
		
	}
	
	
}