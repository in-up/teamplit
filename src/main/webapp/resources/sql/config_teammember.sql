-- 테이블 생성 시 init.sql을 실행하세요.

-- CREATE TABLE TeamMember (
--     tm_t_id VARCHAR(10) NOT NULL,          -- 팀ID
--     tm_m_id VARCHAR(10) NOT NULL,		   -- 학번
--     tm_role VARCHAR(50),				   -- 역할
--     PRIMARY KEY (tm_t_id, tm_m_id)         -- (팀ID + 학번 PK)
-- ) DEFAULT CHARSET=utf8;

INSERT INTO TeamMember (tm_t_id, tm_m_id, tm_role) VALUES
('1', '20230001', ''),
('1', '20230002', ''),
('1', '20230003', ''),
('1', '20230004', ''),
('1', '20230005', ''),
('2', '20230006', ''),
('2', '20230007', ''),
('2', '20230008', ''),
('2', '20230009', ''),
('2', '20230010', ''),
('3', '20230011', ''),
('3', '20230012', ''),
('3', '20230013', ''),
('3', '20230014', ''),
('3', '20230015', '');

select * from teammember;

--drop table teammember;