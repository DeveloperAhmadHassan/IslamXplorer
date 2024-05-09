import React, { useState } from 'react';
import { Avatar, Typography, Container, Grid, Paper, Button, Snackbar, Alert, Slide } from '@mui/material';
import { useAuth } from '../../hooks/useAuth';

import './styles.scss';
import ScholarCard from './ScholarCard';
import ScholarCardList from './ScholarCardList';
import { deleteDoc, doc, updateDoc } from 'firebase/firestore';
import { db } from '../../firebase';
import TransitionsSnackbar from './SnackBar';

function SlideTransition(props) {
  return <Slide {...props} direction="up" />;
}

export const Profile = () => {
  const { user, logout } = useAuth();
  const [open, setOpen] = useState(false);
  //   open: false,
  //   Transition: Fade,
  // });

  const approveScholar = async (uid, id) => {
    try {
      const userDocRef = doc(db, 'Users', uid);
      await updateDoc(userDocRef, { type: 'S' });
  
      const scholarDocRef = doc(db, 'ScholarApplications', id);
      await deleteDoc(scholarDocRef);
  
      console.log(`Scholar with ID ${uid} has been approved.`);
      setOpen(true);
    } catch (error) {
      console.error('Error approving scholar:', error);
    }
  };
  
  const disapproveScholar = () =>{
    console.log("Here 1");
    setOpen(true);
    console.log(open);
  }

  const handleSnackbarClose = (event, reason) => {
    if (reason === 'clickaway') {
      return;
    }

    setOpen(false);
  };

  return (
    <>
      <Container id='profile-container'>
      <TransitionsSnackbar open={open} setOpen={setOpen} message={"Successfully Approved Scholar"}/>
      <Paper id='profile-paper'>
        <Grid container justifyContent="center" alignItems="center" spacing={2}>
          <Grid item>
            <a href='/profile/apply'>
              <Button type="submit" variant="contained" color="primary" sx={{ width: 100 }}>
                Apply
              </Button>
            </a>
          </Grid>
          <Grid item sx={{marginLeft:'auto'}}>
            <Avatar src={user.photoUrl} alt={user.name} sx={{ width: 100, height: 100, marginLeft: 16 }} />
          </Grid>
          <Grid item sx={{ marginLeft: 'auto' }}>
            <a href='/profile/update-profile'>
              <Button type="submit" variant="contained" color="primary" sx={{ width: 100 }}>
                Update
              </Button>
            </a>
          </Grid>
          <Grid item>
            <Button type="submit" variant="contained" color="primary" sx={{ width: 100 }}>
              Logout
            </Button>
          </Grid>
        </Grid>
      </Paper>
      </Container>

      <Container sx={{marginTop:10}}>

      </Container>



      <ScholarCardList approveScholar={approveScholar} disapproveScholar={disapproveScholar}/>
    </>
  );
};
