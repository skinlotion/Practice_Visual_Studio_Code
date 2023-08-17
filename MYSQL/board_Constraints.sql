CREATE DATABASE sample_board_2;
USE sample_board_2;


CREATE TABLE user(
	email VARCHAR(50) PRIMARY KEY,			# NOT NULL UNIQE 로 레코드 구분이 가능하다! (후보키)
    password VARCHAR(255) NOT NULL,
    nickname VARCHAR(20) NOT NULL UNIQUE,
    tel_number VARCHAR(15) NOT NULL UNIQUE,
    address TEXT NOT NULL,
    address_detail TEXT,
    agreed_personal BOOLEAN NOT NULL CHECK (agreed_personal IS true),
    profile_image VARCHAR(500) NOT NULL DEFAULT 'https://www.'
    );


CREATE TABLE board(
	board_number INT PRIMARY KEY AUTO_INCREMENT,
    title TEXT NOT NULL,
    contents TEXT NOT NULL,
	write_dateTime DATETIME NOT NULL DEFAULT now(),
	writer_email VARCHAR(50) NOT NULL,
	view_count INT NOT NULL DEFAULT 0,
    FOREIGN KEY (writer_email) REFERENCES user (email)
);
# 궁금? PK만 참조가능한가
DROP TABLE board;
# n 대 n의 관계는 관계테이블을 생성해야한다! 배열이 들어갈수가 없어서 테이블을 만들어줌 예) 한 유저가 좋아요한 게시물들

CREATE TABLE favorite(
	board_number INT NOT NULL,
    user_email VARCHAR(50) NOT NULL,		
    UNIQUE (board_number, user_email),
    FOREIGN KEY (board_number) REFERENCES board ( board_number),
    FOREIGN KEY (user_email) REFERENCES user (email)
);

CREATE TABLE comment(
	board_number INT NOT NULL,
    user_email VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    write_datetime DATETIME NOT NULL DEFAULT now(),
	FOREIGN KEY (board_number) REFERENCES board ( board_number),
    FOREIGN KEY (user_email) REFERENCES user (email)
);