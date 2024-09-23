import * as React from 'react';
import Grid from '@mui/material/Grid';
import Paper from '@mui/material/Paper';
import Box from '@mui/material/Box';
import { createTheme, ThemeProvider, styled } from '@mui/material/styles';
import { Card, CardActionArea, CardContent, Container, Tooltip, Typography } from '@mui/material';
import useResults from '../../hooks/UseResults';
import { Loader } from '../../components/items/loader/Loader';
import { Error } from '../../components/items/error/Error';
import { MainSearchBar } from './MainSearchBar';
import { useNavigate } from 'react-router-dom';
import GoogleIcon from '@mui/icons-material/Google';
import useTranslate from '../../hooks/useTranslate';
import TranslateComponent from './TranslateComponent';

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

  const {results, metaData, isLoadingResults, error} = useResults(props.query); 
  const navigate = useNavigate();

  const handleItemClick = (e, type, id, link) =>{
    e.preventDefault();
    if (type === 'google') {
        window.open(link, '_blank');
    } else {
        navigate(`/search/item/${type}/${id}`);
    }
  };

  return (
    <div id='search-results-div'>    
      {isLoadingResults ? <Loader /> : error ? <Error /> : <>
        <Container id='bg-container'>
          <Paper id='search-paper' elevation={0}>
            <MainSearchBar logo={false} query={props.query}/>
          </Paper>
        </Container>
        {console.log(metaData.cipher)}
        <p className={'result-meta'}>
          The generated 
          <Tooltip title={metaData.cipher} arrow className={'cipher-text'}>
            <div> Cipher Query </div> 
          </Tooltip>
          has returned {metaData.total} results in {metaData.timeTaken} seconds
        </p>
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
        </Box>
      </> }
    </div>
  );
}