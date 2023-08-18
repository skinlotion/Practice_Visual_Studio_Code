import React from 'react';
import './App.css';
import Typescript from './Typescript';
import Component from './components/Component';
import { State } from './components/State';

function App() {
  return (
    <div>
      <State/>

      {/* {mock.map(item => (<Component title={item.title} content={item.content} />))}
      {/* if표현 */}
      {/* { true && (<h1>true</h1>) } */}
      {/* if else 표현 */}
      {/* { true ? (<h1>true</h1>) : (<h1>false</h1>) } */}
    </div>
  );
}

export default App;

const mock = [
  {
    title : '1번째 제목',
    content : '안녕하세요. 반갑습니다.'
  },
  {
    title : '2번째 제목',
    content : '안녕하세요. 반갑습니다.'
  },
  {
    title : '3번째 제목',
    content : '안녕하세요. 반갑습니다.'
  },
];
