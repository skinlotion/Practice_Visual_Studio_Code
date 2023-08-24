import React from 'react'
import Header from '../../layout/Header'
import Footer from 'layout/Footer';
import { useGlobalStore } from 'stores';

interface Props {
  setPage : any
}


export default function Main({setPage} : Props) {

  const {state1} = useGlobalStore ();

  const onClickHandler = () => {
    setPage('sub');
  }

  return (
        <div onClick={onClickHandler} style={{height : '600px', backgroundColor : 'rgba(255,0,255,0.5)'}}>Main
        {state1}
        </div>
  )
}
