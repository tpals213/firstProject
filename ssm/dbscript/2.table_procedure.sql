---------------------------------------------
-- DDL 생성 SCRIPT
---------------------------------------------

--DROP TABLE TB_STORE CASCADE CONSTRAINTS;
--DROP TABLE TB_USER CASCADE CONSTRAINTS;
--DROP TABLE TB_USER_FINKOUT CASCADE CONSTRAINTS;

DECLARE
  v_str VARCHAR(500);
  v_cnt NUMBER(5, 0) := 0;
BEGIN
   ----------------------------------
   -- TB_STORE
   ----------------------------------
   v_cnt := 0;
   SELECT nvl(count(*), 0) as cnt
     INTO v_cnt
   FROM USER_TABLES
   WHERE TABLE_NAME = 'TB_STORE';
	 
   IF v_cnt > 0 THEN
      EXECUTE IMMEDIATE 'DROP TABLE TB_STORE CASCADE CONSTRAINTS';
   END IF;

   ----------------------------------
   -- TB_USER
   ----------------------------------
   v_cnt := 0;
   SELECT nvl(count(*), 0) as cnt
     INTO v_cnt
   FROM USER_TABLES
   WHERE TABLE_NAME = 'TB_USER';
	 
   IF v_cnt > 0 THEN
      EXECUTE IMMEDIATE 'DROP TABLE TB_USER CASCADE CONSTRAINTS';
   END IF;
   
   ----------------------------------
   -- TB_USER
   ----------------------------------
   v_cnt := 0;
   SELECT nvl(count(*), 0) as cnt
     INTO v_cnt
   FROM USER_TABLES
   WHERE TABLE_NAME = 'TB_USER_FINKOUT';
	 
   IF v_cnt > 0 THEN
      EXECUTE IMMEDIATE 'DROP TABLE TB_USER_FINKOUT CASCADE CONSTRAINTS';
   END IF;
   
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

CREATE TABLE TB_USER (
    ID int PRIMARY KEY,
    USER_ID VARCHAR2(50) NOT NULL,
    PASSWD VARCHAR2(50) NOT NULL,
    EMAIL VARCHAR2(50) NOT NULL UNIQUE,
    USER_NO VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(20) NOT NULL,
    ACCOUNT_NUMBER VARCHAR2(20) NOT NULL,
    BANK_NAME VARCHAR2(20) NOT NULL,
    PROFILE_URL VARCHAR2(200) NULL,
    IS_QUIT CHAR DEFAULT 'N',
    ADMIN_OK CHAR DEFAULT 'N',
    LOGIN_OK CHAR DEFAULT 'Y',
    LAST_MODIFIED DATE DEFAULT SYSDATE,
    SERVICE_DATE DATE DEFAULT SYSDATE,
    BUSINESS_NO VARCHAR2(50),
    BUSINESS_STORE_NAME VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN TB_USER.ID IS '유저번호';
COMMENT ON COLUMN TB_USER.USER_ID IS '아이디';
COMMENT ON COLUMN TB_USER.PASSWD IS '비밀번호';
COMMENT ON COLUMN TB_USER.EMAIL IS '이메일';
COMMENT ON COLUMN TB_USER.USER_NO IS '주민번호';
COMMENT ON COLUMN TB_USER.PHONE IS '전화번호';
COMMENT ON COLUMN TB_USER.ACCOUNT_NUMBER IS '계좌번호';
COMMENT ON COLUMN TB_USER.BANK_NAME IS '은행명';
COMMENT ON COLUMN TB_USER.PROFILE_URL IS '프로필사진URL';
COMMENT ON COLUMN TB_USER.IS_QUIT IS '탈퇴여부';
COMMENT ON COLUMN TB_USER.LOGIN_OK IS '로그인가능여부';
COMMENT ON COLUMN TB_USER.LAST_MODIFIED IS '마지막수정일';
COMMENT ON COLUMN TB_USER.BUSINESS_NO IS '사업자번호';
COMMENT ON COLUMN TB_USER.BUSINESS_STORE_NAME IS '사업장명';

ALTER TABLE TB_USER
MODIFY (ACCOUNT_NUMBER VARCHAR2(20) null);

ALTER TABLE TB_USER
MODIFY (BANK_NAME VARCHAR2(20) NULL);

ALTER TABLE TB_USER
MODIFY (PASSWD VARCHAR2(100));

COMMIT;

CREATE TABLE TB_USER_FINKOUT (
    FINKOUT_NO INT,
    USER_ID VARCHAR2(50),
    EMAIL VARCHAR2(50),
    FINKOUT_DATE DATE DEFAULT SYSDATE,
    FOREIGN KEY (FINKOUT_NO) REFERENCES TB_USER (ID)
);

COMMENT ON COLUMN TB_USER_FINKOUT.FINKOUT_NO IS '탈퇴유저번호';
COMMENT ON COLUMN TB_USER_FINKOUT.USER_ID IS '탈퇴유저아이디';
COMMENT ON COLUMN TB_USER_FINKOUT.EMAIL IS '탈퇴유저이메일';
COMMENT ON COLUMN TB_USER_FINKOUT.FINKOUT_DATE IS '탈퇴일자';

COMMIT;


--DROP INDEX PK_TB_SUBSCRIBE;
DROP TABLE TB_SUBSCRIBE CASCADE CONSTRAINTS;
	
CREATE TABLE TB_SUBSCRIBE (
	SUBSCRIBE_NO NUMBER NOT NULL,
	SUBSCRIBE_NAME VARCHAR2(200) NOT NULL,
	PRICE NUMBER NOT NULL,
	SUBSCRIBE_DATE VARCHAR2(10)
);

COMMENT ON TABLE TB_SUBSCRIBE IS '구독상품';

COMMENT ON COLUMN TB_SUBSCRIBE.SUBSCRIBE_NO IS '상품번호';

COMMENT ON COLUMN TB_SUBSCRIBE.SUBSCRIBE_NAME IS '상품명';

COMMENT ON COLUMN TB_SUBSCRIBE.PRICE IS '가격';

COMMENT ON COLUMN TB_SUBSCRIBE.SUBSCRIBE_DATE IS '몇개월인지';

ALTER TABLE TB_SUBSCRIBE
	ADD
		CONSTRAINT PK_TB_SUBSCRIBE
		PRIMARY KEY (
			SUBSCRIBE_NO
		);

ALTER TABLE TB_SUBSCRIBE_PAYMENT DROP CONSTRAINT PK_TB_SUBSCRIBE_PAYMENT;

--DROP INDEX PK_TB_SUBSCRIBE_PAYMENT;

DROP TABLE TB_SUBSCRIBE_PAYMENT 
	CASCADE CONSTRAINTS;

CREATE TABLE TB_SUBSCRIBE_PAYMENT (
	PAY_NO NUMBER NOT NULL,
	SUBSCRIBE_NAME VARCHAR2(100) NOT NULL,
	AMOUNT NUMBER,
	USER_ID NUMBER,
	PAY_METHOD VARCHAR2(50) NOT NULL,
	PAY_DATE DATE DEFAULT SYSDATE NOT NULL
);

COMMENT ON TABLE TB_SUBSCRIBE_PAYMENT IS '구독결제';

COMMENT ON COLUMN TB_SUBSCRIBE_PAYMENT.PAY_NO IS '결제번호';

COMMENT ON COLUMN TB_SUBSCRIBE_PAYMENT.USER_ID IS '결제 유저';

COMMENT ON COLUMN TB_SUBSCRIBE_PAYMENT.PAY_METHOD IS '결제수단';

COMMENT ON COLUMN TB_SUBSCRIBE_PAYMENT.PAY_DATE IS '결제일시';

CREATE UNIQUE INDEX PK_TB_SUBSCRIBE_PAYMENT
	ON TB_SUBSCRIBE_PAYMENT (
		PAY_NO ASC
	);

ALTER TABLE TB_SUBSCRIBE_PAYMENT
	ADD
		CONSTRAINT PK_TB_SUBSCRIBE_PAYMENT
		PRIMARY KEY (
			PAY_NO
		);

ALTER TABLE TB_SUBSCRIBE_PAYMENT
ADD CONSTRAINT FK_TB_USER_TO_TB_SUBSCRIBE_PAYMENT
FOREIGN KEY (USER_ID)
REFERENCES TB_USER (ID)
ON DELETE SET NULL;


ALTER TABLE TB_NOTICE DROP CONSTRAINT PK_TB_NOTICE;
--DROP INDEX PK_TB_NOTICE;
DROP TABLE TB_NOTICE 
	CASCADE CONSTRAINTS;

CREATE TABLE TB_NOTICE (
	NOTICE_NO NUMBER NOT NULL,
	WRITER NUMBER,
	NOTICE_TITLE VARCHAR2(300) NOT NULL,
	NOTICE_CONTENT VARCHAR2(3000) NOT NULL,
	WRITE_DATE DATE DEFAULT SYSDATE NOT NULL,
	MODIFY_DATE DATE DEFAULT SYSDATE NOT NULL,
	READ_COUNT NUMBER NOT NULL,
	IMPORTANCY VARCHAR2(1) DEFAULT '1' NOT NULL
);

COMMENT ON TABLE TB_NOTICE IS '공지사항';

COMMENT ON COLUMN TB_NOTICE.NOTICE_NO IS '공지번호';

COMMENT ON COLUMN TB_NOTICE.NOTICE_TITLE IS '제목';

COMMENT ON COLUMN TB_NOTICE.NOTICE_CONTENT IS '내용';

COMMENT ON COLUMN TB_NOTICE.WRITE_DATE IS '작성일';

COMMENT ON COLUMN TB_NOTICE.MODIFY_DATE IS '수정날짜';

COMMENT ON COLUMN TB_NOTICE.READ_COUNT IS '조회수';

COMMENT ON COLUMN TB_NOTICE.IMPORTANCY IS '중요도';

CREATE UNIQUE INDEX PK_TB_NOTICE
	ON TB_NOTICE (
		NOTICE_NO ASC
	);

ALTER TABLE TB_NOTICE
	ADD
		CONSTRAINT PK_TB_NOTICE
		PRIMARY KEY (
			NOTICE_NO
		);

ALTER TABLE TB_NOTICE
	ADD CONSTRAINT FK_TB_USER_TO_TB_NOTICE
	FOREIGN KEY (WRITER)
	REFERENCES TB_USER (ID)
	ON DELETE SET NULL;


--DROP INDEX PK_TB_INCONVINIENCE;

DROP TABLE TB_INCONVINIENCE_BOARD CASCADE CONSTRAINTS;

CREATE TABLE TB_INCONVINIENCE_BOARD (
	BOARD_NO NUMBER NOT NULL,
	WRITER NUMBER NOT NULL,
	BOARD_TITLE VARCHAR2(300) NOT NULL,
	BOARD_CONTENT VARCHAR2(3000) NOT NULL,
	WRITE_DATE DATE DEFAULT SYSDATE NOT NULL,
	MODIFY_DATE DATE DEFAULT SYSDATE NOT NULL,
	STATUS VARCHAR2(1) NOT NULL
);

COMMENT ON TABLE TB_INCONVINIENCE_BOARD IS '불편사항게시판';

COMMENT ON COLUMN TB_INCONVINIENCE_BOARD.BOARD_NO IS '게시글번호';

COMMENT ON COLUMN TB_INCONVINIENCE_BOARD.WRITER IS '작성자';

COMMENT ON COLUMN TB_INCONVINIENCE_BOARD.BOARD_TITLE IS '제목';

COMMENT ON COLUMN TB_INCONVINIENCE_BOARD.BOARD_CONTENT IS '내용';

COMMENT ON COLUMN TB_INCONVINIENCE_BOARD.WRITE_DATE IS '작성일';

COMMENT ON COLUMN TB_INCONVINIENCE_BOARD.MODIFY_DATE IS '수정날짜';

COMMENT ON COLUMN TB_INCONVINIENCE_BOARD.STATUS IS '조치상태';

CREATE UNIQUE INDEX PK_TB_INCONVINIENCE
	ON TB_INCONVINIENCE_BOARD (
		BOARD_NO ASC
	);

ALTER TABLE TB_INCONVINIENCE_BOARD
	ADD
		CONSTRAINT PK_TB_INCONVINIENCE
		PRIMARY KEY (
			BOARD_NO
		);

ALTER TABLE TB_INCONVINIENCE_BOARD
	ADD CONSTRAINT FK_TB_USER_TO_TB_INCONVINIENCE_BOARD
	FOREIGN KEY (WRITER)
	REFERENCES TB_USER (ID)
	ON DELETE SET NULL;


ALTER TABLE TB_INCONVINIENCE_BOARD_REPLY DROP CONSTRAINT PK_TB_INCONVINIENCE_REPLY;

--DROP INDEX PK_TB_INCONVINIENCE_REPLY;

DROP TABLE TB_INCONVINIENCE_BOARD_REPLY 
	CASCADE CONSTRAINTS;

CREATE TABLE TB_INCONVINIENCE_BOARD_REPLY (
	BOARD_NO NUMBER NOT NULL,
	WRITER NUMBER,
	WRITE_DATE DATE DEFAULT SYSDATE NOT NULL,
	COMMENT_CONTENT VARCHAR2(500) NOT NULL
);

COMMENT ON TABLE TB_INCONVINIENCE_BOARD_REPLY IS '불편사항게시판댓글';

COMMENT ON COLUMN TB_INCONVINIENCE_BOARD_REPLY.BOARD_NO IS '원글번호';

COMMENT ON COLUMN TB_INCONVINIENCE_BOARD_REPLY.WRITER IS '작성자';

COMMENT ON COLUMN TB_INCONVINIENCE_BOARD_REPLY.WRITE_DATE IS '작성날짜';

COMMENT ON COLUMN TB_INCONVINIENCE_BOARD_REPLY.COMMENT_CONTENT IS '댓글내용';

CREATE UNIQUE INDEX PK_TB_INCONVINIENCE_REPLY
	ON TB_INCONVINIENCE_BOARD_REPLY (
		BOARD_NO ASC
	);

ALTER TABLE TB_INCONVINIENCE_BOARD_REPLY
	ADD
		CONSTRAINT PK_TB_INCONVINIENCE_REPLY
		PRIMARY KEY (
			BOARD_NO
		);

ALTER TABLE TB_INCONVINIENCE_BOARD_REPLY
	ADD CONSTRAINT FK_TB_INCONVINIENCE_BOARD_TO_TB_INCONVINIENCE_BOARD_REPLY
	FOREIGN KEY (BOARD_NO)
	REFERENCES TB_INCONVINIENCE_BOARD (BOARD_NO)
	ON DELETE SET NULL;

ALTER TABLE TB_INCONVINIENCE_BOARD_REPLY
	ADD CONSTRAINT FK_TB_USER_TO_TB_INCONVINIENCE_BOARD_REPLY
	FOREIGN KEY (WRITER)
	REFERENCES TB_USER (ID)
	ON DELETE SET NULL;



ALTER TABLE TB_USER_SUSPENSION DROP CONSTRAINT PK_TB_USER_SUSPENSION;

--DROP INDEX PK_TB_USER_SUSPENSION;

DROP TABLE TB_USER_SUSPENSION 
	CASCADE CONSTRAINTS;

CREATE TABLE TB_USER_SUSPENSION (
	SUSPENSION_NO NUMBER NOT NULL,
	TARGET_ACCOUNT NUMBER,
	SUSPENSION_START DATE DEFAULT SYSDATE NOT NULL,
	SUSPENSION_END DATE DEFAULT SYSDATE,
	SUSPENSION_TITLE VARCHAR2(100) NOT NULL,
	SUSPENSION_CONTENT VARCHAR2(600)
);

COMMENT ON TABLE TB_USER_SUSPENSION IS '정지내역';

COMMENT ON COLUMN TB_USER_SUSPENSION.SUSPENSION_NO IS '정지번호';

COMMENT ON COLUMN TB_USER_SUSPENSION.TARGET_ACCOUNT IS '정지 유저';

COMMENT ON COLUMN TB_USER_SUSPENSION.SUSPENSION_START IS '정지시작날짜';

COMMENT ON COLUMN TB_USER_SUSPENSION.SUSPENSION_END IS '정지해제날짜';

COMMENT ON COLUMN TB_USER_SUSPENSION.SUSPENSION_TITLE IS '정지사유';

COMMENT ON COLUMN TB_USER_SUSPENSION.SUSPENSION_CONTENT IS '정지상세';

CREATE UNIQUE INDEX PK_TB_USER_SUSPENSION
	ON TB_USER_SUSPENSION (
		SUSPENSION_NO ASC
	);

ALTER TABLE TB_USER_SUSPENSION
	ADD
		CONSTRAINT PK_TB_USER_SUSPENSION
		PRIMARY KEY (
			SUSPENSION_NO
		);

ALTER TABLE TB_USER_SUSPENSION
	ADD CONSTRAINT FK_TB_USER_TO_TB_USER_SUSPENSION
	FOREIGN KEY (TARGET_ACCOUNT)
	REFERENCES TB_USER (ID)
	ON DELETE SET NULL;

-----------------------------------------------
--- USER ID로 TABLE 생성
-----------------------------------------------
-- TB_EMPLOYEE 테이블 생성 프로시저
CREATE OR REPLACE PROCEDURE PR_CREATE_TB_EMPLOYEE
(p_user_id IN NUMBER) 
IS
   v_user_id    VARCHAR2(100);
   v_table_name VARCHAR2(200);
   v_seq_col    VARCHAR2(100);
   
   v_str        VARCHAR2(1000);
BEGIN
   ---------------------
   --- 변수 초기화
   ---------------------
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));
   
   v_table_name := 'TB_EMPLOYEE_' || v_user_id;

   BEGIN
      v_str := 'CREATE TABLE ' || v_table_name || ' ('
            || '   EMP_ID NUMBER CONSTRAINT PK_' || v_table_name || ' PRIMARY KEY, '
            || '   EMP_NAME VARCHAR2(30) NOT NULL, '
            || '   POSITION VARCHAR2(20) NOT NULL, '
            || '   EMP_HIREDATE DATE NOT NULL, '
            || '   EMP_PHONE VARCHAR2(15) NOT NULL, '
            || '   EMP_EMAIL VARCHAR2(30) NOT NULL, '
            || '   EMP_ADDRESS VARCHAR2(50) NOT NULL, '
            || '   EMP_BIRTHDATE DATE NOT NULL, '
            || '   EMP_GENDER VARCHAR2(1) CHECK (EMP_GENDER IN (''M'', ''F'')) NOT NULL '
            || ' )';
			
      EXECUTE IMMEDIATE v_str;

      -------------------------------	  
	  --- 컬럼 정보
      -------------------------------
      EXECUTE IMMEDIATE 'COMMENT ON TABLE ' || v_table_name || ' IS ''직원정보''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.EMP_ID IS ''직원번호''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.EMP_NAME IS ''직원이름''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.POSITION IS ''직급''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.EMP_HIREDATE IS ''입사날짜''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.EMP_PHONE IS ''전화번호''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.EMP_EMAIL IS ''이메일''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.EMP_ADDRESS IS ''주소''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.EMP_BIRTHDATE IS ''생년월일''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.EMP_GENDER IS ''성별''';
	  
	  
      --------------------------------------------
      --- SEQUENSE 추가(2024.04.09)
      --------------------------------------------
	  v_seq_col := 'EMP_ID';
	  v_str := '';
	  v_str := ' CREATE SEQUENCE ' || v_table_name
             || '_' || v_seq_col || '_SEQ '
             || ' INCREMENT BY 1 ' 
             || ' START WITH 1 ';

      EXECUTE IMMEDIATE v_str;

   END;  

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

-- TB_COMMUTE_INFO 테이블 생성 프로시저
CREATE OR REPLACE PROCEDURE PR_CREATE_TB_COMMUTE_INFO
(p_user_id IN NUMBER)
IS
   v_user_id    VARCHAR2(100);
   v_table_name VARCHAR2(200);
   v_str        VARCHAR2(1000);
BEGIN
   ---------------------
   --- 변수 초기화
   ---------------------
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));
   
   v_table_name := 'TB_COMMUTE_INFO_' || v_user_id;
   BEGIN
      v_str := 'CREATE TABLE ' || v_table_name || ' ('
            || '   EMP_ID NUMBER NOT NULL, '
            || '   START_TIME DATE, '
            || '   WORK_DAY DATE, '
            || '   END_TIME DATE, '
            || '   WORKING_HOURS VARCHAR2(30), '
            || '   LATE_FLAG VARCHAR2(1) CHECK (LATE_FLAG IN (''N'', ''Y'')), '
            || '   LEAVE_EARLY VARCHAR2(1) CHECK (LEAVE_EARLY IN (''N'', ''Y'')), '
            || '   ABSENTEEISM VARCHAR2(1) CHECK (ABSENTEEISM IN (''N'', ''Y'')), '
            || ' CONSTRAINT FK_' || v_table_name || '_EMP_ID FOREIGN KEY (EMP_ID) '
            || ' REFERENCES TB_EMPLOYEE_' || v_user_id || ' (EMP_ID) '
            || ' )';

      EXECUTE IMMEDIATE v_str;
	  
      -------------------------------	  
	  --- 컬럼 정보
      -------------------------------
      EXECUTE IMMEDIATE 'COMMENT ON TABLE ' || v_table_name || ' IS ''근태정보''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.EMP_ID IS ''직원번호''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.START_TIME IS ''출근시간''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.WORK_DAY IS ''근무일''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.END_TIME IS ''퇴근시간''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.WORKING_HOURS IS ''근무시간''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.LATE_FLAG IS ''지각여부''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.LEAVE_EARLY IS ''조퇴여부''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.ABSENTEEISM IS ''결근여부''';

   END;

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

-- TB_CALENDAR 테이블 생성 프로시저
CREATE OR REPLACE PROCEDURE PR_CREATE_TB_CALENDAR 
(p_user_id IN NUMBER)
IS
   v_user_id    VARCHAR2(100);
   v_table_name VARCHAR2(200);
   v_str        VARCHAR2(1000);
BEGIN
   ---------------------
   --- 변수 초기화
   ---------------------
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));
   
   v_table_name := 'TB_CALENDAR_' || v_user_id;
   
   BEGIN
      v_str := 'CREATE TABLE ' || v_table_name || '('
            || '   EMP_ID NUMBER NOT NULL, '
            || '   REMARKS VARCHAR2(3000), '
            || ' CONSTRAINT FK_' || v_table_name || '_EMP_ID FOREIGN KEY (EMP_ID) '
			|| ' REFERENCES TB_EMPLOYEE_' || v_user_id || ' (EMP_ID) '
            || '   )';
			
      EXECUTE IMMEDIATE v_str;
	  
      -------------------------------	  
	  --- 컬럼 정보
      -------------------------------
      EXECUTE IMMEDIATE 'COMMENT ON TABLE ' || v_table_name || ' IS ''직원 스케줄''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.EMP_ID IS ''직원번호''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.REMARKS IS ''특이사항''';

   END;

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

-- TB_SALARY_INFO 테이블 생성 프로시저
CREATE OR REPLACE PROCEDURE PR_CREATE_TB_SALARY_INFO 
(p_user_id IN NUMBER) 
IS
   v_user_id    VARCHAR2(100);
   v_table_name VARCHAR2(200);
   v_seq_col    VARCHAR2(100);
   
   v_str        VARCHAR2(1000);
BEGIN
   ---------------------
   --- 변수 초기화
   ---------------------
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));

   v_table_name := 'TB_SALARY_INFO_' || v_user_id;
   
   BEGIN
      v_str := 'CREATE TABLE ' || v_table_name || '('
            || '   EMP_ID NUMBER CONSTRAINT PK_' || v_table_name || ' PRIMARY KEY, '
            || '   BANK_NAME VARCHAR2(30) NOT NULL, '
            || '   BANK_ACCOUNT_NO VARCHAR2(20) NOT NULL, '
            || '   ACCOUNT_HOLDER VARCHAR2(30) NOT NULL, '
            || '   PREMIUM VARCHAR2(15), '
            || '   TAX VARCHAR2(15), '
            || ' CONSTRAINT FK_' || v_table_name || '_EMP_ID FOREIGN KEY (EMP_ID) '
			|| '    REFERENCES TB_EMPLOYEE_' || v_user_id || ' (EMP_ID) '
            || '   )';

      EXECUTE IMMEDIATE v_str;
	  
      -------------------------------	  
	  --- 컬럼 정보
      -------------------------------
      EXECUTE IMMEDIATE 'COMMENT ON TABLE ' || v_table_name || ' IS ''급여 정보''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.EMP_ID IS ''직원번호''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.BANK_NAME IS ''은행이름''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.BANK_ACCOUNT_NO IS ''계좌번호''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.ACCOUNT_HOLDER IS ''예금주''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.PREMIUM IS ''보험료''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.TAX IS ''세금''';

   END;
END;
/

CREATE OR REPLACE PROCEDURE PR_CREATE_TB_POS
(p_user_id IN NUMBER)
IS
   v_user_id    VARCHAR2(100);
   v_table_name VARCHAR2(200);
   v_seq_col    VARCHAR2(100);
   
   v_str        VARCHAR2(1000);
BEGIN
   ---------------------
   --- 변수 초기화
   ---------------------
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));

   v_table_name := 'TB_POS_' || v_user_id;
   
   BEGIN
   
      v_str := 'CREATE TABLE ' || v_table_name || '('
            || '  POS_NO NUMBER CONSTRAINT PK_' || v_table_name || ' PRIMARY KEY '
            || '  )';

      EXECUTE IMMEDIATE v_str;
	  
      --------------------------------------------
      --- SEQUENSE 추가(2024.04.09)
      --------------------------------------------
	  v_seq_col := 'POS_NO';
	  v_str := '';
	  v_str := ' CREATE SEQUENCE ' || v_table_name
             || '_' || v_seq_col || '_SEQ '
             || ' INCREMENT BY 1 ' 
             || ' START WITH 1 ';

      EXECUTE IMMEDIATE v_str;

   END;
	
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

CREATE OR REPLACE PROCEDURE PR_CREATE_TB_TABLE
(p_user_id IN NUMBER)
IS
   v_user_id    VARCHAR2(100);
   v_table_name VARCHAR2(200);
   v_seq_col    VARCHAR2(100);
   
   v_str        VARCHAR2(1000);
BEGIN
   ---------------------
   --- 변수 초기화
   ---------------------
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));

   v_table_name := 'TB_TABLE_' || v_user_id;
   BEGIN
      v_str := 'CREATE TABLE ' || v_table_name || '('
            || '  TABLE_NO NUMBER CONSTRAINT PK_' || v_table_name || ' PRIMARY KEY, '
            || '  TABLE_NAME VARCHAR2(60) NOT NULL, '
            || '  TABLE_X NUMBER NOT NULL, '
            || '  TABLE_Y NUMBER NOT NULL  '
            || '  )';

      EXECUTE IMMEDIATE v_str;
	  
      --------------------------------------------
      --- SEQUENSE 추가(2024.04.09)
      --------------------------------------------
	  v_seq_col := 'TABLE_NO';
	  v_str := '';
	  v_str := ' CREATE SEQUENCE ' || v_table_name
             || '_' || v_seq_col || '_SEQ '
             || ' INCREMENT BY 1 ' 
             || ' START WITH 1 ';

      EXECUTE IMMEDIATE v_str;

   END;

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

CREATE OR REPLACE PROCEDURE PR_CREATE_TB_MENU
(p_user_id IN NUMBER)
IS
   v_user_id    VARCHAR2(100);
   v_table_name VARCHAR2(200);
   v_seq_col    VARCHAR2(100);
   
   v_str        VARCHAR2(1000);
BEGIN
   ---------------------
   --- 변수 초기화
   ---------------------
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));

   v_table_name := 'TB_MENU_' || v_user_id;
   BEGIN
      v_str := ' CREATE TABLE ' || v_table_name || '('
              || '   MENU_NO NUMBER CONSTRAINT PK_' || v_table_name || ' PRIMARY KEY, '
              || '   MENU_NAME VARCHAR2(60) NOT NULL, '
              || '   PRICE NUMBER NOT NULL '
              || '   )';
			  
      EXECUTE IMMEDIATE v_str;
	  
      --------------------------------------------
      --- SEQUENSE 추가(2024.04.09)
      --------------------------------------------
	  v_seq_col := 'MENU_NO';
	  v_str := '';
	  v_str := ' CREATE SEQUENCE ' || v_table_name
             || '_' || v_seq_col || '_SEQ '
             || ' INCREMENT BY 1 ' 
             || ' START WITH 1 ';

      EXECUTE IMMEDIATE v_str;
	  
   END;
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

-------------------------------------
-- 예약관리 TABLE 생성
-------------------------------------
CREATE OR REPLACE PROCEDURE PR_CREATE_TB_RESERVATION
(p_user_id IN NUMBER)
IS
   v_user_id    VARCHAR2(100);
   v_table_name VARCHAR2(200);
   v_str        VARCHAR2(1000);
   v_seq_col    VARCHAR2(100);
BEGIN
   ---------------------
   --- 변수 초기화
   ---------------------
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));

   -- 유저 아이디를 이용하여 테이블 이름 생성
   v_table_name := 'TB_RESERVATION_' || v_user_id;
   
   --dbms_output.put_line(v_table_name);
   
   BEGIN
      v_str := '';
      v_str := 'CREATE TABLE ' || v_table_name || '(' ||
               '   RSRV_NUM NUMBER NOT NULL ' ||
               ' ,RSRV_DATE VARCHAR2(8) ' ||
               ' ,RSRV_TIME VARCHAR2(6) ' ||
               ' ,RSRV_NAME VARCHAR2(50) ' ||
               ' ,RSRV_TELNO VARCHAR2(20) ' ||
               ' ,RSRV_INWON NUMBER DEFAULT 1 ' ||
               ' ,RSRV_SUBJECT VARCHAR2(50) ' ||
               ' ,RSRV_MEMO VARCHAR2(200) ' ||
               ' ,WRITER NUMBER ' ||
               ' ,WRITE_DATE DATE DEFAULT SYSDATE ' ||
               ' )';

      --dbms_output.put_line(v_str);
	  
      EXECUTE IMMEDIATE v_str;

      v_str := '';
	  v_str := ' ALTER TABLE ' || v_table_name || 
               ' ADD CONSTRAINT PK_' || v_table_name ||
               '   PRIMARY KEY (RSRV_NUM)';
			   
      EXECUTE IMMEDIATE v_str;

      EXECUTE IMMEDIATE 'COMMENT ON TABLE ' || v_table_name || ' IS ''예약관리''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.RSRV_NUM IS ''예약번호''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.RSRV_DATE IS ''예약일자''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.RSRV_TIME IS ''예약시간''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.RSRV_NAME IS ''예약자명''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.RSRV_TELNO IS ''예약전화번호''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.RSRV_INWON IS ''인원''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.RSRV_SUBJECT IS ''제목''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.RSRV_MEMO IS ''메모''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.WRITER IS ''작성일자''';
      EXECUTE IMMEDIATE 'COMMENT ON COLUMN ' || v_table_name || '.WRITE_DATE IS ''작성일자''';
	  
      --------------------------------------------
      --- SEQUENSE 추가(2024.04.07)
      --------------------------------------------
	  v_seq_col := 'RSRV_NUM';
	  v_str := '';
	  v_str := ' CREATE SEQUENCE ' || v_table_name
             || '_' || v_seq_col || '_SEQ '
             || ' INCREMENT BY 1 ' 
             || ' START WITH 1 ';

      EXECUTE IMMEDIATE v_str;

   END;
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm);
END;
/

-------------- 상품 테이블 --------------- 
CREATE OR REPLACE PROCEDURE PR_CREATE_TB_GOODS
(p_user_id IN NUMBER)
IS
   v_user_id    VARCHAR2(100);
   v_table_name VARCHAR2(200);
   v_seq_col    VARCHAR2(100);
   
   v_str        VARCHAR2(1000);
BEGIN
   ---------------------
   --- 변수 초기화
   ---------------------
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));

   -- 유저 아이디를 이용하여 테이블 이름 생성
   v_table_name := 'TB_GOODS_' || v_user_id;

   BEGIN
      v_str := ' CREATE TABLE ' || v_table_name || '('
             || '  ID NUMBER, '
             || '  GOODS_NO NUMBER CONSTRAINT PK_' || v_table_name || ' PRIMARY KEY, '
             || '  GOODS_NAME VARCHAR2(300) NOT NULL, '
             || '  GOODS_UNIT VARCHAR2(30), '
             || '  GOODS_PRICE NUMBER,      '
             || '  SALE_PRICE NUMBER,       '
             || '  NATION VARCHAR2(30) DEFAULT NULL '
             || '  ) ';
			 
      -- 테이블 생성
      EXECUTE IMMEDIATE v_str;
	  
      --------------------------------------------
      --- SEQUENSE 추가(2024.04.09)
      --------------------------------------------
	  v_seq_col := 'GOODS_NO';
	  v_str := '';
	  v_str := ' CREATE SEQUENCE ' || v_table_name
             || '_' || v_seq_col || '_SEQ '
             || ' INCREMENT BY 1 ' 
             || ' START WITH 1 ';

      EXECUTE IMMEDIATE v_str;

   END;

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

-- 재고 테이블
CREATE OR REPLACE PROCEDURE PR_CREATE_TB_INVENTORY
(p_user_id IN NUMBER)
IS
   v_user_id    VARCHAR2(100);
   v_table_name VARCHAR2(200);
   v_str        VARCHAR2(1000);
BEGIN
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));

    -- 유저 아이디를 이용하여 테이블 이름 생성
    v_table_name := 'TB_INVENTORY_' || v_user_id;

    v_str := 'CREATE TABLE ' || v_table_name || '('
             || '   GOODS_NO NUMBER PRIMARY KEY, '
             || '   PD_QUANTITY NUMBER NOT NULL, '
             || '   MIN_ALARM_QUANTITY NUMBER,   '
             || '   MIN_ORDER_QUANTITY NUMBER,   '
             || ' CONSTRAINT FK_' || v_table_name || '_GOODS_NO '
			 || '    FOREIGN KEY (GOODS_NO) '
             || '       REFERENCES TB_GOODS_' || v_user_id || ' (GOODS_NO) '
			 || '          ON DELETE CASCADE '
             || ' )';
			 
    -- 동적 SQL 실행
    EXECUTE IMMEDIATE v_str;

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

--- 발주처 테이블
CREATE OR REPLACE PROCEDURE PR_CREATE_TB_PRODUCE
(p_user_id IN NUMBER)
IS
   v_user_id    VARCHAR2(100);
   v_table_name VARCHAR2(200);
   v_seq_col    VARCHAR2(100);
   
   v_str        VARCHAR2(1000);
BEGIN

   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));

   --- 유저 아이디를 이용하여 테이블 이름 생성
   v_table_name := 'TB_PRODUCE_' || v_user_id;

   BEGIN
      v_str := 'CREATE TABLE ' || v_table_name || '('
              || '   GOODS_NO NUMBER CONSTRAINT PK_' || v_table_name || ' PRIMARY KEY, '
              || '   PD_NO NUMBER,                   '
              || '   PD_NAME VARCHAR2(300) NOT NULL, '
              || '   PRODUCER VARCHAR2(20),    '
              || '   PD_PHONE VARCHAR2(30),    '
              || '   PD_ADDRESS VARCHAR2(255), '
              || ' CONSTRAINT FK_' || v_table_name || '_GOODS_NO FOREIGN KEY (GOODS_NO) '
              || '       REFERENCES TB_GOODS_' || v_user_id
              || '                   (GOODS_NO) ON DELETE CASCADE '
              || ')';

      --dbms_output.put_line(v_str); 
      -- 동적 SQL 실행
      EXECUTE IMMEDIATE v_str;
	  
      --------------------------------------------
      --- SEQUENSE 추가(2024.04.09)
      --------------------------------------------
	  v_seq_col := 'PD_NO';
	  v_str := '';
	  v_str := ' CREATE SEQUENCE ' || v_table_name
             || '_' || v_seq_col || '_SEQ '
             || ' INCREMENT BY 1 ' 
             || ' START WITH 1 ';
	  
      EXECUTE IMMEDIATE v_str;
	  
   END;
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

---------------------------------------
-- 명세서 테이블
---------------------------------------
CREATE OR REPLACE PROCEDURE PR_CREATE_TB_SPECIFY
(p_user_id IN NUMBER)
IS
   v_user_id    VARCHAR2(200);
   v_table_name VARCHAR2(100);
BEGIN
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));

    -- 유저 아이디를 이용하여 테이블 이름 생성
    v_table_name := 'TB_SPECIFY_' || v_user_id;

    -- 동적 SQL 실행하여 테이블 생성
    EXECUTE IMMEDIATE '
        CREATE TABLE ' || v_table_name || '(
            ID NUMBER,
            PD_DATE VARCHAR2(10),
            PD_PRICE NUMBER,
            PD_MONTH VARCHAR2(10)
        )';

    -- 트리거 생성을 위한 동적 SQL 실행
    EXECUTE IMMEDIATE '
        CREATE OR REPLACE TRIGGER TR_' || v_table_name || '_BF_UPDATE_PD_MONTH
        BEFORE INSERT OR UPDATE ON ' || v_table_name || '
        FOR EACH ROW
        BEGIN
            IF :NEW.PD_DATE IS NOT NULL THEN
                :NEW.PD_MONTH := SUBSTR(:NEW.PD_DATE, 1, LENGTH(:NEW.PD_DATE) - 3);
            END IF;
        END;';
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

CREATE OR REPLACE PROCEDURE PR_CREATE_TB_SALES
(p_user_id IN NUMBER)
IS
   v_user_id    VARCHAR2(200);
   v_table_name VARCHAR2(100);
   v_str        VARCHAR2(1000);
BEGIN
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));

   v_table_name := 'TB_SALES_' || v_user_id;

   v_str := 'CREATE TABLE ' || v_table_name || '('
            || ' SALE_ID NUMBER CONSTRAINT PK_' || v_table_name || ' PRIMARY KEY, '
            || ' EMP_ID NUMBER NOT NULL, '
            || ' SALE_DATE DATE DEFAULT SYSDATE, '
            || ' AMOUNT NUMBER, '
            || ' CONSTRAINT FK_' || v_table_name || '_EMP_ID FOREIGN KEY (EMP_ID) '
			|| ' REFERENCES TB_EMPLOYEE_' || v_user_id || ' (EMP_ID) '
            || ' )';
		
   EXECUTE IMMEDIATE v_str;
   
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/


CREATE OR REPLACE PROCEDURE PR_CREATE_TB_ADDITIONALWAGES
(p_user_id IN NUMBER)
IS
   v_user_id    VARCHAR2(200);
   v_table_name VARCHAR2(100);
   v_str        VARCHAR2(1000);
BEGIN
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));

   v_table_name := 'TB_ADDITIONALWAGES_' || v_user_id;

   v_str := ' CREATE TABLE ' || v_table_name || '('
            || '     WAGE_ID NUMBER CONSTRAINT PK_' || v_table_name || ' PRIMARY KEY, '
            || '     EMP_ID NUMBER NOT NULL,         '
            || '     WAGE_DATE DATE DEFAULT SYSDATE, '
            || '     WAGE_AMOUNT NUMBER,             '
            || ' CONSTRAINT FK_' || v_table_name || '_EMP_ID FOREIGN KEY (EMP_ID) '
			|| ' REFERENCES TB_EMPLOYEE_' || v_user_id || ' (EMP_ID) )';
		
   EXECUTE IMMEDIATE v_str;
   
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

--- 2024.04.09 add
CREATE OR REPLACE PROCEDURE PR_CREATE_TB_PAYSTUB
(p_user_id IN NUMBER)
IS
   ---------------------
   --- 변수 선언
   ---------------------
   v_user_id    VARCHAR2(200);
   v_table_name VARCHAR2(200);
   v_str        VARCHAR2(1000);
BEGIN
   ---------------------
   --- 변수 초기화
   ---------------------
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));
   v_table_name := 'TB_PAYSTUB_' || v_user_id;
   
   BEGIN
      v_str := ' CREATE TABLE ' || v_table_name || '(' 
             || ' PAYSTUB_ID NUMBER CONSTRAINT PK_' || v_table_name || ' PRIMARY KEY, '
             || ' EMP_ID NUMBER NOT NULL, '
             || ' PAY_DATE DATE DEFAULT SYSDATE, '
             || ' SALARY_AMOUNT NUMBER, '
             || ' CONSTRAINT FK_' || v_table_name || '_EMP_ID FOREIGN KEY (EMP_ID) '
             || ' REFERENCES TB_EMPLOYEE_' || v_user_id || ' (EMP_ID) ON DELETE CASCADE) ';

      EXECUTE IMMEDIATE v_str;
   END;
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

-- 2024.04.09 add
CREATE OR REPLACE PROCEDURE PR_CREATE_TB_ACCOUNT
(p_user_id IN NUMBER)
IS
   v_user_id    VARCHAR2(100);
   v_table_name VARCHAR2(200);
   v_str        VARCHAR2(1000);
   v_seq_col    VARCHAR2(100);
BEGIN
   ---------------------
   --- 변수 초기화
   ---------------------
   v_user_id := '';
   v_table_name := '';
   
   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));

   -- 유저 아이디를 이용하여 테이블 이름 생성
   v_table_name := 'TB_ACCOUNT_' || v_user_id;

   BEGIN
      -- 테이블 생성
	  v_str := ' CREATE TABLE ' || v_table_name || '('
            || '   ID NUMBER, '
            || '   YEARMONTH VARCHAR2(20), '
            || '   TITLE VARCHAR2(30), '
            || '   PRICE NUMBER '
            || ' )';
			
      EXECUTE IMMEDIATE v_str;
   END;
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm);
END;
/

---------------------------------------------------------------------
--- TABLE CREATE ALL
---------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE PR_SSMS_TABLE_ALL_CREATE
(p_user_id IN NUMBER)
IS
---------------------------------------------------------------------
--- TABLE CRETE
---------------------------------------------------------------------
BEGIN
   -- SET SERVEROUTPUT ON;
   ---------------------------
   --- 01. TB_EMPLOYEE
   ---------------------------
   PR_CREATE_TB_EMPLOYEE(p_user_id);

   ---------------------------
   --- 02. TB_ADDITIONALWAGES
   ---------------------------
   PR_CREATE_TB_ADDITIONALWAGES(p_user_id);
   
   ---------------------------
   --- 03. TB_COMMUTE_INFO
   ---------------------------
   PR_CREATE_TB_COMMUTE_INFO(p_user_id);

   ---------------------------
   --- 04. TB_CALENDAR
   ---------------------------
   PR_CREATE_TB_CALENDAR(p_user_id);

   ---------------------------
   --- 05. TB_GOODS
   ---------------------------
   PR_CREATE_TB_GOODS(p_user_id);

   ---------------------------
   --- 06. TB_INVENTORY
   ---------------------------
   PR_CREATE_TB_INVENTORY(p_user_id);

   ---------------------------
   --- 07. TB_MENU
   ---------------------------
   PR_CREATE_TB_MENU(p_user_id);

   ---------------------------
   --- 08. TB_POS
   ---------------------------
   PR_CREATE_TB_POS(p_user_id);

   ---------------------------
   --- 09. TB_PRODUCE
   ---------------------------
   PR_CREATE_TB_PRODUCE(p_user_id);

   ---------------------------
   --- 10.1. TB_SALARY_INFO(직원급여)
   ---------------------------
   PR_CREATE_TB_SALARY_INFO(p_user_id);

   ---------------------------
   --- 10.2. TB_SALARYINFO -- 사용안함
   ---------------------------
   --PR_CREATE_TB_SALARYINFO(p_user_id);
   
   ---------------------------
   --- 11. TB_SALES
   ---------------------------
   PR_CREATE_TB_SALES(p_user_id);
   
   ---------------------------
   --- 12. TB_SPECIFY
   ---------------------------
   PR_CREATE_TB_SPECIFY(p_user_id);
   
   ---------------------------
   --- 14. TB_TABLE
   ---------------------------
   PR_CREATE_TB_TABLE(p_user_id);

   ---------------------------
   --- 15. TB_RESERVATION
   ---------------------------
   PR_CREATE_TB_RESERVATION(p_user_id);

   ---------------------------
   --- 16. TB_PAYSTUB
   ---------------------------
   PR_CREATE_TB_PAYSTUB(p_user_id);

   ---------------------------
   --- 17. TB_ACCOUNT
   ---------------------------
   PR_CREATE_TB_ACCOUNT(p_user_id);

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

-------------------------------------------
--- PROCEDURE DROP TABLE
-------------------------------------------
CREATE OR REPLACE PROCEDURE PR_SSMS_DROP_TABLE
(p_table_name IN VARCHAR2
,p_user_id    IN NUMBER)
IS
   ----------------------------
   --- 변수 선언
   ----------------------------
   v_user_id    VARCHAR2(100);
   v_table_name VARCHAR2(200);

   v_col_seq    VARCHAR2(100);
   v_seq_object VARCHAR2(200);
   
   v_str1 VARCHAR2(1000);
   v_str2 VARCHAR2(1000);

   v_cnt_1 NUMBER(5, 0);
   v_cnt_2 NUMBER(5, 0);
BEGIN
   ---------------------------
   --- 변수 초기화
   ---------------------------
   v_cnt_1 := 0;
   v_cnt_2 := 0;

   v_user_id := RTRIM(LTRIM(TO_CHAR(p_user_id)));

   -- 유저 아이디를 이용하여 테이블 이름 작성
   v_table_name := p_table_name || '_' || v_user_id;
   --dbms_output.put_line(v_table_name);
   
   BEGIN
	  -----------------------------------
      --- TABLE
	  -----------------------------------
	  SELECT nvl(count(*), 0) as cnt
        INTO v_cnt_1
	  FROM USER_TABLES
	  WHERE TABLE_NAME = v_table_name;

      IF v_cnt_1 > 0 THEN
         v_str1 := 'DROP TABLE ' || v_table_name || ' CASCADE CONSTRAINTS';
         --dbms_output.put_line(v_str1);
         EXECUTE IMMEDIATE v_str1;
      END IF;
	  
	  ------------------------------
	  -- SEQUENCE 컬럼
	  ------------------------------
	  v_col_seq := '';
      IF (v_table_name = ('TB_EMPLOYEE_' || v_user_id)) THEN
         v_col_seq := 'EMP_ID';
      ELSIF (v_table_name = ('TB_GOODS_' || v_user_id)) THEN
         v_col_seq := 'GOODS_NO';
      ELSIF (v_table_name = ('TB_PRODUCE_' || v_user_id)) THEN
         v_col_seq := 'PD_NO';
      ELSIF (v_table_name = ('TB_MENU_' || v_user_id)) THEN
         v_col_seq := 'MENU_NO';
      ELSIF (v_table_name = ('TB_TABLE_' || v_user_id)) THEN
         v_col_seq := 'TABLE_NO';
      ELSIF (v_table_name = ('TB_POS_' || v_user_id)) THEN
         v_col_seq := 'POS_NO';
	  ELSIF (v_table_name = ('TB_RESERVATION_' || v_user_id)) THEN
         v_col_seq := 'RSRV_NUM';
      ELSE
	     v_col_seq := '';
	  END IF;

	  v_seq_object := v_table_name || '_' || v_col_seq || '_SEQ';
	  dbms_output.put_line(v_seq_object);
	  
	  -----------------------------------
      --- SEQUENCE
	  -----------------------------------
      SELECT nvl(count(*), 0) as cnt
        INTO v_cnt_2
      FROM USER_OBJECTS
      WHERE OBJECT_TYPE = 'SEQUENCE'
        AND OBJECT_NAME = v_seq_object;

      IF v_cnt_2 > 0 THEN
         v_str2 := 'DROP SEQUENCE ' || v_seq_object;
         --dbms_output.put_line(v_str2);
         EXECUTE IMMEDIATE v_str2;
      END IF;
   END;
  
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

CREATE OR REPLACE PROCEDURE PR_SSMS_TABLE_ALL_DROP
(arg_user_id IN NUMBER)
IS
---------------------------------------------------------------------
--- TABLE DROP
---------------------------------------------------------------------
BEGIN
   ---------------------------
   --- 01. TB_ADDITIONALWAGES
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_ADDITIONALWAGES', arg_user_id);
   dbms_output.put_line('01');
   
   ---------------------------
   --- 02. TB_CALENDAR
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_CALENDAR', arg_user_id);
   dbms_output.put_line('02');
   
   ---------------------------
   --- 03. TB_COMMUTE_INFO
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_COMMUTE_INFO', arg_user_id);
   dbms_output.put_line('03');
   
   ---------------------------
   --- 04. TB_INVENTORY
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_INVENTORY', arg_user_id);
   dbms_output.put_line('04');
   
   ---------------------------
   --- 05. TB_MENU
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_MENU', arg_user_id);
   dbms_output.put_line('05');

   ---------------------------
   --- 06. TB_POS
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_POS', arg_user_id);
   dbms_output.put_line('06');

   ---------------------------
   --- 07. TB_PRODUCE
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_PRODUCE', arg_user_id);
   dbms_output.put_line('07');

   ---------------------------
   --- 08.1. TB_SALARY_INFO
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_SALARY_INFO', arg_user_id);
   dbms_output.put_line('08');

   ---------------------------
   --- 08.2. TB_SALARYINFO
   ---------------------------
   -- PR_SSMS_DROP_TABLE('TB_SALARYINFO', arg_user_id);
   
   ---------------------------
   --- 09. TB_SALES
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_SALES', arg_user_id);
   dbms_output.put_line('09');

   ---------------------------
   --- 10. TB_SPECIFY
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_SPECIFY', arg_user_id);
   dbms_output.put_line('10');
   ---------------------------
   --- 11. TB_TABLE
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_TABLE', arg_user_id);
   dbms_output.put_line('11');

   ---------------------------
   --- 12. TB_RESERVATION
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_RESERVATION', arg_user_id);
   dbms_output.put_line('12');
   
   ---------------------------
   --- 13. TB_GOODS
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_GOODS', arg_user_id);
   dbms_output.put_line('13');

   ---------------------------
   --- 14. TB_PAYSTUB
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_PAYSTUB', arg_user_id);
   dbms_output.put_line('14');

   ---------------------------
   --- 15. TB_EMPLOYEE
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_EMPLOYEE', arg_user_id);
   dbms_output.put_line('15');
   
   ---------------------------
   --- 16. TB_ACCOUNT
   ---------------------------
   PR_SSMS_DROP_TABLE('TB_ACCOUNT', arg_user_id);
   dbms_output.put_line('16');

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm);
END;
/

-------------------------------------------------
--- TABLE을 자동으로 생성하기 위한 TRIIGER
-------------------------------------------------
CREATE OR REPLACE TRIGGER TR_TB_USER_BF_01
BEFORE INSERT ON TB_USER
FOR EACH ROW
DECLARE
   --- TRIGGER는 기본 AUTO COMMIT임
   --- COMMIT과 쌍으로 거리해야 함
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
   -----------------------
   -- TABLE 생성하기
   -----------------------
   IF INSERTING THEN
      --- 1000 ~ 2000까지는 관리자 ID 이므로 TABLE을 생성하지 않는다.(2024.04.10)
      IF NOT (:NEW.ID >= 1000 AND :NEW.ID <= 2000)  THEN
         PR_SSMS_TABLE_ALL_CREATE(:NEW.ID);
         COMMIT;
	  END IF;
   END IF;
   
EXCEPTION
   WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, SQLERRM);
END;
/

-------------------------------------------------
--- 지웅 시퀀스
-------------------------------------------------
-- SEQUENCE 삭제 처리
DECLARE
  v_str VARCHAR(500);
  v_cnt NUMBER(5, 0) := 0;
BEGIN

   ----------------------------------
   -- USER_SEQ
   ----------------------------------
   v_cnt := 0;
   SELECT nvl(count(*), 0) as cnt
     INTO v_cnt
   FROM USER_OBJECTS
   WHERE OBJECT_TYPE = 'SEQUENCE'
     AND OBJECT_NAME = 'USER_SEQ';
	 
   IF v_cnt > 0 THEN
      EXECUTE IMMEDIATE 'DROP SEQUENCE USER_SEQ';
   END IF;

   ----------------------------------
   -- EMP_ID_SEQ
   ----------------------------------
   v_cnt := 0;
   SELECT nvl(count(*), 0) as cnt
     INTO v_cnt
   FROM USER_OBJECTS
   WHERE OBJECT_TYPE = 'SEQUENCE'
     AND OBJECT_NAME = 'EMP_ID_SEQ';
	 
   IF v_cnt > 0 THEN
      EXECUTE IMMEDIATE 'DROP SEQUENCE EMP_ID_SEQ';
   END IF;

   ----------------------------------
   --- NOTICE_SEQ
   ----------------------------------
   v_cnt := 0;
   SELECT nvl(count(*), 0) as cnt
     INTO v_cnt
   FROM USER_OBJECTS
   WHERE OBJECT_TYPE = 'SEQUENCE'
     AND OBJECT_NAME = 'NOTICE_SEQ';
	 
   IF v_cnt > 0 THEN
      EXECUTE IMMEDIATE 'DROP SEQUENCE NOTICE_SEQ';
   END IF;
   
   ----------------------------------
   --- INCONVINIENCE_SEQ
   ----------------------------------
   v_cnt := 0;
   SELECT nvl(count(*), 0) as cnt
     INTO v_cnt
   FROM USER_OBJECTS
   WHERE OBJECT_TYPE = 'SEQUENCE'
     AND OBJECT_NAME = 'INCONVINIENCE_SEQ';
	 
   IF v_cnt > 0 THEN
      EXECUTE IMMEDIATE 'DROP SEQUENCE INCONVINIENCE_SEQ';
   END IF;

   ----------------------------------
   --- SUBSCRIBE_SEQ
   ----------------------------------
   v_cnt := 0;
   SELECT nvl(count(*), 0) as cnt
     INTO v_cnt
   FROM USER_OBJECTS
   WHERE OBJECT_TYPE = 'SEQUENCE'
     AND OBJECT_NAME = 'SUBSCRIBE_SEQ';
	 
   IF v_cnt > 0 THEN
      EXECUTE IMMEDIATE 'DROP SEQUENCE SUBSCRIBE_SEQ';
   END IF;

   ----------------------------------
   --- SUBSCRIBE_PAYMENT_SEQ
   ----------------------------------
   v_cnt := 0;
   SELECT nvl(count(*), 0) as cnt
     INTO v_cnt
   FROM USER_OBJECTS
   WHERE OBJECT_TYPE = 'SEQUENCE'
     AND OBJECT_NAME = 'SUBSCRIBE_PAYMENT_SEQ';
	 
   IF v_cnt > 0 THEN
      EXECUTE IMMEDIATE 'DROP SEQUENCE SUBSCRIBE_PAYMENT_SEQ';
   END IF;

   ----------------------------------
   --- SUSPENSION_SEQ
   ----------------------------------
   v_cnt := 0;
   SELECT nvl(count(*), 0) as cnt
     INTO v_cnt
   FROM USER_OBJECTS
   WHERE OBJECT_TYPE = 'SEQUENCE'
     AND OBJECT_NAME = 'SUSPENSION_SEQ';
	 
   IF v_cnt > 0 THEN
      EXECUTE IMMEDIATE 'DROP SEQUENCE SUSPENSION_SEQ';
   END IF;
   
EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line(sqlerrm); 
END;
/

--------------------------------------------
-- SEQUENCE 생성
-- 관리자 1000 ~ 1999까지 사용
-- 일반 가입 사용자는 2001부터 시작
--------------------------------------------
CREATE SEQUENCE USER_SEQ
        INCREMENT BY 1
        START WITH 2001
        NOCACHE
        NOCYCLE;

-- 일반 사용자 TABLE로 통합(2024.04.10)
--CREATE SEQUENCE EMP_ID_SEQ
--       START WITH 1
--       INCREMENT BY 1
--       NOCACHE
--       NOCYCLE;

CREATE SEQUENCE NOTICE_SEQ
        INCREMENT BY 1
        START WITH 1
        MINVALUE 1
        NOCYCLE
        NOCACHE;

CREATE SEQUENCE INCONVINIENCE_SEQ
        INCREMENT BY 1
        START WITH 1
        MINVALUE 1
        NOCYCLE
        NOCACHE;
		
CREATE SEQUENCE SUBSCRIBE_SEQ
        INCREMENT BY 1
        START WITH 1
        MINVALUE 1
        NOCYCLE
        NOCACHE;
		
CREATE SEQUENCE SUBSCRIBE_PAYMENT_SEQ
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       NOCYCLE
       NOCACHE;
		
CREATE SEQUENCE SUSPENSION_SEQ
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       NOCYCLE
       NOCACHE;

