package com.jinwoo.boardback.dto.response.board;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.jinwoo.boardback.dto.response.ResponseCode;
import com.jinwoo.boardback.dto.response.ResponseDto;
import com.jinwoo.boardback.dto.response.ResponseMessage;

import lombok.Getter;

@Getter
public class PostBoardResponseDto extends ResponseDto{
    private PostBoardResponseDto(String code, String message) {
        super(code, message);
    }

    public static ResponseEntity<PostBoardResponseDto> success() {
        PostBoardResponseDto result = new PostBoardResponseDto(ResponseCode.SUCCES, ResponseMessage.SUCCES);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    public static ResponseEntity<ResponseDto> notExistUser() {
        ResponseDto result = new ResponseDto(ResponseCode.NOT_EXIST_USER, ResponseMessage.NOT_EXIST_USER);
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result);
    }
    
}
