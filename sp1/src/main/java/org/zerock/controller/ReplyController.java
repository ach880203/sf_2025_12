package org.zerock.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.dto.ReplyDTO;
import org.zerock.dto.SampleDTO;
import org.zerock.service.ReplyService;
import org.zerock.service.exception.ReplyException;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@RestController
@RequiredArgsConstructor
@Log4j2
@RequestMapping("/replies")
public class ReplyController {
   
   private final ReplyService replyService;
   
   @ExceptionHandler(ReplyException.class)
   public ResponseEntity<String> handleReplyError(ReplyException ex){
      log.error(ex.getMessage());
      return ResponseEntity.status(ex.getCode()).body(ex.getMsg());
   }

   @PostMapping("")
   public ResponseEntity<Map<String, Integer>> add(@RequestBody ReplyDTO replyDTO){
      log.info(replyDTO);
      
      replyService.add(replyDTO);
      
      return ResponseEntity.ok(Map.of("result", replyDTO.getRno()));
   }
   
}
