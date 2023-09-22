package com.jinwoo.boardback.dto.response;

public interface ResponseMessage {
    
    String SUCCES = "Success.";
    
    String VALIDATION_FAILD = "Validation failed.";
    String DUPLICATED_EMAIL = "Duplicated email.";
    String DUPLICATED_NICKNAME = "Duplicate nickname.";
    String DUPLICATED_TEL_NUMBER = "Duplicate telephone number.";

    String DATABASE_ERROR = "Database error.";
}
