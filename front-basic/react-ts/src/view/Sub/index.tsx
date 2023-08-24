import React from 'react'
import { useGlobalStore } from 'stores'

export default function Sub() {
  const {state1} = useGlobalStore();

  return (
        <div style={{height : '600px', backgroundColor : 'rgba(0,255,0,0.5)'}}>Sub
          {state1}
        </div>
  )
}

