package com.jinwoo.boardback.dto.response.board;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.jinwoo.boardback.dto.response.ResponseCode;
import com.jinwoo.boardback.dto.response.ResponseDto;
import com.jinwoo.boardback.dto.response.ResponseMessage;

import lombok.Getter;

@Getter
public class PutFavoriteResponseDto extends ResponseDto {
    private PutFavoriteResponseDto (String code, String message) {
        super(code, message);
    }

    public static ResponseEntity<PutFavoriteResponseDto> success() {
        PutFavoriteResponseDto result = new PutFavoriteResponseDto(ResponseCode.SUCCES, ResponseMessage.SUCCES);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    public static ResponseEntity<ResponseDto> notExistBoard() {
        ResponseDto result = new ResponseDto(ResponseCode.NOT_EXIST_BOARD, ResponseMessage.NOT_EXIST_BOARD);
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result);
    }

    public static ResponseEntity<ResponseDto> notExistUser() {
        ResponseDto result = new ResponseDto(ResponseCode.NOT_EXIST_USER, ResponseMessage.NOT_EXIST_USER);
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(result);
    }
}
