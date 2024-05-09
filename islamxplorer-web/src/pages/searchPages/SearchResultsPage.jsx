import * as React from 'react';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Box from '@mui/material/Box';
import { createTheme, ThemeProvider, styled } from '@mui/material/styles';
import { Card, CardActionArea, CardContent, Container, Typography } from '@mui/material';
import useResults from '../../hooks/UseResults';
import { Loader } from '../../components/items/loader/Loader';
import { Error } from '../../components/items/error/Error';
import { MainSearchBar } from './MainSearchBar';
import { useNavigate } from 'react-router-dom';

const Item = styled(Paper)(({ theme }) => ({
  ...theme.typography.body2,
  textAlign: 'center',
  color: theme.palette.text.secondary,
  height: 60,
  lineHeight: '60px',
}));

const darkTheme = createTheme({ palette: { mode: 'dark' } });
const lightTheme = createTheme({ palette: { mode: 'light' } });

export default function SearchResultsPage(props) {
  console.log(props.query);
  const {results, isLoadingResults, error} = useResults(props.query); 
  const navigate = useNavigate();

  const handleItemClick = (e, type, id) =>{
    e.preventDefault();
    navigate(`/search/item/${type}/${id}`);
  };

  return (
    <div id='search-results-div'>
    
      {isLoadingResults ? <Loader /> : error ? <Error /> : <>
        <Container id='bg-container'>
          <Paper id='search-paper' elevation={0}>
            <MainSearchBar logo={false}/>
          </Paper>
        </Container>
        <Box
                id={'search-results-box'}
                sx={{
                  marginTop:5,
                  marginBottom:5,
                  display: 'grid',
                  gridTemplateColumns: { md: '1fr' },
                  gap: 2,
                  alignContent: 'center',
                  textAlign:'center',
                  justifyContent: 'center',
                }}
              >
                {results.map((item, index, array) => (
                  <Item key={index} elevation={6} className={'item'} onClick={(event)=>handleItemClick(event, item.type, item.id)}>
                    <Card className={'card'}>
                      <CardActionArea>
                        <CardContent className={'item-content'}>
                        <div>{item.id}</div>
                        <div className={'data'}>
                          <div>{item.arabicText}</div>
                          <Typography variant="subtitle1" component="p" gutterBottom>
                            {item.englishText}
                          </Typography>
                        </div>
                        </CardContent>
                      </CardActionArea>
                    </Card>
                  </Item>
                  
                ))}
        </Box>
      </> }
    </div>
  );
}