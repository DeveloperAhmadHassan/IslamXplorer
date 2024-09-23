import * as React from 'react';
import Stack from '@mui/material/Stack';
import Button from '@mui/material/Button';

import AddIcon from '@mui/icons-material/Add';
import CachedIcon from '@mui/icons-material/Cached';
import { Divider, Typography } from '@mui/material';

import CustomizedInputBase from '../../../pages/SearchBar';

export const EButtons = (props) =>{
    return (
        <Stack direction="row" spacing={2} padding={"12px"} className='buttons-container'>
          <div>
            <Button className={'main-btn'} id="add-token-btn" variant="contained" color="primary" startIcon={<AddIcon />} onClick={props.addToken}>
                Create API Token
            </Button>
            <CustomizedInputBase />
          </div>

          <div>
            <p>{props.results} Results</p>
            <Divider sx={{ height: 38, m: 0.5 }} orientation="vertical" />
            <Button variant="outlined" color="secondary" startIcon={<CachedIcon />}>
                Refresh
            </Button>
          </div>
        </Stack>
      );
}