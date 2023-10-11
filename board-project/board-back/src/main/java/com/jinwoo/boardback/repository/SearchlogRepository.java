package com.jinwoo.boardback.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.jinwoo.boardback.entity.SearchLogEntity;

@Repository
public interface SearchlogRepository extends JpaRepository<SearchLogEntity, Integer> {
    
}
