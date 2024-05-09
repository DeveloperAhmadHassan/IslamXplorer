import * as React from 'react';
import Paper from '@mui/material/Paper';
import InputBase from '@mui/material/InputBase';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import SearchIcon from '@mui/icons-material/Search';
import DirectionsIcon from '@mui/icons-material/Directions';
import { Link } from 'react-router-dom';
import { Tooltip } from '@mui/material';

import { PrimaryLogo } from '../components/items/logos/primaryLogo';
import { MainLogo } from '../components/items/logos/mainLogo';

export const Contact = () => {
  function goToHome(e){
    e.preventDefault();
    
  }
  return (
    <>
      <MainLogo />
      <Paper
      component="form"
      className={'search-bar'}
    >
      <Link to={'/'}>
        <IconButton aria-label="menu">
          <PrimaryLogo />
        </IconButton>
      </Link>
      <InputBase
        sx={{ ml: 1, flex: 1 }}
        placeholder="Search IslamXplorer"
        inputProps={{ 'aria-label': 'search google maps' }}
      />
      <Tooltip title={"Search Text"} arrow>
        <IconButton type="button" sx={{ p: '10px' }} aria-label="search">
          <SearchIcon />
        </IconButton>
      </Tooltip>
      </Paper>
    </>
  );
}
