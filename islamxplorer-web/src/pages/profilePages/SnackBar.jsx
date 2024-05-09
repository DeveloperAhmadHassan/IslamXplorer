import React, { useEffect, useState } from 'react';
import Snackbar from '@mui/material/Snackbar';
import Fade from '@mui/material/Fade';
import Slide from '@mui/material/Slide';
import Grow from '@mui/material/Grow';
import { Alert } from '@mui/material';

function SlideTransition(props) {
  return <Slide {...props} direction="up" />;
}

function GrowTransition(props) {
  return <Grow {...props} />;
}

export default function TransitionsSnackbar(props) {
  const [open, setOpen] = useState(props.open);
  const [Transition, setTransition] = useState(Slide);

  useEffect(() => {
    props.setOpen(props.open);
  }, [props.open]);

  const handleClose = () => {
    props.setOpen(false);
  };

  return (
    <Snackbar 
      open={props.open}
      autoHideDuration={4000} 
      onClose={handleClose}
      TransitionComponent={Transition}
      key={Transition.name}
    >
      <Alert
        onClose={handleClose}
        severity="success"
        variant="filled"
        sx={{ width: '100%' }}
      >
        {props.message}
      </Alert>
    </Snackbar>
  );
}
