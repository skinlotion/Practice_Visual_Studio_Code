import axios from "axios";
import { SignInRequestDto, SignUpRequestDto } from "./dto/request/auth";
import { SignInResponseDto, SignUpResponseDto } from "./dto/response/auth";
import ResponseDto from "./dto/response";
import { GetSignInUserResponseDto, GetUserResponseDto } from "./dto/response/user";

// description : 도메인 URL  //
const DOMAIN = 'http://localhost:4000';
// description : API도메인 주소  //
const API_DOMAIN = `${DOMAIN}/api/v1`;
// description : Authorization Header //
const authorization = (token : string) => {
    return {headers : {Authorization : `Bearer ${token}`}}
};
// description : sign up API end point  //
const SIGN_UP_URL = () => `${API_DOMAIN}/auth/sign-up`;
// description : sign in API point  //
const SIGN_IN_URL = () => `${API_DOMAIN}/auth/sign-in`;

// description : sign up Request //
export const signUpRequest =async (requestbody : SignUpRequestDto) => {
    const result = await axios.post(SIGN_UP_URL(),requestbody)
    .then((response) => {
        const responseBody : SignUpResponseDto = response.data;
        const { code } = responseBody;
        return code;
    })
    .catch(error => {
        const responseBody : ResponseDto = error.response.data;
        const {code} = responseBody;
        return code;
    });
    return result;
};

// description : sign in Request //
export const signInRequest = async(requestbody : SignInRequestDto) => {
    const result = await axios.post(SIGN_IN_URL(), requestbody)
        .then(response => {
            const responseBody : SignInResponseDto = response.data;
            return responseBody;
        })
        .catch( error => {
            const responseBody : ResponseDto = error.response.data;
            return responseBody;
        });
    return result;
};

// description : get sign in user API end point //
const GET_SIGN_IN_USER_URL = () => `${API_DOMAIN}/user`;

//                      description : get user API end point                        //
const GET_USER_URL = (email : String) => `${API_DOMAIN}/user/${email}`;

// description : get sign in request    //
export const getSignInUserRequest = async (token : string) => {
    const result = await axios.get(GET_SIGN_IN_USER_URL(), authorization(token))
        .then(response => {
            const responseBody : GetSignInUserResponseDto = response.data;
            return responseBody;
        })
        .catch (error => {
            const responseBody : ResponseDto = error.response.data;
            return responseBody;
        });
        return result;
};

//                      description : get user request                      //
export const getUserRequest = async (email : string) => {
    const result = await axios.get(GET_USER_URL(email))
        .then(response => {
            const responseBody : GetUserResponseDto = response.data;
            return responseBody;
        })
        .catch( error => {
            const responseBody : ResponseDto = error.response.data;
            return responseBody;
        })
        return result;
};

//                      description : File Domain 주소                        //
const FILE_DOMAIN = `${DOMAIN}/file`;

//                      description : file upload end point                     //
const FILE_UPLOAD_URL = () => `${FILE_DOMAIN}/upload`;

//                      description : file Content type Header                     //
const multipart = {headers : {'Content-Type': 'multipart/form-data'}};

//                      description : file upload request                     //
export const fileUploadRequest = async (data : FormData) => {
    const result = await axios.post(FILE_UPLOAD_URL(), data, multipart )
        .then(response => {
            const responseBody : string = response.data;
            return responseBody;
        })
        .catch (error => {
            return null;
        });
        return result;
}