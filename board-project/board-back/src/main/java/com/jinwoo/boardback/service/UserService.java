package com.jinwoo.boardback.service;

import org.springframework.http.ResponseEntity;

import com.jinwoo.boardback.dto.response.user.GetSignInUserResponseDto;

public interface UserService {
    
    ResponseEntity<? super GetSignInUserResponseDto> getSignInUser(String email);
}
