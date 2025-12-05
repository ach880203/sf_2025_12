package org.zerock.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
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
