package org.zerock.mapper;

import static org.junit.jupiter.api.Assertions.*;

import java.lang.reflect.Member;

import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.MemberDTO;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
class MemberMapperTests {

	@Autowired
	private MemberMapper memberMapper;
	
	@Test
	void testInsert() {
		MemberDTO dto = MemberDTO.builder()
				.name("홍길")
				.email("test3@test.com")
				.password("1234")
				.build();
		
		memberMapper.insert(dto);
		
		//log.info("생성된 PK:" + dto.getMno());
		//두 가지로 시험해 볼 수 있다. ↑↓
		assertNotNull(dto.getMno());
		
	}
	
	@Test
	void testList() {
		memberMapper.getList()
		.forEach(member -> log.info(member));
		 
	}
	
	@Test
	void testMemberById() {
		MemberDTO dto = memberMapper.memberById(3);
		
		log.info(dto);
	}
	
	@Test
	void testUpdate() {
		MemberDTO dto = MemberDTO.builder()
				.name("김유신")
				.password("1234")
				.email("test@tes11.com")
				.mno(3)
				.build();
		
		memberMapper.update(dto);
		
		log.info(memberMapper.memberById(3));
	}//end update test
	
	@Test
	void testdelete() {
		memberMapper.delete(4);
	}

}
