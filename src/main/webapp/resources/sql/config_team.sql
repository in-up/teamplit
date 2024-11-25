-- 테이블 생성 시 init.sql을 실행하세요.

CREATE TABLE Team (
    t_id INT NOT NULL AUTO_INCREMENT,      -- ID (자동증분)
    t_name VARCHAR(100) NOT NULL,          -- 팀명
    t_capacity INT NOT NULL,               -- 팀 최대 정원
    t_manager_id VARCHAR(10),              -- 팀장 학번 (member 테이블의 m_id)
    t_description TEXT,                    -- 팀 설명
    t_invite_code VARCHAR(20),             -- 초대 코드
    t_date VARCHAR(30),                    -- 팀 생성일 (기본값: 현재 시간)
    t_filename VARCHAR(255),               -- 파일 이름 (프로필 저장)
    
    PRIMARY KEY (t_id)
) DEFAULT CHARSET=utf8;


INSERT INTO Team (t_name, t_capacity, t_manager_id, t_filename, t_description, t_invite_code, t_date) VALUES
('원팀 ONETEAM', 6, '20210001', '1.png', '[웹프로그래밍] 원팀정신으로 1등하기', '1234', '2024-11-24'),
('개발새발', 7, '20220006', '2.png', '[오픈소스SW실습] 개발자의 발전을, 새로운 발견을. 개발새발 팀입니다.', '1234', '2024-11-24'),
('재개발조합', 10, '20230011', '3.png', '[지능웹설계] 재개발조합은 우리학과 개발 생태계를 송두리째 바꿀 최강의 풀스택 개발 팀입니다.', '1234', '2024-11-24');


select * from team;

--drop table team;