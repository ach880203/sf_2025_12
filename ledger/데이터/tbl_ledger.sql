use springdb;

CREATE TABLE tbl_ledger (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  
  user_id VARCHAR(50) NOT NULL,          -- 로그인 사용자 식별
  
  type ENUM('INCOME', 'EXPENSE') NOT NULL,  -- 수입/지출
  amount INT NOT NULL,                      -- 금액(정수) 
  category VARCHAR(30) NOT NULL,            -- 카테고리
  
  title VARCHAR(100) NOT NULL,              -- 거래명
  memo VARCHAR(500) NULL,                   -- 짧은 메모
  
  spent_at DATETIME NOT NULL,               -- 실제 거래 일시 (검색/정렬 핵심)
  
  delflag TINYINT(1) NOT NULL DEFAULT 0,    -- 소프트 삭제 (0=정상, 1=삭제)
  
  regdate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updatedate DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

select * from tbl_ledger;

-- 사용자별 + 거래일시 정렬/검색
CREATE INDEX idx_ledger_user_spentat
ON tbl_ledger(user_id, spent_at);

-- 타입/카테고리로 필터 많이 할 거라면
CREATE INDEX idx_ledger_type_category
ON tbl_ledger(type, category);

-- 댓글 조회: 거래글 기준으로 최신순
CREATE INDEX idx_ledger_reply_ledgerid_rno
ON tbl_ledger_reply(ledger_id, rno);

DESC tbl_ledger;
SHOW INDEX FROM tbl_ledger_reply;
SHOW INDEX FROM tbl_ledger;

