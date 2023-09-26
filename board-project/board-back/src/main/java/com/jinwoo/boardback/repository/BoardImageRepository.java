package com.jinwoo.boardback.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.jinwoo.boardback.entity.BoardImageEntity;

@Repository
public interface BoardImageRepository extends JpaRepository<BoardImageEntity, Integer> {
    
}
