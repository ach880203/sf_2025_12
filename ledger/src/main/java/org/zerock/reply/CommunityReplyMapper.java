package org.zerock.reply;

import java.util.List;

import org.apache.ibatis.annotations.Param;



public interface CommunityReplyMapper {
	
	int insert(CommunityReplyDTO communityReplyDTO);
	
	CommunityReplyDTO read(@Param("rno") int rno);

	int delete(@Param("rno") int rno);
	
	int update(CommunityReplyDTO communityReplyDTO);
	
	List<CommunityReplyDTO> listOfBoard(
			@Param("bno") Long bno,
			@Param("skip") int skip,
			@Param("limit") int  limit			
			);

	int countOfBoard(Long bno);
}
