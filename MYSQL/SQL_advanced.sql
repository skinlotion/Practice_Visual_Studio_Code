# 별칭 Alias
# 컬럼이나 테이블 명을 다른이름으로 표현하고자 할 때 사용

# 컬럼 혹은 테이블 명이 길거나, 더 의미있는 이름을 부여 하고 싶거나
# 다른 테이블간의 연결을 할 때, 혹은 같은 테이블 여러번 참조할 때

USE human_resource;

SELECT 업소명 as 가게명 FROM bbq as 치킨사업장테이블;

DROP TABLE employee;

CREATE TABLE department (
	department_name VARCHAR(100) NOT NULL UNIQUE,
    department_tel_number VARCHAR(15) NOT NULL UNIQUE,
    department_address TEXT NOT NULL,
    PRIMARY KEY (department_name)
);

CREATE TABLE employee (
	employee_number VARCHAR (10) NOT NULL UNIQUE,
    name VARCHAR(10) NOT NULL,
    address TEXT NOT NULL,
    department_name VARCHAR(100),
	PRIMARY KEY (employee_number),
    FOREIGN KEY (department_name) REFERENCES department (department_name)
);

INSERT INTO department
VALUES ('기획부', '051-111-1111', '부산광역시');
INSERT INTO department
VALUES ('영업부', '051-222-1111', '부산광역시');
INSERT INTO department
VALUES ('연구부', '051-333-1111', '부산광역시');
INSERT INTO department
VALUES ('인사부', '051-444-1111', '부산광역시');
INSERT INTO department
VALUES ('개발부', '051-555-1111', '부산광역시');
INSERT INTO department
VALUES ('재무부', '051-666-1111', '부산광역시');

INSERT INTO employee
VALUES ('0001', '양희정', '부산광역시', '인사부');
INSERT INTO employee
VALUES ('0002', '여상길', '부산광역시', '연구부');
INSERT INTO employee
VALUES ('0003', '김경훈', '부산광역시', '영업부');
INSERT INTO employee
VALUES ('0004', '조창석', '부산광역시', '개발부');
INSERT INTO employee
VALUES ('0005', '유정봉', '부산광역시', '기획부');
INSERT INTO employee
VALUES ('0006', '이수광', '부산광역시', '인사부');
INSERT INTO employee
VALUES ('0007', '박진우', '부산광역시', '연구부');
INSERT INTO employee
VALUES ('0008', '이수경', '부산광역시', '기획부');
INSERT INTO employee
VALUES ('0009', '이지훈', '부산광역시', '영업부');
INSERT INTO employee
VALUES ('0010', '최지선', '부산광역시', '개발부');
INSERT INTO employee
VALUES ('0011', '정아린', '부산광역시', null);
INSERT INTO employee
VALUES ('0012', '김정민', '부산광역시', '연구부');
INSERT INTO employee
VALUES ('0013', '김유정', '부산광역시', '기획부');
INSERT INTO employee
VALUES ('0014', '정이제', '부산광역시', '개발부');
INSERT INTO employee
VALUES ('0015', '이소진', '부산광역시', null);
INSERT INTO employee
VALUES ('0016', '서지훈', '부산광역시', null);

SELECT * FROM department;
SELECT * FROM employee;

# JOIN 두개 이상의 테이블을 조합하여 검색 결과를 얻고자 할 때 사용
# INNER, LEFT, RIGHT, FULL

#INNER JOIN : 첫 번쨰 테이블과 두 번쨰 테이블의 데이터 중 조건에 일치하는 데이터만 조합한다.

# SELECT 컬럼명, ... FROM (첫번째 테이블 INNER JOIN 두번째 테이블) ON 조건;



# 매칭되지 않는 데이터는 나타나지 않는다 (예 department이 null인 사람들은 매칭이 안됨)
SELECT 
	E.employee_number AS '사원번호',
	E.name AS '사원 이름' ,
    D.department_name AS '부서이름',
    D.department_tel_number AS '전화번호'
FROM department AS D
INNER JOIN employee AS E
ON D.department_name = E.department_name;

# LEFT JOIN - 첫 번쨰 테이블에 있는 모든 데이터와 두번 째 테이블에서 조건에 부합하는 데이터만을 조합
# SELECT 컬럼명,.. FROM 첫번째 테이블 LEFT JOIN 두번째 테이블 ON 조건;
SELECT *
FROM department
LEFT JOIN employee
ON department.department_name = employee.department_name;

# RIGHT JOIN - 두 번쨰 테이블에 있는 모든 데이터와 첫번 째 테이블에서 조건에 부합하는 데이터만을 조합
# SELECT 컬럼명,.. FROM 첫번째 테이블 RIGHT JOIN 두번째 테이블 ON 조건;
SELECT *
FROM department
RIGHT JOIN employee
ON department.department_name = employee.department_name;

# 서브쿼리
# - 쿼리 내부에 또 다른 쿼리가 작성되어있는 쿼리
# - WHERE, FROM, SELECT 위치에서 사용 가능

# WHERE 절에서의 서비스쿼리 사용

# employee_number가 0016인 사원의 부서명, 부서전화번호, 부서주소를 조회하시오
SELECT *
FROM department
WHERE department_name = (
	SELECT department_name
    FROM employee
    WHERE employee_number = 0010
);

# address가 부산광역시인 사원의 부서명, 부서전화번호, 부서주소를 조회하시오
SELECT * FROM department
WHERE department_name IN (				# '='은 하나의 데이터만 동등하다고 보니깐 안된다! => IN을 써야함
	SELECT department_name				# 비교 연산자 등 비교는 한개의 레코드(컬럼)와 레코드(컬럼)만 가능하다
	FROM employee
	WHERE address = '부산광역시' 
	);
    
# FROM 절에서 서브쿼리 사용방법

# adress가 '부산'을 포함하는 사원 중에서 / 부서가 null인 사원 전체 컬럼 조회하시오
SELECT *
FROM (
	SELECT *
	FROM employee
	WHERE address LIKE '%부산%'
	) AS T
WHERE department_name IS NULL;


# SELECT 절에서 서브쿼리 사용방법

SELECT department_name, (SELECT name FROM employee WHERE employee_number = 0003)
FROM department;

# 집계 함수 - 테이블에서 집계결과를 나타내주는 함수 (SELECT절에서 사용)

# COUNT 함수 : 레코드의 개수를 출력
SELECT count(*) FROM employee;
SELECT * FROM employee;
SELECT department_name FROM employee;
SELECT count(department_name) FROM employee;		# NULL값은 안셈
SELECT count(*) FROM employee WHERE department_name = '기획부';

# SUM함수 : 해당 컬럼에 총 합을 보여줌
SELECT SUM(department_name) FROM employee;		# 문자열이라서 안나옴
SELECT SUM(경도) FROM bbq WHERE 업소명 = '교촌치킨';

# AVG함수 : 해당 컬럼의 평균을 보여줌
SELECT AVG(경도) FROM bbq;

# MIN함수 : 해당 컬럼의 최소값을 보여줌
# MAN함수 : 해당 컬럼의 최댓값을 보여줌
SELECT min(위도), max(위도) FROM bbq;

SELECT *
FROM bbq
WHERE 업소명 LIKE '%bbq%';

# BBQ관련된 업소명을 모두 'BBQ'로 변경
UPDATE bbq
set 수정업소명 = 'BBQ치킨'
WHERE 업소명 LIKE '%bbq%' OR 업소명 LIKE '%비비큐%';

# BHC관련된 업소명을 모두 'BHC'치킨으로 변경
UPDATE bbq
set 수정업소명 = 'BHC치킨'
WHERE 업소명 LIKE '%bhc%' OR 업소명 LIKE '%B.H.C%';

UPDATE bbq
set 수정업소명 = '교촌치킨'
WHERE 업소명 LIKE '%교촌치킨%' OR 업소명 LIKE '%교촌%';

SELECT * FROM bbq WHERE 업소명 IN ('BBQ치킨', 'BHC치킨', '교촌치킨')
ORDER BY 업소명;

# ALTER TABLE bbq ADD COLUMN 수정업소명 VARCHAR(100);  #컬럼 추가해서 옮기기

# GROUP BY : 조회된 결과에서 하나 이상의 레코드를 기준으로 그룹화 하는 쿼리
SELECT 업소명, COUNT(*) FROM bbq
WHERE 업소명 IN ('BBQ치킨', 'BHC치킨', '교촌치킨')
GROUP BY 업소명;

# HAVING : GROUP BY의 결과에서 필터링 하고자 할 때 사용 가능
SELECT 업소명, COUNT(*) AS 수 FROM bbq
GROUP BY 업소명
HAVING 수 >= 10;
# HAVING 위도 >= 129 (X) 위도가 검색 결과에서 없기 떄문에

# INDEX - 테이블에서 원하는 컬럼의 데이터를 빠르게 찾을 수 있도록 하는 스키마
# 인덱스 생성 방법
# CREATE INDEX 인덱스명 ON 테이블명(컬럼,...);

CREATE INDEX bbq_업소명_idx ON bbq(업소명); 
CREATE INDEX bbp_위치_idx ON bbq(위도, 경도);

