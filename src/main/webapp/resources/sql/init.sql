USE TeamplitDB;

CREATE TABLE Member (
    m_id VARCHAR(10) NOT NULL,             -- 학번
    m_password VARCHAR(16) NOT NULL,       -- 비밀번호
    m_name VARCHAR(20) NOT NULL,           -- 이름
    m_date VARCHAR(30),                    -- 생일
    m_email VARCHAR(50),                   -- 이메일
    m_phone VARCHAR(20),                   -- 전화번호
    PRIMARY KEY (m_id)
) DEFAULT CHARSET=utf8;

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

CREATE TABLE TeamMember (
    tm_t_id VARCHAR(10) NOT NULL,          -- 팀ID
    tm_m_id VARCHAR(10) NOT NULL,		   -- 학번
    tm_role VARCHAR(50),				   -- 역할
    tm_date VARCHAR(10),
    PRIMARY KEY (tm_t_id, tm_m_id)         -- (팀ID + 학번 PK)
) DEFAULT CHARSET=utf8;

CREATE TABLE Board (
    b_num int not null auto_increment,     -- 게시물번호 (자동증분)
    b_m_id varchar(10) not null,	       -- 작성자 학번
    b_m_name varchar(10) not null,		   -- 작성자 이름
    b_t_id varchar(100) not null,		   -- 팀ID
    b_title VARCHAR(100) NOT NULL;		   -- 글제목
    b_content text not null,	           -- 콘텐츠 (글)
    b_date varchar(30),			           -- 작성일
    b_hit int,				               -- 조회수
    PRIMARY KEY (b_num)
)default CHARSET=utf8;