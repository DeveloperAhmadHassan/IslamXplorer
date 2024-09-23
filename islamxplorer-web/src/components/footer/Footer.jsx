import React from 'react';
import { Toolbar, Typography, IconButton, Link, Stack, Divider } from '@mui/material';
import { Facebook, Twitter, Instagram } from '@mui/icons-material';
import Logo from '../navBar/Logo';

import './styles.css';

const Footer = () => {
  const currentYear = new Date().getFullYear();

  return (
    <footer id="page_footer">
        <Logo />
        <div className='links'>
            <Typography variant="body2" className='bold_text'>
                <a href='/'>Home</a>
            </Typography>
            <Typography variant="body2" className='bold_text'>
                <a href='/search'>Search</a>
            </Typography>
            <Typography variant="body2" className='bold_text'>
                <a href='/tokens'>Tokens</a>
            </Typography>
            <Typography variant="body2" className='bold_text'>
                <a href='/faqs'>FAQs</a>
            </Typography>
        </div>

        <div className='divider'>
            <Divider />
        </div>

        <Typography variant="body2">
          &copy; {currentYear} IslamXplorer. All Rights Reserved.
        </Typography>

        <Toolbar sx={{justifyContent:"end"}}>
            <Stack direction="row" spacing={2}>
            <IconButton color="inherit" component={Link} href="https://www.facebook.com">
                <Facebook />
            </IconButton>
            <IconButton color="inherit" component={Link} href="https://www.twitter.com">
                <Twitter />
            </IconButton>
            <IconButton color="inherit" component={Link} href="https://www.instagram.com">
                <Instagram />
            </IconButton>
            </Stack>
        </Toolbar>
    </footer>
  );
};

export default Footer;
