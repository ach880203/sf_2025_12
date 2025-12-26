package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/account")
public class AccountController {

    @GetMapping("/login")
    public void loginGET() {
        log.info("LOGIN PAGE");
    }

    // 로그아웃 확인 페이지
    @GetMapping("/logout")
    public void logoutGET() {
        log.info("LOGOUT CONFIRM PAGE");
    }

    // 로그아웃 완료 페이지
    @GetMapping("/logoutSuccess")
    public void logoutSuccessGET(){
        log.info("LOGOUT SUCCESS PAGE");
    }
}
