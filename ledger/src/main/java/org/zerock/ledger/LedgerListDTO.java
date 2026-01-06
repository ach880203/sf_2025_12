package org.zerock.ledger;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LedgerListDTO {

  // ====== 페이징 ======
  private int pageNum = 1;   // 기본 1페이지
  private int amount = 10;   // 기본 10개

  public int getSkip() {
    return (pageNum - 1) * amount;
  }

  public void normalize() {
    if (pageNum <= 0) pageNum = 1;
    if (amount <= 0) amount = 10;
  }

  // ====== 검색 조건 ======
  private String ledgerType;   // INCOME/EXPENSE
  private String category;
  private String keyword;      // title/memo 검색용
  private String fromDate;     // yyyy-MM-dd
  private String toDate;       // yyyy-MM-dd
}
