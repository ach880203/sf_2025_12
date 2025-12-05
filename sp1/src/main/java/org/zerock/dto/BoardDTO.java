package org.zerock.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter //맴버변수 변경 가능
@Getter //조회
@ToString //멤버변수 값 조회
@AllArgsConstructor // 생성자 
@NoArgsConstructor //디폴트 생성자
@Builder            //setter 대용으로 사용가능 - 요즘에 많이 사용됨
public class BoardDTO {
	
	private Long bno;
	private String title;
	private String writer;
	private String content;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;;
	private boolean delFlag;
	
	public String getCreatedDate() {
		 return regDate.format(DateTimeFormatter.ISO_DATE);
	}
	
	

}
