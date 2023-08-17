
CREATE DATABASE human_resource;

USE human_resource;

CREATE TABLE employee (
  employee_number VARCHAR(20),
  name VARCHAR(20),
  age INT
);


# DML (데이터 조작어)
# 실제데이터를 삽입, 검색, 수정, 삭제할떄 사용됨

# INSERT 구문
# 데이터를 데이블에 삽입 할 때 사용됨 (row에다가)
# 1. 전체 컬럼에 대하여 삽입
# INSERT INTO 테이블명 VALUES (값1, 값2, ...);

insert INTO employee VALUES ('20230731001', '홍길동', 30);

# INSERT가 안되는 예시
# insert INTO employee VALUES (30, '202307002', '홍길동'); 
# 위의 식이 안되는 이유 : 전체 컬럼에 대한 삽입 작업은 컬럽의 순서와 삽입하고자 하는 데이터의 순서가 일치해야한다.

# INSERT INTO employee VALUES ('20230731002', '홍길동');
# 위의 식이 안되는 이유 : 전체 컬럼에 대한 삽입 작업은 컬럼의 갯수와 삽입하고자 하는 데이터의 갯수가 일치 해야한다.

# 2. 특정 컬럼을 지정하여 삽입
# INSERT INTO 테이블명(컬럼몁1, 컬럼명2, ...)
# VALUES (값1, 값2, ...);

INSERT INTO employee (employee_number, name, age)
VALUES ( '20230731002', '김철수', 20);

# 컬럼을 지정하여 삽입 작업을 할 때 지정하는 컬럼에는 순서가 없음.
# 위의 식에서 컬럼순서를 바꾸면 그에 맞게 VALUE값을 넣으면 된다 (지정한 순서와 값의 순서는 일치해야함!!)
INSERT INTO employee (age, employee_number, name)
VALUES ( 25, '20230731002', '김철수');

# 칼럼수와 데이터수가 일치해야된다! => 이거를 맵핑이라고 한다.
# INSERT INTO employee (age, employee_number)
# VALUES ( 25, '20230731002', '김철수');

INSERT INTO employee (age)
VALUES (25);

#UPDATE
# 데이블에 존재하는 데이터를 수정할 때 사용
# UPDATE 테이블명 SET 컬럼1 = 값1, 컬럼2 = 값2 ...
# WHERE 조건;

UPDATE employee SET age = 10;
UPDATE employee SET age = 15, name = '세종대왕';
UPDATE employee SET employee_number = '20230731003'
WHERE employee_number IS null; 

# DELETE
# 테이블에서 데이터를 삭제 할 때 사용
# DELETE FROM 데이블 => 전체 데이터 테이블 삭제
# DELETE FROM 데이블 WHERE 조건=> 특정 조건의 데이터 테이블 삭제

DELETE FROM employee WHERE employee_number = '20230731001';
DELETE FROM employee;

# 삭제 경우 정리
# DROP(DDL) / DELETE(DML) / TRUNCATE (DDL)
# DROP : 정의를 삭제함
# DELETE : 데이터 테이블의 데이터를 삭제함
# TRUNCATE

CREATE TABLE smaple (
	num1 INT AUTO_INCREMENT PRIMARY KEY,
    comment1 TEXT
);

INSERT INTO smaple (comment1) VALUES ('예시');

DROP TABLE smaple;
DROP DATABASE sample_board_1;

DELETE FROM smaple;
# 데이터 행만 삭제한거임

TRUNCATE TABLE smaple;
#데이블 생성 직전으로 되돌림 (완전 초기화)

SELECT *FROM smaple;

INSERT INTO employee VALUES ( '202307031001', '홍길동', 30);
INSERT INTO employee VALUES ( '202307031002', '김철수', 32);
INSERT INTO employee VALUES ( '202307031003', '이영자', 22);
INSERT INTO employee VALUES ( '202307031004', '배철수', null);

INSERT INTO employee VALUES ( '202307031001', '뉴진수', 30);
INSERT INTO employee VALUES ( '202307031002', '르세라핌', 32);
INSERT INTO employee VALUES ( '202307031003', '권상우', 22);
INSERT INTO employee VALUES ( '202307031004', '고창석', null);

SELECT *FROM employee;
# SELECT

# 테이블에서 데이터를 조회할 떄 사용
# 1. 전체 컬럼 및 데이터 조회
# SELECT * FROM 테이블명;
SELECT * FROM employee;

# 2. 특정 컬럼 조회
SELECT age, name FROM employee;

# 3. 특정 row(레코드) 조회
SELECT * FROM employee WHERE age = 22;

# DISTINCT

#SELECT문에서 검색결과의 중복을 제거
#SELECT DISTINCT 컬럼명 FROM 테이블명 WHERE 조건;

SELECT * FROM employee;
SELECT employee_number FROM employee;
SELECT distinct employee_number FROM employee;

SELECT employee_number, name FROM employee;
SELECT DISTINCT employee_number, name FROM employee;			# NAME 과 NUMBER조합의 중복을 제거

SELECT employee_number, age FROM employee;
SELECT DISTINCT employee_number, age FROM employee;

# ORDER BY
# 검색 결과를 정렬할 때 사용
# SELECT 컬럼 FROM 테이블명 WHERE 조건 ODER BY 컬럼명 ASC or DESC,...
# ASC(올림차순) DESC(내림차순)

SELECT * FROM employee ORDER BY employee_number DESC;

SELECT * FROM employee WHERE age= 10 ORDER BY employee_number DESC, name ASC;
# (조건 먼저 검사하고 그 검색 결과에서 SELET 해서 컬럼 선택하고 하고 그 다음 함 *=>all 이라는 말임bbqbbqbbqbbq)


# 연산자 (비교, 논리연산자)
SELECT * FROM bbq;
SELECT DISTINCT 업소명 FROM bbq;
SELECT * FROM bbq ORDER BY 업소명;

# = : 좌항이 우항과 같으면 TRUE값 반환
# =!, <> : 좌항과 우항이 다르면 TRUE값 반환
SELECT * FROM bbq WHERE 업소명 = '교촌치킨';
SELECT * FROM bbq WHERE 업소명 <> '비비큐';

# > : 좌항이 우항보다 크면 true
# < : 좌항이 우항보다 작으면 true
# >= : 좌항이 우항보다 크거나 같으면 true
# <= : 좌항이 우항보다 작거나 같으면 true
SELECT * FROM bbq WHERE 경도 > 35.1;
SELECT * FROM bbq WHERE 업소명 > '닭썸' ORDER BY 업소명 ASC;

# <=> : 좌항과 우항이 모두 null일때 true를 반환 
UPDATE bbq SET 업소명 = null WHERE 업소명 = '비비큐';
SELECT * FROM bbq WHERE 업소명 <=> null;		# 업소명이 null인 값을 반환하는 거임

# IS : 좌항과 우항이 같으면 true를 반환 (true, false, unknow, null)
# IS null : 좌항이 NULL이면 true 반환

SELECT * FROM bbq WHERE 업소명 IS NULL;
SELECT * FROM bbq WHERE 업소명 IS TRUE ORDER BY 업소명;

# IS NOT : 좌항과 우항이 다르면 true 반환(true, false, unknow, null)
# IS NOT NULL : 좌항이 null이 아니면 true 반환
SELECT * FROM bbq WHERE 업소명 IS NOT NULL;

# BETWEEN min AND max : min 보다 크거나 같으면서 max 보다 작거나 같으면 true반환
# NOT BETWEEN min AND max : min 보다 작거나 max보다 크면 true 반환
SELECT * FROM bbq WHERE 위도 BETWEEN 129.027 AND 129.028;
SELECT * FROM bbq WHERE 위도 NOT BETWEEN 129.027 AND 129.028;

# IN : 좌항이 인수로 전달 받는 값 중 하나라도 존재하면 true
# NOT IN : 좌항이 인수로 전달 받는 값 중 하나도 존재하지 않으면 true;
SELECT * FROM bbq WHERE 업소명 IN('BBQ개금점', 'BBQ반여점', '교촌치킨');
SELECT * FROM bbq WHERE 업소명 NOT IN('금복용호통닭', '소풍경 중구점', '교촌치킨');


#논리연산자

# AND, && 연산자 : 좌항과 우항이 모두 true일때 true반환
SELECT * FROM bbq WHERE 위도 > 129.028 AND 경도 > 35.1;

# OR, || 연산자 : 좌항과 우항 중 하나라도 true이면 true반환
SELECT * FROM bbq WHERE 위도 > 129.028 OR 경도 > 35.1;

# *AND랑 OR이 같이 쓰였을때 AND가 우선순위임 => (교촌치킨을 만족하면서 위도가 129.28 이상인 것들) 중 경도가 35.1인 보다 큰 레코드
SELECT *
FROM bbq
WHERE 업소명 = ('교촌치킨' 
AND 위도 > 129.28) 			# 이게 노멀임
OR 경도 > 35.1;

# XOR : 좌항과 우항이 서로 다르면 true 반환 (둘중 하나만 만좃하는 레코드를 뽑고 싶을때)
SELECT * FROM bbq WHERE 위도 > 129.028 XOR 경도 > 35.1;

# NOT : 우항의 부정을 반환
SELECT * FROM bbq WHERE NOT 위도 > 129.028;   # (낮거나 같은애들이 나오게됨)

#LIKE연산자
# 문자열 데이터에서 특정 패턴에 맞는 데이터를 찾아주는 연산자

# % : 임의의 갯수(0~무한대)를 표현하는 와일드 카드
# _ : 임의의 하나의 문자를 표현하는 와일드 카드

# '부산광역시%' (부산광역시로 시작하는 모든 글자)
# '%부산광역시%' (부산광역시가 들어간 모든 글자)
# '부산광역시%' ( 부산광역시로 시작하고 한들자 더 들어간 문자) 

# 업소명이 치킨으로 끝나는 레코드를 검색
SELECT * FROM bbq WHERE 업소명 LIKE '%치킨';

# 업소명이 4글자 이면서 치킨으로 끝나는 레코드를 검색
SELECT * FROM bbq WHERE 업소명 LIKE '__치킨';

#소재지 중 부산진구에 속한 레코드 검색
SELECT * FROM bbq WHERE 소재지 LIKE '%부산진구%';


