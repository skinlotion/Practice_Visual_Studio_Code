# 게시판 프로젝트 스키마 정의

# 데이터 베이스 생성
CREATE DATABASE sample_board_1;

# 데이터 베이스 테이블 생성
# 회원정보(USER) / 게시물(BOARD)

USE sample_board_1;

CREATE TABLE user(
	email VARCHAR(50),			# 구분자로 쓰는 애들은 text잡으면 안됨(데이터 자체에 의미가 있는애들)
    password VARCHAR(255),
    nickname VARCHAR(20),
    tel_number VARCHAR(15),
    address TEXT,
    address_detail TEXT,
    agreed_personal BOOLEAN,
    profile_image TEXT
);

CREATE TABLE board(
	board_number INT,
    title TEXT,
    contents TEXT,
	write_dateTime DATETIME,
	writer_email VARCHAR(50),
	writer_nicname VARCHAR(20),
	writer_Profile_Image TEXT,
	view_count INT
);
SELECT *FROM sample_board_1;

# FOREING KEY : 외래키 제약조건, 해당 컬럼이 외부 테이블의 기본키와 관계가 있음을 나타냄

CREATE TABLE super_table (
	primary_column INT PRIMARY KEY,
    column1 INT
);

CREATE TABLE sub_table (
	column2 INT,
    foreign_column INT,
    CONSTRAINT sub_table_fk
    FOREIGN KEY (foreign_column)
    REFERENCES super_table (primary_column)
    ON UPDATE CASCADE ON DELETE SET NULL
    
	# ON UPDATE, ON DELETE 옵션
    # 수정 및 삭제 작업에 대해서 참조하고 있는 데이터가 변경될 떄의 작업을 지정 할 수 있다.
    # CASCADE : 참조되어지는 데이터가 변경되면(super), 참조하는 데이터도 변경되는 것 (sub)
    # SET NULL : 참조되어지는 데이터가 변경되면, 참조하는 데이터가 null로 변경됨
    # RESTRICT : 참조되어지는 데이터가 변경이 불가능
);



# 제한 사항
# DROP TABLE super_table; 걸려있어서 삭제가 안됨

# 삽입에 관한 제한 사항
INSERT INTO super_table VALUES (1,1);
INSERT INTO sub_table VALUES (1,1);		# sub_table에 먼저 값을 넣으면 안됨 

# UPDATE에 관한 제한 사항
UPDATE sub_table SET foreign_column = 2;		# 안됨! SUPER에 1이 있어서
    
UPDATE super_table SET primary_column = 2;		# 이것도 안됨! super에 1이 있는체로 참조 걸려있는데 그걸 2로 바꿀려고 하니 안됨ALTER

# DELETE에 관한 제한 사항
DELETE FROM super_table;						# 참조 걸려있어서 안됨

# DROP TABLE sub_table;

SELECT * FROM super_table;
SELECT * FROM sub_table;