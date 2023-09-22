package com.jinwoo.boardback.controller;

import javax.validation.Valid;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jinwoo.boardback.dto.request.auth.SignUpRequestDto;
import com.jinwoo.boardback.dto.response.auth.SignUpResponseDto;
import com.jinwoo.boardback.service.AuthService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {
    
    private final AuthService authService;

    @PostMapping("/sign-up")
    public ResponseEntity<? super SignUpResponseDto> signUp(
        @RequestBody @Valid SignUpRequestDto requesBody
    ){
        ResponseEntity<? super SignUpResponseDto> response = authService.signUp(requesBody);
        return response;
    }
}
