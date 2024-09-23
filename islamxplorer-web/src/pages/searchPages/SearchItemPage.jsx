import React, { useEffect, useState } from 'react';
import { Avatar, Typography, Container, Grid, Paper, Button, Snackbar, Alert, Slide, Card, CardActionArea, CardContent, styled, Tooltip, IconButton } from '@mui/material';

import './styles.scss';
import { useNavigate, useParams } from 'react-router-dom';
import useHadithOrVerse from '../../hooks/useHadithOrVerse';
import { Loader } from '../../components/items/loader/Loader';
import { Error } from '../../components/items/error/Error';

import ReactAudioPlayer from 'react-audio-player';
import 'react-h5-audio-player/lib/styles.css';
import Marquee from "react-fast-marquee";

import VolumeUpIcon from '@mui/icons-material/VolumeUp';
import EditIcon from '@mui/icons-material/Edit';
import ContentCopyIcon from '@mui/icons-material/ContentCopy';
import CheckIcon from '@mui/icons-material/Check';
import GoogleIcon from '@mui/icons-material/Google';


import { useSnackbar } from 'notistack';
import useHadithRelations from '../../hooks/UseHadithRelations';

export const SearchItemPage = () => {
  const params = useParams();
  const idExists = params.id;
  const typeExists = params.type;

  const navigate = useNavigate();
  const { enqueueSnackbar } = useSnackbar();

  const [audioOpen, setAudioOpen] = useState(false);

  const [arabicTextTitle, setArabicTextTitle] = useState({
    flag:false,
    title:"Show Simple Text"
  });

  const [copy, setCopy] = useState(true);
  
  const {item, isLoadingItem, error} = useHadithOrVerse(typeExists, idExists); 
  const {items, isLoadingItems} = useHadithRelations(idExists); 


  const Item = styled(Paper)(({ theme }) => ({
    ...theme.typography.body2,
    textAlign: 'center',
    color: theme.palette.text.secondary,
    height: 60,
    lineHeight: '60px',
  }));

  const handleItemClick = (e, type, id, link) =>{
    e.preventDefault();
    if (type === 'google') {
        window.open(link, '_blank');
    } else {
        navigate(`/search/item/${type}/${id}`);
    }
  };

  const onAudioBtnClick = () =>{
    if(audioOpen) {
      setAudioOpen(false);
    } else {
      setAudioOpen(true);
    }
  }

  const onTextBtnClick = () =>{
    if(!arabicTextTitle.flag) {
      setArabicTextTitle({
        flag:true,
        title:"Show Uthmani Text"
      })
    } else {
      setArabicTextTitle({
        flag:false,
        title:"Show Simple Text"
      });
    }
  }
  const copyToClipboard = (content) =>{
    const textarea = document.createElement('textarea');
    textarea.value = content;
    textarea.style.position = 'fixed';
    textarea.style.opacity = 0;
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand('copy');
    document.body.removeChild(textarea);

    enqueueSnackbar('Copied to Clipboard');
    setCopy(false);
  }

  return (
    isLoadingItem ? <Loader /> : error ? <Error /> : <>
    <Container id='search-item-container'>
      <Paper id='search-item-paper'>
        <Paper id='source-name' elevation={0}>
          <Typography variant='h4'>
            {typeExists === "verse" ? "Surah" : ""} {item.source}
          </Typography>
        </Paper>
      </Paper>
    </Container>

    <Container sx={{marginTop:10}}>

      <Container id='search-item-content'>
      {item.type === 'verse' ?<Marquee>
        <div className={'extra'}>Source: The Clear Quran</div>
        <div className={'extra'}>Surah Number: 4{item.verseNumber}</div>
        <div className={'extra'}>Verse Number: 2{item.verseNumber}</div>
        <div className={'extra'}>Page Number: 7{item.verseNumber}</div>
        <div className={'extra'}>Juz Number:4 {item.verseNumber}</div>
      </Marquee> : <></> }
        <Paper elevation={0} className={'paper arabic-text-cont'}>
          <div className={'side-btns'}>
            {
              item.type === 'verse' ? 
              <Tooltip title="Play Audio" arrow>
                <IconButton className={"audio-btn"} onClick={()=>onAudioBtnClick()}>
                  <VolumeUpIcon className={"icon"}/>
                </IconButton>
              </Tooltip> : <></>
            }
            {
              item.type === 'verse' ?
              <Tooltip title={arabicTextTitle.title} arrow>
                <IconButton className={"audio-btn"} onClick={()=>onTextBtnClick()}>
                  <EditIcon className={"icon"}/>
                </IconButton>
              </Tooltip> : <></>
            }
            <Tooltip title="Copy to Clipboard" arrow>
              <IconButton className={"audio-btn"} onClick={()=>copyToClipboard(!arabicTextTitle.flag ? item.arabicText : item.simpleText)}>
                {copy ? <ContentCopyIcon className={"icon"}/> : <CheckIcon />}
              </IconButton>
            </Tooltip>
          </div>
          <Typography variant='body1' className={'arabic-text'}>
            {!arabicTextTitle.flag ? item.arabicText : item.simpleText}
          </Typography>
          {audioOpen && <audio controls className={'audio-player'}>
            {console.log(item.audioLink)}
            <source src={item.audioLink} type="audio/mpeg" />
            Your browser does not support the audio element.
          </audio>}
        </Paper>
        <Container className={'spacer'}></Container>
        <Paper elevation={0} className={'paper'}>
          <Typography variant='body1' className={'english-text'}>
            {item.englishText}
          </Typography>
        </Paper>
      </Container>

      <Container className={'spacer'}></Container>

      

      {isLoadingItems ? <Loader /> : items.length > 0 && 
      <><Typography variant="h4" gutterBottom>
        Also See
      </Typography>
      <Container id='related-content'>
        {items.map((item, index, array) => (
                  <Item key={index} elevation={6} className={'item'} onClick={(event)=>handleItemClick(event, item.type, item.id, item.subtitle)}>
                    <Tooltip title={item.type === 'google' ? "Click to Open in New Tab" : ""} arrow>
                      <Card className={'card'}>
                        <CardActionArea>
                          <CardContent className={'item-content'}>
                          <div>{item.type === 'google' ? <GoogleIcon /> : item.id}</div>
                          <div className={'data'}>
                            <Typography variant="subtitle1" component={"p"} gutterBottom className={'res-text'}>
                              {item.title}
                            </Typography>
                            <Typography variant="subtitle2" component={item.type ==='google' ? "a" : "p"} className={item.type ==='google' ? " res-text link" : "res-text"} gutterBottom>
                              {item.subtitle}
                            </Typography>
                          </div>
                          </CardContent>
                        </CardActionArea>
                      </Card>
                    </Tooltip>
                  </Item>
                  
                ))}

      </Container></>}

      <Container className={'spacer'}></Container>
    </Container>
  </>
  );
};
