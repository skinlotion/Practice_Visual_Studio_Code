
# 제약조건 (Constraints)

# 테이블 컬럼의 무결성을 보장해주는 조건
# NOT NULL : 해당 컬럼의 null을 지정할 수 없도록 하는 조건 (필수값)
# INSERTm UPDATE에 영향을 미침

CREATE TABLE smaple_table_1 (
	column1 INT,
    not_null_column INT NOT NULL
);

INSERT INTO smaple_table_1 VALUES (1,null);
INSERT INTO smaple_table_1 (column1) VALUES (1);

INSERT INTO smaple_table_1 VALUES (1,1);
UPDATE smaple_table_1 SET not_null_column = null;

SELECT * FROM smaple_table_1;

# UNIQUE : 해당 컬럼에 중복되는 값을 가질 수 없도록 하는 조건 (중복 제어)
# INSERT, UPDATE에 영향을 미침
CREATE TABLE sample_table_2 (
	column1 INT,
    unique_column INT UNIQUE
);

INSERT INTO sample_table_2 VALUE (1,1);
INSERT INTO sample_table_2 VALUE (1,1);
INSERT INTO sample_table_2 VALUE (1,2);

UPDATE sample_table_2 SET unique_column = 1;

SELECT * FROM sample_table_2;

# PRIMARY KEY : 기본키 제약조건, 해당 컬럼을 기본키(구분자)로 지정
# UNIQUE + NOT NULL 로 지정되어있어야 한다
# 후보키 중에서 개발자들이 선택한 것
# INSERT, UPDATE, DELETE에 영향을 미침

CREATE TABLE sample_table_3 (
	column1 INT,
    PRIMARY_column INT PRIMARY key
);

INSERT INTO sample_table_3 VALUE (1,null);
INSERT INTO sample_table_3 VALUE (1,1);
INSERT INTO sample_table_3 VALUE (1,1);

CREATE TABLE sample_table_4 (
	primary_column1 INT,
 	primary_column2 INT,
    column1 INT,
    CONSTRAINT sample_table_4_PK
    PRIMARY KEY (primary_column1, primary_column2)				# 여러개의 조합의 프라이머키 이름을 지정해줘야함
);																# 슈퍼 프라이머리 라고도 함
																# 그냥 칼럽을 하나 더 만들어도 됨
SELECT * FROM Information_schema.table_constraints WHERE table_schema = 'human_resource';

# CHECK : 지정한 컬럼에 들어갈 데이터를 제한하는 제약조건
# INSERT와 UPDATE에 영향을 미침

CREATE TABLE sample_table_5 (
	column1 INT,
    check_column INT CHECK ( check_column > 0 AND check_column < 10)
);

INSERT INTO sample_table_5 VALUE (1,0);
INSERT INTO sample_table_5 VALUE (1,10);
INSERT INTO sample_table_5 VALUE (1,4);

UPDATE sample_table_5 SET check_column = 100;

# DEFAULT : 해당 컬럼에 값을 지정하지 않으면 기본값으로 지정해주는 제약조건
# INSERT에서 영향을 미침

CREATE TABLE sample_table_6 (
	column1 INT,
    default_column INT DEFAULT 10
);

INSERT INTO sample_table_6 (column1) VALUES (1);
SELECT * FROM sample_table_6;
INSERT INTO sample_table_6 VALUES (1, null);   # NULL값은 지정한 것이기 떄문에 값이 안들어감.


