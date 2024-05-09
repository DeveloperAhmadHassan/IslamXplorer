import React, { } from 'react';
import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper, CircularProgress, Tooltip, toolbarClasses, Typography, Container } from '@mui/material';
import { styled } from '@mui/material/styles';
import {
  createTheme,
  responsiveFontSizes,
  ThemeProvider,
} from '@mui/material/styles';
import { Loader } from '../../items/loader/Loader';
import { NoItems } from '../../items/noItems/NoItems';
import useAllVerses from '../../../hooks/UseAllVerses';
import { EButtons } from './EButtons';

import DeleteIcon from '@mui/icons-material/Delete';
import UpdateIcon from '@mui/icons-material/Update';

// import './styles.scss';


export const VerseTable = () => {
  const {data, isLoadingVerses} = useAllVerses('http://192.168.56.1:48275/verses');

  let theme = createTheme();
  theme = responsiveFontSizes(theme);

  const renderRows = () => {
    if (!data) {
      // console.log("rows");
      return null;
    }
  
    if (!data || data.length === 0) {
      // console.log("rows");
      return [];
    }
    return data;
  };

  const HtmlTooltip = styled(({ className, ...props }) => (
    <Tooltip {...props} classes={{ popper: className }} arrow/>
  ))(({ theme }) => ({
    [`& .${toolbarClasses.tooltip}`]: {
      backgroundColor: '#f5f5f9',
      color: 'rgba(1, 1, 1, 0.87)',
      maxWidth: 220,
      fontSize: theme.typography.pxToRem(12),
      border: '6px solid #eeeeee',
    },
  }));

  return (
    <> {isLoadingVerses ? <Loader /> : renderRows() <= 0 ? <NoItems /> : 
    <>
    <EButtons results={data.length}/>
    <TableContainer component={Paper} id='border'>
      <Table>
        <TableHead>
          <TableRow>
            <TableCell className={'table-head'}>Surah</TableCell>
            <TableCell className={'table-head'}>Verse Number</TableCell>
            <TableCell className={'table-head'}>Text</TableCell>
            <TableCell className={'table-head'}>Actions</TableCell>
          </TableRow>
        </TableHead>
        {
        <TableBody>
          {renderRows().map((row, index) => (
            <TableRow key={index}>
              <TableCell id={row.verseID} className={`source-cell ${index === 0 ? "start-border" : ""}`}>
                <div>
                  <p className='source-text'>{row.source}</p>
                </div>
              </TableCell>
              <TableCell id={row.verseID} className={`verse-cell ${index === 0 ? "start-border" : ""}`}>
                <div>
                  <p className='verse-text'>{row.verseID.split(":")[1]}</p>
                </div>
              </TableCell>
              <TableCell id={row.verseID} className={`data-cell ${index === 0 ? "start-border" : ""}`}>
                <div>
                  {/* <Tooltip title={row.dataHoverText}></Tooltip> */}
                  <ThemeProvider theme={theme}>
                    <HtmlTooltip
                      title={
                        <React.Fragment>
                          <Typography variant='subtitle2' gutterBottom>{row.arabicText}</Typography>
                        </React.Fragment>
                      }
                    >
                      <p className='data-text wavy-underline'>{row.englishText}</p>
                    </HtmlTooltip>
                  </ThemeProvider>
                  {/* <div id='hover-text'><p>{row.dataHoverText}</p></div> */}
                </div>
              </TableCell>
              <TableCell align="center" id={row.startBorder}>
                <Container maxWidth="sm" className='actions-container'>
                  <Tooltip title="Delete Verse" arrow>
                    <div className='btn-con delete'>
                      <DeleteIcon color='error' />
                    </div>
                  </Tooltip>
                  <Tooltip title="Update Verse" arrow>
                    <div>
                      <UpdateIcon className='btn-con refresh' color='primary' />
                    </div>
                  </Tooltip>
                </Container>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>}
      </Table>
  </TableContainer>

    </>
    }
      {}
    </>
  );
};