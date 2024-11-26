-- 테이블 생성 시 init.sql을 실행하세요.

-- CREATE TABLE Member (
--     m_id VARCHAR(10) NOT NULL,             -- 학번
--     m_password VARCHAR(16) NOT NULL,       -- 비밀번호
--     m_name VARCHAR(20) NOT NULL,           -- 이름
--     m_date VARCHAR(30),                    -- 생일
--     m_email VARCHAR(50),                   -- 이메일
--     m_phone VARCHAR(20),                   -- 전화번호
--     PRIMARY KEY (m_id)
-- ) DEFAULT CHARSET=utf8;

INSERT INTO Member (m_id, m_password, m_name, m_date, m_email, m_phone) VALUES
('20210001', 'password1', '김철수', '2000-01-15', 'kimchulsoo@email.com', '010-1234-5678'),
('20210002', 'password2', '이영희', '2001-02-20', 'leeyounghee@email.com', '010-2345-6789'),
('20210003', 'password3', '박지민', '1999-03-30', 'parkjimin@email.com', '010-3456-7890'),
('20210004', 'password4', '정수빈', '2000-04-25', 'jungsoobin@email.com', '010-4567-8901'),
('20210005', 'password5', '최준호', '2001-05-05', 'choijunho@email.com', '010-5678-9012'),
('20220006', 'password6', '김미영', '2000-06-18', 'kimmiyeong@email.com', '010-6789-0123'),
('20220007', 'password7', '이민호', '2001-07-22', 'leeminho@email.com', '010-7890-1234'),
('20220008', 'password8', '홍길동', '1999-08-09', 'honggildong@email.com', '010-8901-2345'),
('20220009', 'password9', '조현우', '2000-09-12', 'johyunwoo@email.com', '010-9012-3456'),
('20220010', 'password10', '손예진', '2001-10-05', 'sonyejin@email.com', '010-0123-4567'),
('20230011', 'password11', '김수현', '1999-11-30', 'kimsuhyun@email.com', '010-1234-6789'),
('20230012', 'password12', '이준호', '2000-12-25', 'leejunho@email.com', '010-2345-7890'),
('20230013', 'password13', '박서준', '2001-01-10', 'parkseojun@email.com', '010-3456-8901'),
('20230014', 'password14', '강호동', '1999-02-14', 'kanghodong@email.com', '010-4567-9012'),
('20230015', 'password15', '김태희', '2000-03-21', 'kimtaehee@email.com', '010-5678-0123');

-- select * from member;
--drop table member;