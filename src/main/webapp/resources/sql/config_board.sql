-- 테이블 생성 시 init.sql을 실행하세요.

-- CREATE TABLE Board (
--     b_num int not null auto_increment,     -- 게시물번호 (자동증분)
--     b_m_id varchar(10) not null,	       -- 작성자 학번
--     b_m_name varchar(10) not null,		   -- 작성자 이름
--     b_t_id varchar(100) not null,		   -- 팀ID
--     b_title VARCHAR(100) NOT NULL;		-- 글제목
--     b_content text not null,	           -- 콘텐츠 (글)
--     b_date varchar(30),			           -- 작성일
--     b_hit int,				               -- 조회수
--     PRIMARY KEY (b_num)
-- )default CHARSET=utf8;

-- 팀 1
INSERT INTO Board (b_m_id, b_m_name, b_t_id, b_title, b_content, b_date, b_hit) VALUES
('20210001', '김철수', '1', '원팀 프로젝트 소개', '안녕하세요, 원팀입니다. 이번 프로젝트에 대해 이야기 나눠보겠습니다.', '2024-11-24', 0),
('20210002', '이영희', '1', '원팀 첫 회의 결과', '원팀의 첫 번째 회의는 잘 진행되었습니다. 이제 계획을 세우고 시작해봅시다.', '2024-11-24', 0);

-- 팀 2
INSERT INTO Board (b_m_id, b_m_name, b_t_id, b_title, b_content, b_date, b_hit) VALUES
('20220006', '김미영', '2', '개발새발 프로젝트 시작', '개발새발의 두 번째 프로젝트가 시작되었습니다. 여러분 모두 힘내세요!', '2024-11-24', 0),
('20220007', '이민호', '2', '개발새발의 목표', '이번 개발새발 프로젝트는 개발새발로 하지 않는 것이 제 1의 목표입니다.', '2024-11-24', 0);

-- 팀 3
INSERT INTO Board (b_m_id, b_m_name, b_t_id, b_title, b_content, b_date, b_hit) VALUES
('20230011', '김수현', '3', '재개발조합 회의록 주소', '회의록을 아래 노션 주소에 첨부합니다. bit.ly/ThereIsNoSuchFiles', '2024-11-24', 0),
('20230012', '이준호', '3', '[공지사항] 서비스 이름 정하기', '세련되고 멋진 부동산 애플리케이션 이름을 정해야 해요.', '2024-11-24', 0);


-- select * from board;
-- desc board;
-- drop table board;
