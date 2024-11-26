# Teamplit
지능웹설계 학기 프로젝트 **Teamplit** 실행 가이드입니다.

## 실행 환경
- **MySQL 8.0.33**
- **Apache Tomcat 10.1**
- **Java SE 19**

## 서버 연결하기
1. (Eclipse 기준) **Database Connection**을 생성합니다.
2. MySQL JDBC 드라이버 경로를 `./src/main/webapp/WEB-INF/lib/mysql-connector-j-8.0.33.jar`로 설정합니다.
3. **TeamplitDB**와 연결을 완료합니다.

## 서버 실행하기
1. **Apache Tomcat v10.1**을 실행합니다.
2. 데이터베이스를 최초 연결하기 위해 `./src/main/webapp/resources/sql/init.sql` 테이블 생성문을 실행합니다.
    - 추가로 예시 데이터를 삽입하려면, 아래 네 개의 sql도 실행해야 합니다.
        - `config_member.sql` : 15개의 회원 데이터를 삽입합니다.
        - `config_team.sql` : 3개의 팀 데이터를 삽입합니다.
        - `config_teammember.sql` : 15개의 팀-회원 소속 데이터를 삽입합니다.
        - `config_board.sql` : 6개의 게시글 데이터를 삽입합니다.
3. `/main.jsp` 경로로 접속하면, **팀플릿 실행이 완료**됩니다.