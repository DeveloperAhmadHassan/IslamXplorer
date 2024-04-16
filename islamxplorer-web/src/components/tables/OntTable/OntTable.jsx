import React, { } from 'react';
import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper, CircularProgress, Tooltip, toolbarClasses, Typography } from '@mui/material';
import { styled } from '@mui/material/styles';
import {
  createTheme,
  responsiveFontSizes,
  ThemeProvider,
} from '@mui/material/styles';
import useOnt from '../../../hooks/useOnt';
import { Loader } from '../../items/loader/Loader';
import { NoItems } from '../../items/noItems/NoItems';
import { EButtons } from './EButtons';


export const OntTable = () => {
  const {data, isLoadingOnt} = useOnt('http://192.168.56.1:48275/ontologies');

  let theme = createTheme();
  theme = responsiveFontSizes(theme);

  const renderRows = () => {
    if (!data) {
      return null;
    }
  
    if (!data || data.length === 0) {
      return [];
    }

    const categoryRowSpans = data.map(topic => (
      topic.concepts.reduce((total, concept) => total + concept.totalRelationships, 0)
    ));
  
    const rows = data.flatMap((topic, topicIndex) => {
      return topic.concepts.flatMap((concept, conceptIndex) => {
        return concept.relationships.map((relationship, relationshipIndex) => ({
          category: (topic.flag && concept.flag && relationship.flag) ? topic.name : '',
          action: relationshipIndex === 0 ? concept.name : '',
          relation: relationship.relName,
          data: Array.isArray(relationship.dataTypeID) ? relationship.dataTypeID.join(', ') : relationship.dataTypeID,
          dataHoverText: relationship.data.englishText,
          categoryRowSpan: (topic.flag && concept.flag && relationship.flag) ? categoryRowSpans[topicIndex] : undefined,
          actionRowSpan: relationshipIndex === 0 ? concept.relationships.length : undefined,
          startBorder: (topic.flag && concept.flag && relationship.flag) ? 'start-border': '',
        }));
      });
    });

    return rows;
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
    <> {isLoadingOnt ? <Loader /> : renderRows() <= 0 ? <NoItems /> : 
    <>
    <EButtons results={data.length}/>
    <TableContainer component={Paper} id='border'>
      <Table>
        <TableHead>
          <TableRow>
            <TableCell className='table-head'>Categories</TableCell>
            <TableCell className='table-head'>Actions</TableCell>
            <TableCell className='table-head'>Concepts</TableCell>
            <TableCell className='table-head'>Data</TableCell>
          </TableRow>
        </TableHead>
        {
        <TableBody>
          {renderRows().map((row, index) => (
            <TableRow key={index}>
              {row.categoryRowSpan && <TableCell id={row.startBorder} className='category' rowSpan={row.categoryRowSpan}>{row.category}</TableCell>}
              {row.actionRowSpan && <TableCell id={row.startBorder} className='concept' rowSpan={row.actionRowSpan}>{row.action}</TableCell>}
              <TableCell id={row.startBorder} className='relation-cell'>
                <div>
                  <p className='relation-text'>{row.relation}</p>
                  <div id='hover-text'><p>Some Text</p></div>
                </div>
              </TableCell>
              <TableCell id={row.startBorder} className='data-cell'>
                <div>
                  {/* <Tooltip title={row.dataHoverText}></Tooltip> */}
                  <ThemeProvider theme={theme}>
                    <HtmlTooltip
                      title={
                        <React.Fragment>
                          <Typography variant='subtitle2' gutterBottom>{row.dataHoverText}</Typography>
                        </React.Fragment>
                      }
                    >
                      <p className='data-text wavy-underline'>{row.data}</p>
                    </HtmlTooltip>
                  </ThemeProvider>
                  {/* <div id='hover-text'><p>{row.dataHoverText}</p></div> */}
                </div>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>}
      </Table>
  </TableContainer>
    </>}
    </>
  );
};