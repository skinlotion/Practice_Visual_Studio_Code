package com.jinwoo.boardback.service;

import org.springframework.http.ResponseEntity;

import com.jinwoo.boardback.dto.request.board.PostBoardRequestDto;
import com.jinwoo.boardback.dto.response.board.GetBoardResponseDto;
import com.jinwoo.boardback.dto.response.board.GetCommentListResponseDto;
import com.jinwoo.boardback.dto.response.board.GetFavoriteListResponseDto;
import com.jinwoo.boardback.dto.response.board.GetLatestBoardListResponseDto;
import com.jinwoo.boardback.dto.response.board.PostBoardResponseDto;
import com.jinwoo.boardback.dto.response.board.PostCommentResponseDto;
import com.jinwoo.boardback.dto.response.board.PutFavoriteResponseDto;

public interface BoardService {
    ResponseEntity<? super PostBoardResponseDto> postBoard(PostBoardRequestDto dto, String email);
    ResponseEntity<? super PostCommentResponseDto> postComment(PostCommentResponseDto dto, Integer boardNumber, String email);
    
    ResponseEntity<? super GetBoardResponseDto> getboard(Integer boardNumber);
    ResponseEntity<? super GetFavoriteListResponseDto> getFavoriteList(Integer boardNumber);
    ResponseEntity<? super GetCommentListResponseDto> getCommentList(Integer boardNumber);

    ResponseEntity<? super GetLatestBoardListResponseDto> getLatestBoardList();

    ResponseEntity<? super PutFavoriteResponseDto> putFavorite(Integer boardNumber, String email);
}
