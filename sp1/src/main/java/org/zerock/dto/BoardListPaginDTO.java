package org.zerock.dto;

import java.util.List;
import java.util.stream.IntStream;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@ToString
@Getter
@Setter
public class BoardListPaginDTO {

	private List<BoardDTO> boardDTOList; //전체 목록
	
	private int totalCount; //전체 갯수
	
	private int page, size; //페이지 번호, 화면당 보여주는 갯수
	
	private int start, end; //페이지 시작, 끝
	private boolean prev, next; // 페이지 이전, 다음 버튼
	private List<Integer> pageNums;
	
	
	public BoardListPaginDTO(List<BoardDTO> boardDTOList, int totalCount, int page, int size) {
		this.boardDTOList = boardDTOList;
		this.totalCount = totalCount;
		this.page = page;
		this.size = size;
		
		//start계산을 위한 end 페이지
		int tempEnd = (int)(Math.ceil(page/10.0)) * 10;
		
		this.start = tempEnd - 9;
		
		if( (tempEnd * size) > totalCount) {
			this.end = (int)(Math.ceil(totalCount/(double)size));
		}else {
			this.end = tempEnd;
		}
		
		//prev, next계산
		this.prev =  start != 1;
		this.next = totalCount > (this.end * size);
		
		this.pageNums = IntStream.rangeClosed(start, end)
						.boxed().toList();
		
	}
	
}
