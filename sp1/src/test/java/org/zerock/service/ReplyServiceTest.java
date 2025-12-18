package org.zerock.service;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.ReplyDTO;
import org.zerock.dto.ReplyListPagiNDTO;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
class ReplyServiceTest {

	@Autowired
	private ReplyService replyService;
	
	@Test
	void testList() {
		
		ReplyListPagiNDTO list = replyService.listOfBoard(49999L, 2, 10);
		
		for(ReplyDTO dto :list.getReplyDTOList())
			log.info(dto);
	}

}
