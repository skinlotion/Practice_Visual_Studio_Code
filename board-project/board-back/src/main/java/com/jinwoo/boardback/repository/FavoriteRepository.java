package com.jinwoo.boardback.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jinwoo.boardback.entity.FavoriteEntity;
import com.jinwoo.boardback.entity.primaryKey.FavoritePk;

public interface FavoriteRepository extends JpaRepository<FavoriteEntity, FavoritePk> {
    
    boolean existsByUserEmailAndBoardNumber(String userEmail, Integer boardNumber);
}
