import * as React from 'react';
import Paper from '@mui/material/Paper';
import InputBase from '@mui/material/InputBase';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import SearchIcon from '@mui/icons-material/Search';
import DirectionsIcon from '@mui/icons-material/Directions';
import { Tooltip } from '@mui/material';

export default function CustomizedInputBase() {
  return (
    <Paper
      id="token-search-bar"
      component="form"
      sx={{ p: '2px 4px', display: 'flex', alignItems: 'center', borderRadius:'100px' }}
    >
      <InputBase
        sx={{ ml: 1, flex: 1 }}
        placeholder="Search API Tokens"
        inputProps={{ 'aria-label': 'search api token' }}
      />
      <IconButton type="button" sx={{ p: '10px' }} aria-label="search">
        <Tooltip title="Search Token"><SearchIcon /></Tooltip>
      </IconButton>
    </Paper>
  );
}
