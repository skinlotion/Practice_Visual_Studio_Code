import React from 'react'
import { useParams } from 'react-router-dom'

export default function Search() {
  
    const { word } = useParams();

    return (
    <div style={{height : '300px', backgroundColor : 'rgba(0,0,0,0.5)', color : 'white'}}>
        검색한 검색어는 '{word}'
    </div>
  )
}
