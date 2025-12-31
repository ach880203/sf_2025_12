CREATE TABLE tbl_ledger_reply (
  rno BIGINT AUTO_INCREMENT PRIMARY KEY,
  
  ledger_id BIGINT NOT NULL,               -- 어떤 거래글에 달린 댓글인지
  reply VARCHAR(1000) NOT NULL,
  replyer VARCHAR(50) NOT NULL,            -- 작성자(user_id)
  
  delflag TINYINT(1) NOT NULL DEFAULT 0,
  
  regdate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updatedate DATETIME NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT fk_ledger_reply
    FOREIGN KEY (ledger_id) REFERENCES tbl_ledger(id)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DESC tbl_ledger_reply;

