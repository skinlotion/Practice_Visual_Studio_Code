import React from 'react'

interface Props{
    title : string;
    content : string;
}
//! 컴포넌트
//! - UI를 독립적이고 재사용 가능한 부분으로 나눈 요소
//! - 클래스형 컴포넌트, 함수형 컴포넌트 *클래스형은 현재 사용 안함
//! - 함수형 컴포넌트에서 반환 값을 하나의 XML요소로 반환 함
//! - 반환을 render 한다고 함
//! - return에 작성된 XML에서 스크립트를 사용하기 위해선{}로 묶어서 작성해야함
//! - retuen 위치에서는 선언을 할 수 없음.

//! Properties(Props) : 컴포넌트에 전달되는 매개변수 객체, 반드시 객체로 전달받아야함
//! Properties는 호출부에서 <컴포넌트명 속성명 = 값 .../> 형태로 전달해야함

export default function Component({title, content} : Props) {
  return (
    <div>
        <h2>{title}</h2>
        <p>{content}</p>
    </div>
  )
}


