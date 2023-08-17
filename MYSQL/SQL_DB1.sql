# or -- 주석 처리 

# DDL(Data Definition Language) 데이터 정의어
# 데이터베이스 스키마를 정의할 때 사용되는 명령어
# 스키마 : 데이터 구조를 정의한 것
# CREATE, ALTER, DROP

# CREATE(생성) : 스키마를 생성할 때 사용
# CREATE 스키마타입 + 스키마이름

# 데이터베이스 생성 (자바에서 헷갈릴까봐 대문자로 씀)
CREATE DATABASE human_resource;
# 데이터 베이스를 생성하면 가장 먼저 해줘야하는것 
# 데이터 베이스 생성 후에 해당 데이터베이스에서 작업을 하기 위해서는 USE 데이터베이스명; 을 해야한다.
USE human_resource;

# 테이블 생성
# CREATE TABLE 테이블 명( 컬럼명 컬럼타입, ...);
CREATE TABLE employee(
	employee_number VARCHAR(20),
    name VARCHAR(20),
    age INT
);

# 데이터베이스의 데이터 타입 예) VARCHAR(20) 이런거

CREATE TABLE data_type (
	column1 INT,			# 정수형 데이터 타입
    column2 DOUBLE, 		# 실수형 데이터 타입 : (FLOAT를 더 많이 사용)
    column3 BOOLEAN, 		# 논리형 데이터 타입 : (자바에서는 T,F / 데이터 베이스에서는 0: FALSE, 1(TINI INT매우작은 정수):TRUE)
    column4 VARCHAR(10), 	# 문자열 데이터 타입 : 케릭터를 배열로 만든거랑 동일 (숫자) 숫자 : 길이
    column5 TEXT,			# 문자열 데이터 타입 : 길이 제한을 적지 않음
    column6 DATE,			# 날짜 데이터 타입 
    column7 TIME,			# 시간 데이터 타입
    column8 DATETIME		# 날짜 및 시간 데이터 타입
);

# 사용자 생성
# CREATE USER '계정의 이름'@'접근 가능한 위치' IDENTIFIED BY '비밀번호';
CREATE USER 'developer1'@'localhost' IDENTIFIED BY 'qkrwlsdn';

USE MYSQL;
select*from user;

# ALTER : 스키마 정의 수정 할 때 사용 (되도록 안쓰는게 좋다! -> 데이터간의 참조된 경우가 있으므로)

# 테이블 수정 
# 테이블 컬럼 추가
ALTER TABLE employee ADD address TEXT;

# 테이블 컬럼 삭제
ALTER TABLE employee DROP COLUMN address;

# 테이블 컬럼 타입 수정
ALTER TABLE employee MODIFY COLUMN employee_number VARCHAR(10);

#DROP : 스키마 정의 삭제 할 때 사용

# 테이블 삭제
DROP TABLE employee1;

#데이터베이스 삭제
DROP DATABASE human_resource;


