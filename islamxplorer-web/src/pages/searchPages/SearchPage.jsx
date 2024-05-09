import * as React from 'react';
import Paper from '@mui/material/Paper';
import InputBase from '@mui/material/InputBase';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import SearchIcon from '@mui/icons-material/Search';
import DirectionsIcon from '@mui/icons-material/Directions';
import { Link, useParams } from 'react-router-dom';
import { Tooltip } from '@mui/material';

import { PrimaryLogo } from '../../components/items/logos/primaryLogo';
import { MainLogo } from '../../components/items/logos/mainLogo';

import './styles.scss';
import SearchResultsPage from './SearchResultsPage';
import { MainSearchBar } from './MainSearchBar';

export const SearchPage = () => {
  const params = useParams();
  const queryExists = params.query || params.q;

  if (queryExists) {
    return <SearchResultsPage query={params.query}/>;
  } else {
    return <MainSearchBar logo={true}/>;
  }
}
