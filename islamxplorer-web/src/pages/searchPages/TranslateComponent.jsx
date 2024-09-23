import React, { useState } from 'react';
import useTranslate from '../../hooks/useTranslate';

const TranslateComponent = (props) => {
  const [text, setText] = useState(props.text);
  const { translatedText, error } = useTranslate(text);

  const handleTextChange = (e) => {
    setText(e.target.value);
  };

  return (
    <>{console.log(props.text)} {console.log(translatedText)}</>

  );
};

export default TranslateComponent;
