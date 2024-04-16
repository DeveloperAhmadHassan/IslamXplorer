import * as React from 'react';
import PropTypes from 'prop-types';
import Box from '@mui/material/Box';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TablePagination from '@mui/material/TablePagination';
import TableRow from '@mui/material/TableRow';
import TableSortLabel from '@mui/material/TableSortLabel';
import Paper from '@mui/material/Paper';
import Checkbox from '@mui/material/Checkbox';
import Tooltip from '@mui/material/Tooltip';

import {format} from 'date-fns';

import { visuallyHidden } from '@mui/utils';

import DeleteIcon from '@mui/icons-material/Delete';
import RefreshIcon from '@mui/icons-material/Refresh';
import ContentCopyIcon from '@mui/icons-material/ContentCopy';
import { Alert, Card, CardActionArea, CardContent, CardMedia, Container, Snackbar, Typography } from '@mui/material';
import EnhancedTableToolbar from './apiTokenPages/EnhancedTableToolbar';
import { Button } from '@mui/base';
import { EButtons } from './apiTokenPages/EButtons';
import { useAuth } from '../hooks/useAuth';

import app, { db } from '../firebase';
import { getFirestore, collection, query, where, getDocs, addDoc, doc, updateDoc, arrayUnion, writeBatch, deleteDoc } from "firebase/firestore";
import useTokens from '../hooks/useTokens';
import { Loader } from '../components/items/loader/Loader';
import { NoItems } from '../components/items/noItems/NoItems';
import { WordCarousel } from '../components/items/wordCarousel/wordCarousel';

import service1 from "../../src/assets/images/services-images/Oriental Design 3.1.png";
import service2 from "../../src/assets/images/services-images/Oriental Design 3.2.png";
import service3 from "../../src/assets/images/services-images/Oriental Design 3.3.png";
import service4 from "../../src/assets/images/services-images/Oriental Design 3.4.png";
import service5 from "../../src/assets/images/services-images/Oriental Design 3.5.png";
import ItemCarousel from './ItemCarousel';


export const Home = () => {
  

  return (
    <>
      <section className={'opener'}>
        <header>
        <h1 className={"opener"} aria-label="Easily Searchable Quran O Hadith">
          <span className={"headline-top"}>Explore <WordCarousel /></span>
          <span className={"headline-bottom"}>With Knowledge Graphs.</span>
        </h1>
        </header>
        <section className={'services'}>
        <div className={'top-row'}>
          <Card sx={{ maxWidth: 345 }}>
            <CardActionArea>
              <CardMedia
                component="img"
                height="140"
                image={service1}
                alt="knowledge graph"
              />
              <CardContent>
                <Typography gutterBottom variant="h5" component="div">
                  Lizard
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  Lizards are a widespread group of squamate reptiles, with over 6,000
                  species, ranging across all continents except Antarctica
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>
          <Card sx={{ maxWidth: 345 }}>
            <CardActionArea>
              <CardMedia
                component="img"
                height="140"
                image={service2}
                alt="search"
              />
              <CardContent>
                <Typography gutterBottom variant="h5" component="div">
                  Lizard
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  Lizards are a widespread group of squamate reptiles, with over 6,000
                  species, ranging across all continents except Antarctica
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>
          <Card sx={{ maxWidth: 345 }}>
            <CardActionArea>
              <CardMedia
                component="img"
                height="140"
                image={service3}
                alt="islamic routines"
              />
              <CardContent>
                <Typography gutterBottom variant="h5" component="div">
                  Lizard
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  Lizards are a widespread group of squamate reptiles, with over 6,000
                  species, ranging across all continents except Antarctica
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>
        </div>
        <div class='bottom-row'>
          <Card sx={{ maxWidth: 345 }}>
            <CardActionArea>
              <CardMedia
                component="img"
                height="140"
                image={service4}
                alt="learn quran"
              />
              <CardContent>
                <Typography gutterBottom variant="h5" component="div">
                  Lizard
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  Lizards are a widespread group of squamate reptiles, with over 6,000
                  species, ranging across all continents except Antarctica
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>
          <Card sx={{ maxWidth: 345 }}>
            <CardActionArea>
              <CardMedia
                component="img"
                height="140"
                image={service5}
                alt="contribute"
              />
              <CardContent>
                <Typography gutterBottom variant="h5" component="div">
                  Lizard
                </Typography>
                <Typography variant="body2" color="text.secondary">
                  Lizards are a widespread group of squamate reptiles, with over 6,000
                  species, ranging across all continents except Antarctica
                </Typography>
              </CardContent>
            </CardActionArea>
          </Card>
        </div>
        </section>
      </section>


      <section className={'item-showcase'}>
        <ItemCarousel />
      </section>

      <section className={'testimonials'}>
        <div className='testimonial'>
          <p className='testimonial'>“With product inclusion, it’s really looking end to end at the design and development process and saying: Who else needs to be in the room? Who else do we need to have perspective from? And I think co-creating is really integral to building a product that actually suits the world.”</p>
          <div>
          <img src="http://placehold.it/100x100" alt="Dummy Image" />
            <div>
              <p>Some Name of a Person</p>
              <p>Some long designation of that Person</p>
            </div>
          </div>
        </div>
        <div className='testimonial'>
          <p className='testimonial'>“With product inclusion, it’s really looking end to end at the design and development process and saying: Who else needs to be in the room? Who else do we need to have perspective from? And I think co-creating is really integral to building a product that actually suits the world.”</p>
          <div>
          <img src="http://placehold.it/100x100" alt="Dummy Image" />
            <div>
              <p>Some Name of a Person</p>
              <p>Some long designation of that Person</p>
            </div>
          </div>
        </div>
      </section>

      {/* <section>
        <Example />
      </section> */}
    </>
  );
}
