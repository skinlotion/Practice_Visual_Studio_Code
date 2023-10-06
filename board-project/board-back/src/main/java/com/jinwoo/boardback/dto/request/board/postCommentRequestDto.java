package com.jinwoo.boardback.dto.request.board;

import javax.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class postCommentRequestDto {
    @NotBlank
    private String contest;
    
}
