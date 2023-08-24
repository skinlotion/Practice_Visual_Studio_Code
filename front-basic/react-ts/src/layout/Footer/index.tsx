import React from 'react'
import { useGlobalStore } from 'stores'

export default function Footer() {
  const{state1, setState1} = useGlobalStore();

  return (
    <div style={ { height : '200px', backgroundColor : 'rgba(0,0,255,0.5)'} }>Footer
      <h5>{state1}</h5>
      <button onClick={() => setState1(state1 +1)}>증가</button>
    </div>
  )
}
