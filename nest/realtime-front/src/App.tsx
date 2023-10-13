import React, { ChangeEvent, useEffect, useState } from 'react';
import './App.css';
import { socket } from './utils/socket';
import { disconnect } from 'process';
import { Message } from './types';

function App() {

  const [connected, setConnected] = useState<boolean>(false);
  const [room, setRoom] = useState<string>('');
  const [nickname, setNickname] = useState<string>('');
  const [message, setMessage] = useState<string>('');

  const onNicknameChangeHandler = (event : ChangeEvent<HTMLInputElement>) => {
    const value = event.target.value;
    setNickname(value);
  }
  const onMessageHandler = (event : ChangeEvent<HTMLInputElement>) => {
    const value = event.target.value;
    setMessage(value);
  }

  const onRoomChangeHandler = (event : ChangeEvent<HTMLInputElement>) => {
    const value = event.target.value;
    setRoom(value);
  }

  const onJoinButtonHandler = () => {
    socket.emit('join', room);
    setConnected(true);
  }

  const onSubmitButtonHandler =() => {
    const data : Message = {room, nickname, message};
    socket.emit('send', data);
  }

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
    <div>
      {!connected ? (
        <div>
          닉네임 :
          <input value={nickname} onChange={onNicknameChangeHandler}/>
          방이름 :
          <input value={room} onChange={onRoomChangeHandler}/>
          <button onClick={onJoinButtonHandler}>조인</button>
        </div>
      ) : (
        <div>
          <h3>{`방이름 : ${room} / 닉네임 : ${nickname}`}</h3>
          <input value={message} onChange={onMessageHandler}/>
          <button onClick={onSubmitButtonHandler}>전송</button>
        </div>
      )}
    </div>
  );
}

export default App;
