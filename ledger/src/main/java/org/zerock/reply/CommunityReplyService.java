package org.zerock.reply;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.reply.CommunityReplyDTO;
import org.zerock.reply.CommunityReplyListPaginDTO;
import org.zerock.reply.CommunityReplyMapper;
import org.zerock.exception.CommunityReplyException;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor  //생성자 주입
public class CommunityReplyService {
	
	private final CommunityReplyMapper communityReplyMapper;
	
	public void add(CommunityReplyDTO communityReplyDTO) {
		
		try {communityReplyMapper.insert(communityReplyDTO);
		}catch(Exception e) {
			throw new CommunityReplyException(500, "Insert Error");
		}
	}
	
	public CommunityReplyDTO getOne(int rno) {
		
		try {
			return communityReplyMapper.read(rno);
		}catch(Exception e) {
			throw new CommunityReplyException(404, "Not Found");
		}
	}
	
	public void modify(CommunityReplyDTO dto, String loginUser){

	    CommunityReplyDTO origin = communityReplyMapper.read(dto.getRno());

	    if(origin == null){
	        throw new CommunityReplyException(404, "Not Found");
	    }

	    if(!origin.getReplyer().equals(loginUser)){
	        throw new CommunityReplyException(403, "No Permission");
	    }

	    communityReplyMapper.update(dto);
	}
	
	public void remove(int rno, String loginUser) {

	    CommunityReplyDTO origin;

	    try {
	        origin = communityReplyMapper.read(rno);
	    } catch (Exception e) {
	        throw new CommunityReplyException(500, "Read Error");
	    }

	    if(origin == null) {
	        throw new CommunityReplyException(404, "Not Found");
	    }

	    // 🔒 권한 체크 (댓글 작성자만 삭제 가능)
	    if(!origin.getReplyer().equals(loginUser)) {
	        throw new CommunityReplyException(403, "No Permission");
	    }

	    try {
	        int count = communityReplyMapper.delete(rno);

	        if(count == 0) {
	            throw new CommunityReplyException(404, "Not Found");
	        }
	    } catch (Exception e) {
	        throw new CommunityReplyException(500, "Delete Error");
	    }
	}

	
	public CommunityReplyListPaginDTO listOfBoard(Long bno, int page, int size) {
		try {
			
			int skip = (page-1) * size;
			
			List<CommunityReplyDTO> communityReplyDTOList = communityReplyMapper.listOfBoard(bno, skip, size);
			int count = communityReplyMapper.countOfBoard(bno);
			
			return new CommunityReplyListPaginDTO(communityReplyDTOList, count, page, size);
			
		}catch(Exception e) {
			throw new CommunityReplyException(500, e.getMessage());
		}
	}
	

}

















