package com.jinwoo.boardback.service.implement;

import java.util.ArrayList;
import java.util.List;

import javax.validation.OverridesAttribute;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.jinwoo.boardback.dto.request.board.PostBoardRequestDto;
import com.jinwoo.boardback.dto.response.ResponseDto;
import com.jinwoo.boardback.dto.response.board.GetBoardResponseDto;
import com.jinwoo.boardback.dto.response.board.GetFavoriteListResponseDto;
import com.jinwoo.boardback.dto.response.board.GetLatestBoardListResponseDto;
import com.jinwoo.boardback.dto.response.board.PostBoardResponseDto;
import com.jinwoo.boardback.dto.response.board.PostCommentResponseDto;
import com.jinwoo.boardback.entity.BoardEntity;
import com.jinwoo.boardback.entity.BoardImageEntity;
import com.jinwoo.boardback.entity.BoardViewEntity;
import com.jinwoo.boardback.entity.CommentEntity;
import com.jinwoo.boardback.entity.FavoriteEntity;
import com.jinwoo.boardback.entity.UserEntity;
import com.jinwoo.boardback.repository.BoardImageRepository;
import com.jinwoo.boardback.repository.BoardRepository;
import com.jinwoo.boardback.repository.BoardViewRepository;
import com.jinwoo.boardback.repository.CommentRepository;
import com.jinwoo.boardback.repository.FavoriteRepository;
import com.jinwoo.boardback.repository.UserRepository;
import com.jinwoo.boardback.repository.resultSet.CommentListResultSet;
import com.jinwoo.boardback.service.BoardService;
import com.mysql.cj.x.protobuf.MysqlxDatatypes.Scalar.String;
import com.jinwoo.boardback.dto.response.board.PutFavoriteResponseDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImplement implements BoardService{

    private final UserRepository userRepository;
    private final BoardRepository boardRepository;
    private final CommentRepository commentRepository;
    private final FavoriteRepository favoriteRepository;
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

    @Override
    public ResponseEntity<? super GetFavoriteListResponseDto> getFavoriteList(Integer boardNumber) {
        
        List<UserEntity> userEntities = new ArrayList<>();

        try {
            boolean existedBoard = boardRepository.existsByBoardNumber(boardNumber);
            if (!existedBoard) return GetFavoriteListResponseDto.notExistBoard();

            userEntities = userRepository.findByBoardFavorite(boardNumber);

        } catch (Exception exception) {
            exception.printStackTrace();
            return ResponseDto.dataBaseError();
        }
        return GetFavoriteListResponseDto.success(userEntities);
    }

    @Override
    public ResponseEntity<? super PutFavoriteResponseDto> putFavorite(Integer boardNumber, String email) {
        
        try {
            boolean existedBoard = boardRepository.existsByBoardNumber(boardNumber);
            if (!existedBoard) return PutFavoriteResponseDto.notExistBoard();

            boolean existedUser = userRepository.existsByEmail(email);
            if(!existedUser) return PostBoardResponseDto.notExistUser();

            boolean isFavorite = favoriteRepository.existsByUserEmailAndBoardNumber(email, boardNumber);
            
            FavoriteEntity favoriteEntity = new FavoriteEntity(email, boardNumber);
            
            if(isFavorite) favoriteRepository.delete(favoriteEntity);
            else favoriteRepository.save(favoriteEntity);

        } catch (Exception exception) {
            exception.printStackTrace();
            return ResponseDto.dataBaseError();
        }
        return PutFavoriteResponseDto.success();
    }
    @Override
    public ResponseEntity<? super GetCommentListResponseDto> getCommentList(Integer boardNumber) {

        List<CommentListResultSet> resultSets = new ArrayList<>();

        try {

            boolean existedBoard = boardRepository.existsByBoardNumber(boardNumber);
            if (!existedBoard) return GetCommentListResponseDto.notExistBoard();

            resultSets = commentRespository.findByCommentList(boardNumber);

        } catch (Exception exception) {
            exception.printStackTrace();
            return ResponseDto.databaseError();
        }

        return GetCommentListResponseDto.success(resultSets);

    }
    @Override
    public ResponseEntity<? super PostCommentResponseDto> postComment(PostCommentRequestDto) {
        try {
            boolean existedBoard = boardRepository.existsByBoardNumber(boardNumber);
            if(!existedBoard) return PostCommentResponseDto.notExistBoard();

            boolean existedUser = userRepository.existsByEmail(email);
            if(!existedUser) return PostCommentResponseDto.notExistUser();

            CommentEntity commentEntity = new CommentEntity(dto, boardNumber, email);
            commentRepository.save(commentEntity);

        } catch (Exception exception) {
            exception.printStackTrace();
            return ResponseDto.dataBaseError();
            
        }
        return PostCommentResponseDto.success();
    }
    
}
