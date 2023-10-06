package com.jinwoo.boardback.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.jinwoo.boardback.dto.request.board.postCommentRequestDto;
import com.mysql.cj.x.protobuf.MysqlxDatatypes.Scalar.String;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity (name = "comment")
@Table (name = "comment")
public class CommentEntity {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int commentNumber;
    private int boardNumber;
    private String userEmail;
    private String contents;
    private String writeDatetime;

    public CommentEntity(postCommentRequestDto dto, Integer boardNumber, String email) {
        Date now = Date.from(Instant.now());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String writeDatetime = simpleDateFormat.format(now);

        this.boardNumber = boardNumber;
        this.userEmail = email;
        this.contents = dto.getContest();
        this.writeDatetime = writeDatetime;
    }
    
}
