package com.jinwoo.boardback.service.implement;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.jinwoo.boardback.dto.response.ResponseDto;
import com.jinwoo.boardback.dto.response.user.GetSignInUserResponseDto;
import com.jinwoo.boardback.entity.UserEntity;
import com.jinwoo.boardback.repository.UserRepository;
import com.jinwoo.boardback.service.UserService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImplemnet implements UserService{
   
    private final UserRepository userRepository;
   
    @Override
    public ResponseEntity<? super GetSignInUserResponseDto> getSignInUser(String email) {
        
        UserEntity userEntity = null;
        
        try {

            userEntity = userRepository.findByEmail(email);
            if (userEntity == null) return GetSignInUserResponseDto.notExistUser();
            
        } catch (Exception exception) {
            exception.printStackTrace();
            return ResponseDto.dataBaseError();
        }
        return GetSignInUserResponseDto.success(userEntity);
    }
}
