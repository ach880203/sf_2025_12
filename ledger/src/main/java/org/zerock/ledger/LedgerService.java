package org.zerock.ledger;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
@RequiredArgsConstructor
public class LedgerService {

  private final LedgerMapper ledgerMapper;
  	
  public LedgerPageDTO getList(String uid, LedgerListDTO cri) {

	    if (cri == null) cri = new LedgerListDTO();
	    cri.normalize();

	    log.info("CRI CHECK fromDate='{}' toDate='{}' type='{}' category='{}' keyword='{}' pageNum={} amount={} skip={}",
	    	    cri.getFromDate(), cri.getToDate(),
	    	    cri.getLedgerType(), cri.getCategory(), cri.getKeyword(),
	    	    cri.getPageNum(), cri.getAmount(), cri.getSkip());

	    var list = ledgerMapper.selectList(uid, cri);
	    var total = ledgerMapper.getTotal(uid, cri);

	    log.info("LEDGER RESULT total={}, listSize={}", total, (list == null ? 0 : list.size()));

	    return LedgerPageDTO.of(list, total, cri);
	  }
	}
  
  /*public LedgerPageDTO getList(String uid, LedgerListDTO cri) {
 
    if (cri == null) cri = new LedgerListDTO();
    cri.normalize();
    
    log.info("LEDGER SERVICE uid={}, cri={}", uid, cri);
    
    List<LedgerDTO> list = ledgerMapper.selectList(uid, cri);
    int total = ledgerMapper.getTotal(uid, cri);

    return LedgerPageDTO.of(list, total, cri);
  }
}*/
