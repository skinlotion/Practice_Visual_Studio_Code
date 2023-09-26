package com.jinwoo.boardback.service;

import org.springframework.http.ResponseEntity;

import com.jinwoo.boardback.dto.request.board.PostBoardRequestDto;
import com.jinwoo.boardback.dto.response.board.PostBoardResponseDto;

public interface BoardService {
    ResponseEntity<? super PostBoardResponseDto> postBoard(PostBoardRequestDto dto, String email);
}
