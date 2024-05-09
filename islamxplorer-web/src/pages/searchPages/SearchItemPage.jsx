import React, { useEffect, useState } from 'react';
import { Avatar, Typography, Container, Grid, Paper, Button, Snackbar, Alert, Slide, Card, CardActionArea, CardContent, styled } from '@mui/material';

import './styles.scss';
import { useParams } from 'react-router-dom';
import useHadithOrVerse from '../../hooks/useHadithOrVerse';
import { Loader } from '../../components/items/loader/Loader';
import { Error } from '../../components/items/error/Error';

export const SearchItemPage = () => {
  const params = useParams();
  const idExists = params.id;
  const typeExists = params.type;

  console.log(idExists);
  console.log(typeExists);

  const {item, isLoadingItem, error} = useHadithOrVerse(typeExists, idExists); 


  const Item = styled(Paper)(({ theme }) => ({
    ...theme.typography.body2,
    textAlign: 'center',
    color: theme.palette.text.secondary,
    height: 60,
    lineHeight: '60px',
  }));

  return (
    isLoadingItem ? <Loader /> : error ? <Error /> : <>
    <Container id='search-item-container'>
      <Paper id='search-item-paper'>
        <Paper id='source-name' elevation={0}>
          <Typography variant='h4'>
            {typeExists === "Verse" ? "Surah" : ""} {item.source}
          </Typography>
        </Paper>
      </Paper>
    </Container>

    <Container sx={{marginTop:10}}>

      <Container id='search-item-content'>
        <Paper elevation={0}className={'paper'}>
          <Typography variant='body1' className={'arabic-text'}>
            {item.arabicText}
          </Typography>
        </Paper>
        <Container className={'spacer'}></Container>
        <Paper elevation={0} className={'paper'}>
          <Typography variant='body1' className={'english-text'}>
            {item.englishText}
          </Typography>
        </Paper>
      </Container>

      <Container className={'spacer'}></Container>

      <Typography variant="h4" gutterBottom>
        Also See
      </Typography>

      <Container id='related-content'>
        <Item className={'item'}>
          <Card className={'card'}>
            <CardActionArea>
              <CardContent className={'item-content'}>
              <div>5:78</div>
              <div className={'data'}>
                <div>وَإِذْ يَعِدُكُمُ ٱللَّهُ إِحْدَى ٱلطَّآئِفَتَيْنِ أَنَّهَا لَكُمْ وَتَوَدُّونَ أَنَّ غَيْرَ ذَاتِ ٱلشَّوْكَةِ تَكُونُ لَكُمْ وَيُرِيدُ ٱللَّهُ أَن يُحِقَّ ٱلْحَقَّ بِكَلِمَـٰتِهِۦ وَيَقْطَعَ دَابِرَ ٱلْكَـٰفِرِينَ ٧</div>
                <Typography variant="subtitle1" component="p" gutterBottom>
                ˹Remember, O  believers,˺ when Allah promised ˹to give˺ you the upper hand over either target, you wished to capture the unarmed party.1 But it was Allah’s Will to establish the truth by His Words and uproot the disbelievers;
                </Typography>
              </div>
              </CardContent>
            </CardActionArea>
          </Card>
        </Item>

      </Container>

      <Container className={'spacer'}></Container>

    </Container>
  </>
  );
};
