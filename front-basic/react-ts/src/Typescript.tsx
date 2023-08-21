import { type } from 'os';
import React from 'react'

export default function Typescript() {

    //! 변수 (타입스크립트랑 거의 같음)
    //! 변수의 타입을 지정하지 않으면 처음 초기화된 데이터의 타입으로 변수의 타입이 결정
    
    let variable1 = '문자열';
    // variable1 = 10; (타입스크립트 이기 때문에 변수 타입이 있다! '문자열'이라고 지정이 되어있어서 정수 선언이 안됨)

    // ! 키워드 변수명 : 데이터 타입; 변수를 선언
    let variable2 : string;
    variable2 = '가나다' //(이렇게도 됨)

    //! 변수 타입 종류
    // 1) string (문자열), 2) number(숫자), 3) boolean (논리형)
    // 4) object (객체)
    let variable3 : object = {
        name : '홍길동',
        age : 30
    };

    // 5) null 타입 (null을 타입으로 정하고 지정해줘야함) (독립적으로 사용 안됨)
    let variable4 : null = null;

    // 6) (요소타입)[] : 배열 타입 -> 배열안의 요소의 타입을 지정해줘야함
    let variable5 : string[] = ['a', 'b'];

    // 7) undefined : 선언되고 초기화하지 않은 상태 (독립적으로 사용 안됨)
    let variable6 : undefined = undefined; 

    // 8) any : 모든 타입을 나타내는 타입 (위에꺼 다 넣을 수 있음)
    let variable7 : any = 1;


    // 9) | : 유니온 타입 (or연산자) 하나의 변수에 여러개의 타입을 지정할 수 있다.
    let variable8 : string | null; //문자와 숫자 두개 다 받을 수 있다 / 배열은 못옴
 
    //! 10) 커스텀 객체 타입 설정해주는 법
    // 1. class
    // 2. interface
    interface Object2 {
        name : string;
        age : number;
    }
    // 3. type
    type object3 = {
        name : string,
        age : number;
    }

    class Object1 {
        name : string;
        age : number;

        constructor(name : string, age : number) {
            this.name = name;
            this.age = age;
        }
    }

    let object2 : Object1 = {
        name : '김길동',
        age : 30 
    };
    
    interface Object4 {
        telNumber : string;
        address? : string;
    }

    const object3 : Object2 & Object4 = {
        name : '김길동',
        age : 30 ,
        telNumber : '1234',
        // address : 'wqe' 이게 없게 끔 할려면 Object4에서 address 뒤에 ? 붙힘 (필수가 아니다 표시!)
    };

    //! 리터럴 타입 : 리터럴 자체를 타입으로 명시 - 지정된 리터럴 값만 가질 수 있음.
    type Gender = '남' | '여';
    let gender : Gender = '남';     // '남' , '여'  말고 다른 타입이 되면 오류 뜸

    //!  객체의 요소 뽑아 오는 법
    // const name = object3.name;
    // const age = object3.age;
    // const telNumber = object3.telNumber;

    const { name, age, ...other } = object3;

    // other : {
    //     telNumber : '1234',
    //     address : 'wqe'
    // }

    let object4 : any;

    object4 = {other, birth : '1993'}
    object4 = {...other, birth : '1993'}
    
    //! 함수를 지정하는 방법
    function fun1() : string{
        return 'a';
    }

    let func2 : () => string = (): string => {
        return 'a';
    }
    // ! 스프레드 
    const array = [1, 2, 3, 4];
    const [first, second, ...others] = array;

    object2.name;
    

  return (
    <div>{name}</div>
  )
}
