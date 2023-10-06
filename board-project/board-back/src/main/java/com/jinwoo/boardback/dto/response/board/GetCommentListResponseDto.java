package com.jinwoo.boardback.dto.response.board;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.jinwoo.boardback.common.object.CommentListItem;
import com.jinwoo.boardback.dto.response.ResponseCode;
import com.jinwoo.boardback.dto.response.ResponseDto;
import com.jinwoo.boardback.dto.response.ResponseMessage;
import com.jinwoo.boardback.repository.resultSet.CommentListResultSet;

import lombok.Getter;

@Getter
public class GetCommentListResponseDto extends ResponseDto {
    
    List<CommentListItem> commentList;

    private GetCommentListResponseDto(String code, String message, List<CommentListResultSet> resultSets) {
        super(code, message);
        this.commentList = CommentListItem.getList(resultSets);
    }

    public static ResponseEntity<GetCommentListResponseDto> success(List<CommentListResultSet> resultSets) {
        GetCommentListResponseDto result = new GetCommentListResponseDto(ResponseCode.SUCCES, ResponseMessage.SUCCES, resultSets);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    public static ResponseEntity<ResponseDto> notExistBoard() {
        ResponseDto result = new ResponseDto(ResponseCode.NOT_EXIST_BOARD, ResponseMessage.NOT_EXIST_BOARD);
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result);
    }

}
