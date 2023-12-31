use sample_board_2;
# 회원가입 SQL
INSERT INTO user (email, password, nickname,  tel_number, address, address_detail, agreed_personal)
VALUES ('email3@email.com', 'p!ssw2', '닉네임3', '0100000003', '부산광역시', '자이아파트', true);

#로그인 SQL
SELECT * FROM user
WHERE email = 'email@email.com' AND password = 'p!ssw2';

# 게시물 쓰기 SQL
INSERT INTO board (title, contents, writer_email)
VALUES('제목10', '내용10', 'email@email.com');

SELECT * FROM board;

# 게시물 수정 SQL
UPDATE board SET title = '수정제목', contents='수정내용' WHERE board_number = 8;

# 게시물 삭제 SQL
DELETE FROM board WHERE board_number = 1;

# 댓글 작성 SQL
INSERT INTO comment(board_number, user_email, content)
VALUES(10, 'email@email.com', '안뇽하세요');

# 좋아요 등록 SQL
INSERT INTO favorite VALUES (7, 'email@email.com');

# 좋아요 취소 SQL
DELETE FROM favorite
WHERE board_number = 2 ;


SELECT * FROM user;
SELECT * FROM board;

# 최신게시물 불러오기 SQL
SELECT 
	B.board_number,
    B.title,
    B.contents,
    B.write_dateTime,
    B.view_count,
    U.nickname,
    U.profile_image
FROM board AS B INNER JOIN user AS U
ON B.writer_email = U.email
ORDER BY B.write_dateTime DESC;

# 검색 기능_게시물 리스트 불러오기 SQL
SELECT
	B.board_number,
    B.title,
    B.contents,
    B.write_dateTime,
    B.view_count,
    U.nickname,
    U.profile_image
FROM board AS B
INNER JOIN user AS U
ON B.writer_email = U.email
WHERE B.title LIKE '%수%'
ORDER BY B.write_dateTime DESC;

# 특정 유저가 작성한 게시물 리스트 불러오기 SQL
SELECT
	B.board_number,
    B.writer_email,
    B.title,
    B.contents,
    B.write_dateTime,
    B.view_count,
    U.nickname,
    U.profile_image
FROM board AS B
INNER JOIN user AS U
ON B.writer_email = U.email
WHERE B.writer_email = 'email@email.com'
ORDER BY B.write_dateTime DESC;

#특정 게시물 번호가 2번인 게시물 조회 SQL
#(게시물번호, 제목, 내용, 작성날짜, 작성자 이메일, 작성자 닉네임, 작성자 프로필 사진)
SELECT
	B.board_number,
    B.title,
    B.contents,
    B.write_dateTime,
    B.writer_email,
    U.nickname,
    U.profile_image
FROM board AS B
INNER JOIN user AS U
ON B.writer_email = U.email
WHERE B.board_number = 10
ORDER BY B.write_dateTime DESC;

# 최신 게시물 불러오기 SQL (찐)
# 게시물 번호, 게시물 제목, 내용, (사진), 작성날짜 및 시간, 조회수,
# 작성자 프로필 사진, 작성자 닉네임,
# 댓글 수, 좋아요 수

# 사용 하는 테이블 board, user, favorite, comment
SELECT T1.board_number, T1.title, T1.contents, T1.image_url, T1.write_dateTime, T1.view_count,
    T1.profile_image, T1.nickname,
    T2.comment_count,
    T3.favorite_count
FROM (
	SELECT
    B.board_number, B.title, B.contents, B.image_url, B.write_dateTime, B.view_count,
    U.profile_image, U.nickname
	FROM board AS B
	INNER JOIN user AS U
	ON B.writer_email = U.email
    ) AS T1 INNER JOIN
    
	(SELECT B.board_number, count(C.user_email) AS comment_count 
	FROM board AS B
	LEFT JOIN comment AS C
	ON B.board_number = C.board_number
	GROUP BY B.board_number
    ) AS T2
    ON T1.board_number = T2.board_number
    LEFT JOIN 
    
	(SELECT B.board_number, count(F.user_email) AS favorite_count 
	FROM board AS B
	LEFT JOIN favorite AS F
	ON B.board_number = F.board_number
	GROUP BY B.board_number
	)AS T3
    ON T1.board_number = T3.board_number
ORDER BY T1.Write_datetime DESC;

# TOP3 게시물
SELECT T1.board_number, T1.title, T1.contents, T1.image_url, T1.write_dateTime, T1.view_count,
    T1.profile_image, T1.nickname,
    T2.comment_count,
    T3.favorite_count
FROM (
	SELECT
    B.board_number, B.title, B.contents, B.image_url, B.write_dateTime, B.view_count,
    U.profile_image, U.nickname
	FROM board AS B
	INNER JOIN user AS U
	ON B.writer_email = U.email
    ) AS T1 INNER JOIN
    
	(SELECT B.board_number, count(C.user_email) AS comment_count 
	FROM board AS B
	LEFT JOIN comment AS C
	ON B.board_number = C.board_number
	GROUP BY B.board_number
    ) AS T2
    ON T1.board_number = T2.board_number
    LEFT JOIN 
    
	(SELECT B.board_number, count(F.user_email) AS favorite_count 
	FROM board AS B
	LEFT JOIN favorite AS F
	ON B.board_number = F.board_number
	GROUP BY B.board_number
	)AS T3
    ON T1.board_number = T3.board_number
ORDER BY T3.favorite_count DESC
LIMIT 4;

# 검색 결과 리스트 불러오기 SQL
SELECT T1.board_number, T1.title, T1.contents, T1.image_url, T1.write_dateTime, T1.view_count,
    T1.profile_image, T1.nickname,
    T2.comment_count,
    T3.favorite_count
FROM (
	SELECT
    B.board_number, B.title, B.contents, B.image_url, B.write_dateTime, B.view_count,
    U.profile_image, U.nickname
	FROM board AS B
	INNER JOIN user AS U
	ON B.writer_email = U.email
    ) AS T1 INNER JOIN
    
	(SELECT B.board_number, count(C.user_email) AS comment_count 
	FROM board AS B
	LEFT JOIN comment AS C
	ON B.board_number = C.board_number
	GROUP BY B.board_number
    ) AS T2
    ON T1.board_number = T2.board_number
    LEFT JOIN 
    
	(SELECT B.board_number, count(F.user_email) AS favorite_count 
	FROM board AS B
	LEFT JOIN favorite AS F
	ON B.board_number = F.board_number
	GROUP BY B.board_number
	)AS T3
    ON T1.board_number = T3.board_number
    WHERE title LIKE '%3%'
ORDER BY T1.write_datetime DESC;

# VIEW - 읽기 전용의 가상의 테이블
# 물리적으로 존재하는 테이블이 아니기 때문에 입력, 수정, 삭제를 진행 할 수 없음
# 자주사용되는 복잡한 SELECT쿼리를 미리 작성하여 테이블 처럼 만들어 둔 것

# CREATE VIEW 뷰이름 ASboard_view SELECT...

CREATE VIEW board_view AS # Alias랑은 다른거임
SELECT T1.board_number, T1.title, T1.contents, T1.image_url, T1.write_dateTime, T1.view_count,
    T1.profile_image, T1.nickname,
    T2.comment_count,
    T3.favorite_count
FROM (
	SELECT
    B.board_number, B.title, B.contents, B.image_url, B.write_dateTime, B.view_count,
    U.profile_image, U.nickname
	FROM board AS B
	INNER JOIN user AS U
	ON B.writer_email = U.email
    ) AS T1 INNER JOIN
    
	(SELECT B.board_number, count(C.user_email) AS comment_count 
	FROM board AS B
	LEFT JOIN comment AS C
	ON B.board_number = C.board_number
	GROUP BY B.board_number
    ) AS T2
    ON T1.board_number = T2.board_number
    LEFT JOIN 
    
	(SELECT B.board_number, count(F.user_email) AS favorite_count 
	FROM board AS B
	LEFT JOIN favorite AS F
	ON B.board_number = F.board_number
	GROUP BY B.board_number
	)AS T3
    ON T1.board_number = T3.board_number;
    
    #최신게시물 불러오기 SQL3
    SELECT * FROM board_view
    ORDER BY write_datetime DESC;
    
    # 특정 유저 게시물 불러오기 SQL
    SELECT * FROM board_view
    WHERE nickname = '닉네임';