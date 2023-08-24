import React, { useState,KeyboardEvent, useRef } from 'react'
import { Link, Route, useNavigate } from 'react-router-dom'

export default function Header() {

  const[inputValue, setInputValue] = useState<string>('');
  
  const searchButtonRef = useRef<HTMLButtonElement | null>(null);

  const navigator = useNavigate();

  const onEnterHandler = (event : KeyboardEvent<HTMLInputElement>) => {
    if (event.key !== 'Enter') return;
    // navigator(`/search/${inputValue}`);
    if (!searchButtonRef.current) return;
    searchButtonRef.current.click();
  }


  return (
    <div style={ { height : '200px', backgroundColor : 'rgba(255,0,0,0.5)'} }>
      <button onClick={() => navigator('/')}>Root</button>
      <button onClick={() => navigator('/main')}>Main</button>
      <button onClick={() => navigator('/sub')}>Sub</button>
      <br/>
      <Link to='/'>Link Root</Link>
      <Link to='/main'>Link Main</Link>
      <Link to='/sub'>Link Sub</Link>
      <br/>
      <input
      onChange={(event) => setInputValue(event.target.value)}
      onKeyDown={onEnterHandler}  
      />
      <button ref={searchButtonRef} onClick={() => navigator(`/search/${inputValue}`)}>search</button>
      {inputValue}
    </div>
  )
}