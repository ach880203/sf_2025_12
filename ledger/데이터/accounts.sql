-- 11. 트랜잭션
-- 커밋, 롤백

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    id INT PRIMARY KEY,
    owner_name VARCHAR(255) NOT NULL,
    balance INT NOT NULL
);

-- 초기 데이터 입력
INSERT INTO accounts (id, owner_name, balance) VALUES
(1, 'A고객', 50000),
(2, 'B고객', 20000);