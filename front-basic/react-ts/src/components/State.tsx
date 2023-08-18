import {useEffect, useState} from 'react'

//! state : 컴포넌트가 관리하는 데이터
//! 컴포넌트의 랜더링에 영향을 미침
//! state가 변경되면 리랜더링 됨

//! const [상태명, 상태변경함수] = useState<타입>(초기값);
//! 상태 변경은 반드시 상태변경함수를 통해서 변경을 해야함

//! useState를 사용한 상태 선언은 반드시 함수형 컴포넌트 자식수준에서 선언되어야 한다. 
// ex) 함수형 컴포넌트 수준에서 선언이 되어야 한다.
// export function State() {!이 안에 선언되어야 함}  (O)
// export function State() { 함수 {선언X} }  (X)

export function State() {
    const [count, setCount] = useState<number>(0);
    const[object, setObject] = useState<Name>({name : '홍길동'});

    // let count = 0;

    interface Name{
        name : string;
    }
    
    const onClickHandler1 = () => {
        //! 상태변경함수를 사용하여 상태를 변경했다고 해서 그 즉시 상태가 변경되는 것이 아니라
        //! 해당 함수가 모두 종료되고 변경된다.
        setCount(count+1);
        // alert(count);
    }

    const onClickHandler2 = () => {
        //! object 타입으로 되어있는 상태는 그 상태의 속성 값만 변경했다고 해서 랜더링이 다시 되지 않는다
        //! 새로운 객체로 상태가 변해야 랜더링이 다시 됨 => (주소값이 변하는게 아니기 때문!!)
        // 객체 타입은 주소값이 바꿔야함!
        const newObject = {
            name : '길철수'
        };
        setObject(newObject);
    }

    //! 라이프 사이클 (클래스 컴포넌트 기준)
    //! 마운팅 단계
    useEffect(
        () => {console.log('effect 동작!');},
        [] 
    );

    //! 업데이트 단계
    useEffect(
        () => {console.log('count state 변경!');},
        [count]
    );

    //! 언마운팅 단계

    useEffect (
        () =>{ 
        {console.log('컴포넌트 언마운트!');}
    },
    []
    );



    return (
    <div>
    <h1 onClick={onClickHandler1}>{count}</h1>
    <h1 onClick={onClickHandler2}>{object.name}</h1>  
    </div>
   
  )
}
