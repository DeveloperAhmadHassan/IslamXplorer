import { IconButton } from '@mui/material';
import React, { useState, useEffect } from 'react';

import MicNoneIcon from '@mui/icons-material/MicNone';

const SpeechToText = (props) => {
  const [text, setText] = useState('');
  const [listening, setListening] = useState(false);
  const [recognition, setRecognition] = useState(null);

  useEffect(() => {
    // Check if the browser supports the Web Speech API
    if ('SpeechRecognition' in window || 'webkitSpeechRecognition' in window) {
      const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
      const recognizer = new SpeechRecognition();
      recognizer.lang = 'ur-PK'; // Set the language to Urdu
      recognizer.continuous = false; // Stop automatically after recognition
      recognizer.interimResults = false; // Do not return interim results

      recognizer.onstart = () => {
        setListening(true);
      };

      recognizer.onresult = (event) => {
        const transcript = event.results[0][0].transcript;
        setText(transcript);
        setListening(false);
        props.setText(transcript);
        props.setMic(false);
      };

      recognizer.onerror = (event) => {
        console.error('Error occurred in recognition:', event.error);
        setListening(false);
      };

      recognizer.onend = () => {
        setListening(false);
      };

      setRecognition(recognizer);
      
      // Start listening as soon as the component mounts
      recognizer.start();
    } else {
      console.error('Web Speech API is not supported in this browser.');
    }
  }, []);

  return (
    <div>
      <div className={`mic-icon ${listening ? "ripple": ""}`}>
        <IconButton onClick={() => recognition && recognition.start()} disabled={listening}>
          <MicNoneIcon fontSize='large'/>
        </IconButton>
      </div>
      <p className='mic-text'>{listening ? 'Listening...' : 'Please Try Again'}</p>
      <p>{text}</p>
    </div>
  );
};

export default SpeechToText;
