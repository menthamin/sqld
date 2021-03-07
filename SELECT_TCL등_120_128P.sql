/* 120PAGE, ROLLBACK */
-- ORACLE DML의 경우 조작하려는 TABLE을 메모리 버퍼위에 올려놓고 작업하기 때문에 COMMIT해야 내용이 적용 된다.
DELETE FROM PLAYER;
SELECT * FROM PLAYER;

ROLLBACK;
SELECT * FROM PLAYER;

/* 121PAGE SELECT */
SELECT PLAYER_NAME, COUNT(*)AS "CNT NUM" FROM PLAYER
GROUP BY PLAYER_NAME
ORDER BY 2 DESC;

SELECT POSITION, COUNT(*) AS "CNT" FROM PLAYER
GROUP BY POSITION;

SELECT PLAYER_NAME 선수명, -- 꼭 ALIAS를 주지 않아도 
        TEAM_ID 팀명,
        POSITION 포지션,
        HEIGHT 키,
        WEIGHT "몸무게 (Kg)" -- 공백, 특수문자, 대소문자 구분이 필요한경우에 DOUBLE QUATATION("")사용
        FROM PLAYER;
        
/* 123PAGE 산술 연산자 */
SELECT PLAYER_NAME 이름, ROUND(WEIGHT/((HEIGHT/100)*(HEIGHT/100)),2) "BMI 비만지수" 
FROM PLAYER
ORDER BY 2 DESC;

SELECT RPAD(PLAYER_NAME, 7, ' ') || '선수 : ' || HEIGHT || 'Cm, ' || WEIGHT || 'Kg' 체격정보 FROM PLAYER;
-- PAD 공부 https://gent.tistory.com/190
-- CHARSET 확인출처: https://creativeprm.tistory.com/207 [Creative Programmer]
SELECT name, value$
FROM sys.props$
WHERE name = 'NLS_CHARACTERSET';

/* 124PAGE TCL 트랜잭션 */
INSERT INTO PLAYER (PLAYER_ID, TEAM_ID, PLAYER_NAME, POSITION, HEIGHT, WEIGHT, BACK_NO)
VALUES ('1999035', 'K02', '이운재', 'GK', 182, 82, 1);

SELECT COUNT(1) FROM PLAYER;

ROLLBACK;

SELECT COUNT(1) FROM PLAYER;

/* 126PAGE SAVE POINT ROLLBACK */
SAVEPOINT SVPT1; -- 저장점이 생성되었다. 
INSERT INTO PLAYER (PLAYER_ID, TEAM_ID, PLAYER_NAME, -- INSERT
                    POSITION, HEIGHT, WEIGHT, BACK_NO) VALUES ('1999035', 'K02', '이운재', 'GK', 182, 82, 1);
                    
SELECT COUNT(1) FROM PLAYER;                   
ROLLBACK TO SVPT1; -- 롤백이 완료되었다.
SELECT COUNT(1) FROM PLAYER;

/* 128 PAGE SAVEPOINT 예제 */
SELECT COUNT(*) FROM PLAYER; ------- 480 1개의 행이 선택되었다.
SELECT COUNT(*) FROM PLAYER WHERE WEIGHT = 100;

INSERT INTO PLAYER (PLAYER_ID, TEAM_ID, PLAYER_NAME, -- 1개 행 INSERT
POSITION, HEIGHT, WEIGHT, BACK_NO) VALUES ('1999035', 'K02', '이운재', 'GK', 182, 82, 1); 
SAVEPOINT SVPT_A; -- SAVEPOINT A 생성

UPDATE PLAYER SET WEIGHT = 100; -- UPDATE
SAVEPOINT SVPT_B; -- SAVEPOINT B 생성
DELETE FROM PLAYER;

-- SAVEPOINT B까지 ROOLBACK 
ROLLBACK TO SVPT_B;
SELECT COUNT(*) FROM PLAYER;
SELECT * FROM PLAYER;

-- SAVEPOINT A까지 ROOLBACK
ROLLBACK TO SVPT_A;
SELECT * FROM PLAYER;

-- 전체 ROOLBACK
ROLLBACK;
SELECT COUNT(1) FROM PLAYER;

