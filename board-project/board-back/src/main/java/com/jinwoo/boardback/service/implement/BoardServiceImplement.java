package com.jinwoo.boardback.service.implement;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.jinwoo.boardback.dto.request.board.PostBoardRequestDto;
import com.jinwoo.boardback.dto.response.ResponseDto;
import com.jinwoo.boardback.dto.response.board.PostBoardResponseDto;
import com.jinwoo.boardback.entity.BoardEntity;
import com.jinwoo.boardback.repository.BoardRepository;
import com.jinwoo.boardback.repository.UserRepository;
import com.jinwoo.boardback.service.BoardService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImplement implements BoardService{

    private final UserRepository userRepository;
    private final BoardRepository boardRepository;

    @Override
    public ResponseEntity<? super PostBoardResponseDto> postBoard(PostBoardRequestDto dto, String email) {
        try {
            boolean existedUser = userRepository.existsByEmail(email);
            if(!existedUser) return PostBoardResponseDto.notExistUser();

            BoardEntity boardEntity = new BoardEntity(dto, email);
            boardRepository.save(boardEntity);

            List<String>boardImageList = dto.getBoardImageList();
            

        } catch (Exception exception) {
            exception.printStackTrace();
            return ResponseDto.dataBaseError();
        }
        return PostBoardResponseDto.success();
    }
    
}
