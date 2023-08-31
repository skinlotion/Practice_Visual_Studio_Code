import { useState, KeyboardEvent, useRef } from 'react';
import './style.css';
import InputBox from 'components/InputBox';
import { useCookies } from 'react-cookie';
import { useUserStore } from 'stores';
import { LoginUser } from 'types';
import { useNavigate } from 'react-router-dom';
import { MAIN_PATH } from 'constant';
import { loginInfoMock } from 'mocks';

//          component: 인증 페이지          //
export default function Authentication() {
  
  //          state: 로그인 유저 전역 상태          //
  const {user, setUser} = useUserStore();
  //          state: 쿠키 상태          //
  const [cookies, setCookie] = useCookies();
  //          state: 화면 상태          //
  const [view, setView] = useState<'sign-in' | 'sign-up'>('sign-in');

  //        function : 네비게이트 함수 
  const navigator = useNavigate();

  //          component: sign in 카드 컴포넌트          //
  const SignInCard = () => {

    //          state: 미빌번호 입력 요소 참조 상태         /
    const passwordRef = useRef<HTMLInputElement | null> (null); 
    //          state: 입력한 이메일 상태          //
    const [email, setEmail] = useState<string>('');
    //          state: 입력한 비밀번호 상태          //
    const [password, setPassword] = useState<string>('');
    //          state: 비밀번호 인풋 타입 상태          //
    const [passwordType, setPasswordType] = useState<'text' | 'password'>('password');
    //          state: 비밀번호 인풋 버튼 아이콘 상태          //
    const [passwordIcon, setPasswordIcon] = useState<'eye-off-icon' | 'eye-on-icon'>('eye-off-icon');
    //          state: 로그인 에러 상태          //
    const [error, setError] = useState<boolean>(false);

     //         event handler: 이메일 인풋 Key down 이벤트 처리          //
     const onEmailKeyDownHandler = (event : KeyboardEvent<HTMLInputElement>) => {
      if (event.key !== 'Enter') return;
      if(!passwordRef.current) return;
      passwordRef.current.focus();
    }
    
    //         event handler: 비밀번호 인풋 Key down 이벤트 처리          //
    const onPasswordKeyDownHandler = (event : KeyboardEvent<HTMLInputElement>) => {
      if (event.key !== 'Enter') return;
      onSignInbuttonClickHandler();
    }


    //         event handler: 비밀번호 인풋 버튼 클릭 이벤트 처리          //
    const onPasswordIconClickHandler = () => {
      if (passwordType === 'text') {
        setPasswordType('password');
        setPasswordIcon('eye-off-icon');
      }
      if (passwordType === 'password') {
        setPasswordType('text');
        setPasswordIcon('eye-on-icon');
      }
    }

    //         event handler: 로그인 버튼 클릭 이벤트 처리          /
    const onSignInbuttonClickHandler = () => {
      // TODO : 로그인처리 API 연결
      const isSucess = email === loginInfoMock.email && password === loginInfoMock.password;
      if (!isSucess) {
        setError(true);
        return;
      }
      console.log(email);
      setCookie('email', email, {path : '/'});

      const user : LoginUser = {email, nickname : '주코야키', profileImage : null};
      setUser(user);
      navigator(MAIN_PATH);
    }
     
    //         event handler: 회원가입 링크 클릭 이벤트 처리          /
    const onSignUpLinkClickHandler = () => {
      setView ('sign-up');
    }
  
    //          render: sign in 카드 컴포넌트 랜더링         //
    return (
      <div className='auth-card'>
        <div className='auth-card-top'>
          <div className='auth-card-title-box'>
            <div className='auth-card-title'>{'로그인'}</div>
          </div>
          <InputBox label='이메일 주소' type='text' placeholder='이메일 주소를 입력해주세요.' error={error} value={email} setValue={setEmail} onKeyDown={onEmailKeyDownHandler} />
          <InputBox ref ={passwordRef} label='비밀번호' type={passwordType} placeholder='비밀번호를 입력해주세요.' error={error} value={password} setValue={setPassword} icon={passwordIcon} onKeyDown={onPasswordKeyDownHandler} onButtonClick={onPasswordIconClickHandler} />
        </div>
        <div className='auth-card-bottom'>
          { error && (
            <div className='auth-sign-in-error-box'>
            <div className='auth-sign-in-error-message'>
              {'이메일 주소 또는 비밀번호를 잘못 입력했습니다.\n입력하신 내용을 다시 확인해주세요.'}
            </div>
          </div>
          )}
          <div className='auth-button' onClick={onSignInbuttonClickHandler}>{'로그인'}</div>
          <div className='auth-description-box'>
            <div className='auth-description'>{'신규 사용자이신가요? '}<span className='description-emphasis' onClick={onSignUpLinkClickHandler}>{'회원가입'}</span></div>
          </div>
        </div>
      </div>
    );
  }
  
  //          component: sign up 카드 컴포넌트          //
  const SignUpCard = () => {
    return (<></>)
  }
  
  //          render: 인증 페이지 렌더링         //
  return (
    <div id='auth-wrapper'> 
      <div className='auth-container'>
        <div className='auth-jumbotron-box'>
          <div className='auth-jumbotron-contents'>
            <div className='jumbotron-icon'></div>
            <div className='auth-jumbotron-text-box'>
              <div className='auth-jumbotron-text'>{'환영합니다.'}</div>
              <div className='auth-jumbotron-text'>{'HOONS BOARD 입니다.'}</div>
            </div>
          </div>
        </div>
        { view === 'sign-in' && <SignInCard /> }
        { view === 'sign-up' && <SignUpCard /> }
      </div>
    </div>
  );
  
}
