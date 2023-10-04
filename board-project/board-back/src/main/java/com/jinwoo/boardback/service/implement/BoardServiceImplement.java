package com.jinwoo.boardback.service.implement;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.jinwoo.boardback.dto.request.board.PostBoardRequestDto;
import com.jinwoo.boardback.dto.response.ResponseDto;
import com.jinwoo.boardback.dto.response.board.GetBoardResponseDto;
import com.jinwoo.boardback.dto.response.board.GetLatestBoardListResponseDto;
import com.jinwoo.boardback.dto.response.board.PostBoardResponseDto;
import com.jinwoo.boardback.entity.BoardEntity;
import com.jinwoo.boardback.entity.BoardImageEntity;
import com.jinwoo.boardback.entity.BoardViewEntity;
import com.jinwoo.boardback.repository.BoardImageRepository;
import com.jinwoo.boardback.repository.BoardRepository;
import com.jinwoo.boardback.repository.BoardViewRepository;
import com.jinwoo.boardback.repository.UserRepository;
import com.jinwoo.boardback.service.BoardService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImplement implements BoardService{

    private final UserRepository userRepository;
    private final BoardRepository boardRepository;
    private final BoardViewRepository boardViewRepository;
    private final BoardImageRepository boardImageRepository;

    @Override
    public ResponseEntity<? super PostBoardResponseDto> postBoard(PostBoardRequestDto dto, String email) {
        try {
            boolean existedUser = userRepository.existsByEmail(email);
            if(!existedUser) return PostBoardResponseDto.notExistUser();

            BoardEntity boardEntity = new BoardEntity(dto, email);
            boardRepository.save(boardEntity);

            List<String>boardImageList = dto.getBoardImageList();
            Integer boardNumber = boardEntity.getBoardNumber();

            List<BoardImageEntity> boardImageEntities = new ArrayList<>();
            for (String boardImage : boardImageList) {
                BoardImageEntity boardImageEntity = new BoardImageEntity(boardNumber, boardImage);
                boardImageEntities.add(boardImageEntity);
            }
            boardImageRepository.saveAll(boardImageEntities);

        } catch (Exception exception) {
            exception.printStackTrace();
            return ResponseDto.dataBaseError();
        }
        return PostBoardResponseDto.success();
    }

    @Override
    public ResponseEntity<? super GetBoardResponseDto> getboard(Integer boardNumber) {
        BoardViewEntity boardViewEntity = null;
        List<BoardImageEntity> boardImageEntities = new ArrayList<>();

        try {
            boardViewEntity = boardViewRepository.findByBoardNumber(boardNumber);
            if (boardViewEntity == null) return GetBoardResponseDto.notExistBoard();

            boardImageEntities = boardImageRepository.findByBoardNumber(boardNumber);
            

        } catch (Exception exception) {
            exception.printStackTrace();
            return ResponseDto.dataBaseError();
        }
        return GetBoardResponseDto.success(boardViewEntity, boardImageEntities);
    }

    @Override
    public ResponseEntity<? super GetLatestBoardListResponseDto> getLatestBoardList() {
        
        List<BoardViewEntity> boardViewEntities = new ArrayList<>();
        
        try {
            boardViewEntities = boardViewRepository.findByOrderByWriteDatetimeDesc();

        } catch (Exception exception) {
            exception.printStackTrace();
            return ResponseDto.dataBaseError();
        }
        return GetLatestBoardListResponseDto.succes(boardViewEntities);
    }


    
}
