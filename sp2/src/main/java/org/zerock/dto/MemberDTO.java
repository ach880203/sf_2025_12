package org.zerock.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MemberDTO {
	private int mno;
	private String name;
	private String email;
	private String password;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
	
	public String getCreatedDate() {
		 return regDate.format(DateTimeFormatter.ISO_DATE);
	}
}
