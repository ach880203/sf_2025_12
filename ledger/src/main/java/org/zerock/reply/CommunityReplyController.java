package org.zerock.reply;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/replies")
public class CommunityReplyController{
	
	private final CommunityReplyService service;
	
	@PostMapping("")
	public ResponseEntity<Map<String, Integer>> add(
			@RequestBody CommunityReplyDTO dto,
			Authentication auth){
		
		dto.setReplyer(auth.getName());
		
		service.add(dto);
		return ResponseEntity.ok(Map.of("rno", dto.getRno()));
	}
	
	@GetMapping("/{bno}/list")
	public CommunityReplyListPaginDTO list(
			@PathVariable Long bno,
			@RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "10") int size) {
		return service.listOfBoard(bno, page, size);
	}
	
	@GetMapping("/{rno}")
	public CommunityReplyDTO read(@PathVariable int rno) {
		return service.getOne(rno);
	}
	
	
	@PutMapping("/{rno}")
    public Map<String,String> modify(
            @PathVariable int rno,
            @RequestBody CommunityReplyDTO dto,
            Authentication auth){

        dto.setRno(rno);
        service.modify(dto, auth.getName());
        return Map.of("result","modified");
    }
	

    @DeleteMapping("/{rno}")
    public Map<String,String> remove(
            @PathVariable int rno,
            Authentication auth){

        service.remove(rno, auth.getName());
        return Map.of("result","deleted");
    }
	
	
	
}




