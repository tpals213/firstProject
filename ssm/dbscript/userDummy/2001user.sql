--- 일반 사용자 정보 생성
---------------------------------------------------------------------

-- 사용자 : user1
-- 암호 : Tmdwhd0711!

INSERT INTO TB_USER
            (ID
            ,USER_ID, PASSWD
            ,EMAIL, USER_NO, PHONE
            ,ACCOUNT_NUMBER, BANK_NAME
            ,PROFILE_URL, IS_QUIT
            ,ADMIN_OK, LOGIN_OK
            ,LAST_MODIFIED
            ,SERVICE_DATE
            ,BUSINESS_NO, BUSINESS_STORE_NAME) 
    VALUES (USER_SEQ.NEXTVAL
            ,'user1', '$2a$10$Blh.zf653CzbR0Sr7jx8Dux5H52SuojDUsrznLMUFjTSgaYoZJXX.',
            'msj10252125@naver.com', '19980711', '010-1234-5366', 
            '1111', null
            ,null, 'N'
            ,'N', 'Y'
            ,default
            ,SYSDATE + 30
            ,'123456', 'ssm12');

COMMIT;

--------------------------------------------
-- 메뉴관리 메뉴 클릭시 문제시 사용
--------------------------------------------
-- INSERT INTO TB_ACCOUNT_2001
-- (ID, YEARMONTH, TITLE, PRICE)
-- VALUES(2001, '2024-04', '월세', 100);


--------------------------------------
--- 매장 메뉴 관리 사용시
--- 구독정보 UPDATE(2024.04.10)
--------------------------------------
UPDATE TB_USER
SET SERVICE_DATE=TIMESTAMP '2024-05-10 18:39:56.000000'
WHERE ID = 2001;
---------------------------------------------------------------------
--- 주석 처리(필요시 사용)
---------------------------------------------------------------------
-- 데이터 삭제
--DELETE FROM TB_NOTICE;
--DELETE FROM TB_USER;
--- -- 관리자
--- Insert into C##SSMS.TB_USER
--- (ID,USER_ID,PASSWD,EMAIL,USER_NO,PHONE,
--- ACCOUNT_NUMBER,BANK_NAME,PROFILE_URL,IS_QUIT,
--- ADMIN_OK,LOGIN_OK,LAST_MODIFIED,
--- SERVICE_DATE,BUSINESS_NO,BUSINESS_STORE_NAME) 
--- values (1001,'doorwinbell','$2a$10$Blh.zf653CzbR0Sr7jx8Dux5H52SuojDUsrznLMUFjTSgaYoZJXX.','msj102521235@admin.com','19980711','010-1234-5366','1111',null,null,'N','Y','Y',default,default,'123456','ssm13');
--- 
--- 
--- Insert into C##SSMS.TB_USER
--- (ID,USER_ID,PASSWD,EMAIL,USER_NO,PHONE,
--- ACCOUNT_NUMBER,BANK_NAME,PROFILE_URL,IS_QUIT,
--- ADMIN_OK,LOGIN_OK,LAST_MODIFIED,
--- SERVICE_DATE,BUSINESS_NO,BUSINESS_STORE_NAME) 
--- values (1002,'kyl1563','$2a$10$Blh.zf653CzbR0Sr7jx8Dux5H52SuojDUsrznLMUFjTSgaYoZJXX.','kyl156333@admin.com','19980711','010-1234-5366','1111',null,null,'N','Y','Y',default,default,'123456','ssm1');
--- 
--- Insert into C##SSMS.TB_USER
--- (ID,USER_ID,PASSWD,EMAIL,USER_NO,PHONE,
--- ACCOUNT_NUMBER,BANK_NAME,PROFILE_URL,IS_QUIT,
--- ADMIN_OK,LOGIN_OK,LAST_MODIFIED,
--- SERVICE_DATE,BUSINESS_NO,BUSINESS_STORE_NAME) 
--- values (1003,'tpals213','$2a$10$Blh.zf653CzbR0Sr7jx8Dux5H52SuojDUsrznLMUFjTSgaYoZJXX.','tpals21333@admin.com','19980711','010-1234-5366','2222',null,null,'N','Y','Y',default,default,'123457','ssm2');
--- 
--- Insert into C##SSMS.TB_USER
--- (ID,USER_ID,PASSWD,EMAIL,USER_NO,PHONE,
--- ACCOUNT_NUMBER,BANK_NAME,PROFILE_URL,IS_QUIT,
--- ADMIN_OK,LOGIN_OK,LAST_MODIFIED,
--- SERVICE_DATE,BUSINESS_NO,BUSINESS_STORE_NAME) 
--- values (1004,'tldhs7870','$2a$10$Blh.zf653CzbR0Sr7jx8Dux5H52SuojDUsrznLMUFjTSgaYoZJXX.','tldhs787033@admin.com','19980711','010-1234-5366','1002158415759',null,null,'N','Y','Y',default,default,'123458','ssm3');
--- 
--- Insert into C##SSMS.TB_USER
--- (ID,USER_ID,PASSWD,EMAIL,USER_NO,PHONE,
--- ACCOUNT_NUMBER,BANK_NAME,PROFILE_URL,IS_QUIT,
--- ADMIN_OK,LOGIN_OK,LAST_MODIFIED,
--- SERVICE_DATE,BUSINESS_NO,BUSINESS_STORE_NAME) 
--- values (1005,'smkr96','$2a$10$Blh.zf653CzbR0Sr7jx8Dux5H52SuojDUsrznLMUFjTSgaYoZJXX.','smkr9633@admin.com','19980711','010-1234-5366','4444',null,null,'N','Y','Y',default,default,'123456','ssm5');
--- 
--- Insert into C##SSMS.TB_USER
--- (ID,USER_ID,PASSWD,EMAIL,USER_NO,PHONE,
--- ACCOUNT_NUMBER,BANK_NAME,PROFILE_URL,IS_QUIT,
--- ADMIN_OK,LOGIN_OK,LAST_MODIFIED,
--- SERVICE_DATE,BUSINESS_NO,BUSINESS_STORE_NAME) 
--- values (1000,'tactius90','$2a$10$Blh.zf653CzbR0Sr7jx8Dux5H52SuojDUsrznLMUFjTSgaYoZJXX.','tactius903233@admin.com','19980711','010-1234-5366','5555',null,null,'N','Y','Y',default,default,'123323245','ssm7');
--- 
--- -- 기본 유저 
--- -- 사용자 1
--- Insert into C##SSMS.TB_USER
--- (ID,USER_ID,PASSWD,EMAIL,USER_NO,PHONE,
--- ACCOUNT_NUMBER,BANK_NAME,PROFILE_URL,IS_QUIT,
--- ADMIN_OK,LOGIN_OK,LAST_MODIFIED,
...