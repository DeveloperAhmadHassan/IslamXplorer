import * as React from 'react';
import Paper from '@mui/material/Paper';
import InputBase from '@mui/material/InputBase';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import SearchIcon from '@mui/icons-material/Search';
import DirectionsIcon from '@mui/icons-material/Directions';
import { Link, useNavigate } from 'react-router-dom';
import { Tooltip } from '@mui/material';

import { PrimaryLogo } from '../../components/items/logos/primaryLogo';
import { MainLogo } from '../../components/items/logos/mainLogo';

import './styles.scss';

export const MainSearchBar = (props) => {
  const [searchValue, setSearchValue] = React.useState('');
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


  return (
    <div id='search-div'>
      {props.logo ? <MainLogo />: <></>}
      <Paper
        component="form"
        className={'search-bar'}
      >
      <IconButton aria-label="menu" className='btn'>
        <PrimaryLogo />
      </IconButton>
      <InputBase
        sx={{ ml: 1, flex: 1 }}
        placeholder="Search IslamXplorer"
        inputProps={{ 'aria-label': 'search google maps' }}
        value={searchValue}
        onChange={handleInputChange}
        onKeyDown={(event) => {
          if (event.key === 'Enter') {
            event.preventDefault(); // Prevent form submission
            searchQuery(event);
          }
        }}
      />
      <Tooltip title={"Search Text"} arrow>
        <IconButton type="button" sx={{ p: '10px' }} aria-label="search" onClick={(event)=>searchQuery(event)}>
          <SearchIcon />
        </IconButton>
      </Tooltip>
      </Paper>
    </div>
  );
}
