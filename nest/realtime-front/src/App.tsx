import React, { useEffect } from 'react';
import './App.css';
import { socket } from './utils/socket';
import { disconnect } from 'process';

function App() {
  let effectFlag = true;
  useEffect(()=> {
    
    if(effectFlag) {
      effectFlag = false;
      return;
    }

    const onConnect = () => {
      console.log(socket.id + ' Socket Connected!');
    }

    const onDisconnect = () => {
      console.log('Socket disconnected!');
    }

    socket.on('connect', onConnect);
    socket.on('disconnect', onDisconnect);

  },[]);

  return (
    <div></div>
  );
}

export default App;
