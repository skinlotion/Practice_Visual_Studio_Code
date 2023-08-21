import React, { useState } from 'react';
import {Route, Routes, useLocation} from 'react-router-dom';

import './App.css';
import Main from './view/Main';
import Sub from './view/Sub';
import Header from 'layout/Header';
import Footer from 'layout/Footer';



function App() {

  const [page, setPage] = useState <'main' | 'sub'>('main');
  const { pathname } = useLocation();

  return (
    <>
      <Header />
      <h1> {pathname} </h1>
      <Routes>
        <Route path='/main' element = {<Main setPage={setPage}/>} />
        <Route path='/sub' element = {<Sub/>} />
      </Routes>
      <Footer />
    </>
  );
}

export default App;


