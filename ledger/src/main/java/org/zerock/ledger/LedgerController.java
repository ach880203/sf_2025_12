package org.zerock.ledger;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.Account.AccountDTO;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/ledger")
@RequiredArgsConstructor
@Log4j2
public class LedgerController {

  private final LedgerService ledgerService;

  @GetMapping("/list")
  public String list(LedgerListDTO cri, Model model) {

      Authentication auth = SecurityContextHolder.getContext().getAuthentication();
      AccountDTO principal = (AccountDTO) auth.getPrincipal();
      String uid = principal.getUid();

      log.info("LEDGER LIST uid={}, cri={}", uid, cri);

      model.addAttribute("dto", ledgerService.getList(uid, cri));
      return "ledger/ledgerList";
  }
}
