package com.jinwoo.boardback.dto.response;

public interface ResponseCode {
    
    String SUCCES = "SE";

    String VALIDATION_FAILD = "VF";
    String DUPLICATED_EMAIL = "DE";
    String DUPLICATED_NICKNAME = "DN";
    String DUPLICATED_TEL_NUMBER = "DT.";

    String DATABASE_ERROR = "DBE";
    
}