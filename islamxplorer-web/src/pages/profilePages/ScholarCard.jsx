import * as React from 'react';
import { useTheme } from '@mui/material/styles';
import Box from '@mui/material/Box';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';
import CardMedia from '@mui/material/CardMedia';
import IconButton from '@mui/material/IconButton';
import Typography from '@mui/material/Typography';
import SkipPreviousIcon from '@mui/icons-material/SkipPrevious';
import PlayArrowIcon from '@mui/icons-material/PlayArrow';
import SkipNextIcon from '@mui/icons-material/SkipNext';

import CloseIcon from '@mui/icons-material/Close';
import DoneIcon from '@mui/icons-material/Done';

import image from '../../../src/assets/backgrounds/profile-background.jpg';
import { CardActionArea, Tooltip } from '@mui/material';

export default function ScholarCard(props) {
  const theme = useTheme();

  const approve = (index) =>{
    props.approveScholar(props.uid, props.id);
    props.removeFromList(index);
  }


  return (
    <Card sx={{ display: 'flex' }}>
      <CardActionArea>
      <Box sx={{ display: 'flex', flexDirection: 'column' }}>
        <CardContent sx={{ flex: '1 0 auto' }}>
          <Typography component="div" variant="h5">
            {props.name}
          </Typography>
          <Typography variant="subtitle1" color="text.secondary" component="div">
            {props.email}
          </Typography>
        </CardContent>
        
      </Box>
      <Box sx={{ display: 'flex', alignItems: 'center', pl: 1, pb: 1, justifyContent:"center" }}>
            <Tooltip title="Disapprove Scholar" arrow>
                <IconButton aria-label="disapprove" onClick={()=>props.disapproveScholar()}>
                    <CloseIcon sx={{ height: 38, width: 38, color:"red" }}/>
                </IconButton>
            </Tooltip>
          <Tooltip title="Approve Scholar" arrow>
                <IconButton aria-label="approve" onClick={()=>approve(props.index)}>
                    <DoneIcon sx={{ height: 38, width: 38, color:"green" }} />
                </IconButton>
          </Tooltip>
        </Box>
      </CardActionArea>
      <CardMedia
        component="img"
        sx={{ width: 151 }}
        image={props.imageUrl}
        alt={`Scholar ${props.name}'s cover image`}
      />
    </Card>
  );
}