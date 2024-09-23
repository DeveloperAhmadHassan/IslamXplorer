import * as React from 'react';
import Paper from '@mui/material/Paper';
import InputBase from '@mui/material/InputBase';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import SearchIcon from '@mui/icons-material/Search';
import MicNoneIcon from '@mui/icons-material/MicNone';
import DirectionsIcon from '@mui/icons-material/Directions';
import { Link, useNavigate } from 'react-router-dom';
import { Tooltip } from '@mui/material';

import { PrimaryLogo } from '../../components/items/logos/primaryLogo';
import { MainLogo } from '../../components/items/logos/mainLogo';

import './styles.scss';
import SpeechToText from '../../components/webSpeechAPI/speechToText';

export const MainSearchBar = (props) => {
  const [searchValue, setSearchValue] = React.useState(props.query);
  const [useMic, setUseMic] = React.useState(false);
  const navigate = useNavigate(); 

  const handleInputChange = (event) => {
    setSearchValue(event.target.value);
  };

  const searchQuery = (e) => {
    const currentRoute = window.location.pathname;

    const searchRoute = `/search/${searchValue}`;
  
    if (currentRoute === '/search/') {
      window.location.reload();
      // console.log(reload);
    } else {
      navigate(searchRoute);
      window.location.reload();
    }
  };

  const toggleMic = (event) => {
    setUseMic(!useMic);
  }

  return (
    useMic ? <SpeechToText setText={setSearchValue} setMic={setUseMic}/> : <div id='search-div'>
    {props.logo ? <MainLogo />: <></>}
    <Paper
      component="form"
      className={'search-bar'}
    >
    <IconButton aria-label="menu" className='btn'>
      <PrimaryLogo />
    </IconButton>
    {console.log(props.query)}
    <InputBase
      sx={{ ml: 1, flex: 1 }}
      placeholder="Search IslamXplorer"
      inputProps={{ 'aria-label': 'search islamxplorer' }}
      value={searchValue}
      onChange={handleInputChange}
      onKeyDown={(event) => {
        if (event.key === 'Enter') {
          event.preventDefault(); 
          searchQuery(event);
        }
      }}
    />
    <Tooltip title={"Use Microphone"} arrow>
      <IconButton type="button" sx={{ p: '10px' }} aria-label="use-mic" onClick={(event)=>toggleMic(event)}>
        <MicNoneIcon />
      </IconButton>
    </Tooltip>
    <Tooltip title={"Search Text"} arrow>
      <IconButton type="button" sx={{ p: '10px' }} aria-label="search" onClick={(event)=>searchQuery(event)}>
        <SearchIcon />
      </IconButton>
    </Tooltip>
    </Paper>
    </div>
  );
}
