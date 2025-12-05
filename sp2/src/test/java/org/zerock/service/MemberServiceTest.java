package org.zerock.service;

import static org.junit.jupiter.api.Assertions.*;

import java.lang.reflect.Member;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.MemberDTO;
import org.zerock.mapper.MemberMapper;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
class MemberServiceTest {

	@Autowired
	private MemberService memberService;
	
	@Test
	void test() {
		memberService.getList()
		 .forEach(Member-> log.info(Member));
	}
	
	//단건조회
	@Test
	void testOne() {
		MemberDTO dto = memberService.memberById(1);
		
		log.info(dto);
	}//end testOne
	
	@Test
	void testInsert() {
		MemberDTO dto = MemberDTO.builder()
				.name("이순신")
				.email("test6@test.com")
				.password("1234")
				.build();
				
	  memberService.insert(dto);
	}//end insert test
	
	@Test
	void testUpdate() { 
		MemberDTO dto = MemberDTO.builder()
				.name("이신")
				.email("test5@test.com")
				.password("1234")
				.mno(6)
				.build();
				
	  memberService.update(dto);
	}//end update test
	
	@Test
	void testDelete() {
		memberService.delete(6);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
