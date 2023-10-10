import ResponseDto from "apis/dto/response"

export default interface PatchBoardRequestDto extends ResponseDto{
    title : string 
    content : string 
    boardNumber : string
}