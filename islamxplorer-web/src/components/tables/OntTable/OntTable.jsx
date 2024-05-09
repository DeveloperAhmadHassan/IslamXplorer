import React, { useEffect, useRef, useState } from 'react';
import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper, CircularProgress, Tooltip, toolbarClasses, Typography, Container, Backdrop, DialogTitle, DialogContent, DialogContentText, TextField, DialogActions, Dialog, Button, Slide, Zoom } from '@mui/material';
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

import DeleteIcon from '@mui/icons-material/Delete';
import { useAuth } from '../../../hooks/useAuth';



export const OntTable = () => {
  const {data, isLoadingOnt} = useOnt('http://192.168.56.1:48275/ontologies');
  const {user} = useAuth();

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

    console.log(data);
  
    const rows = data.flatMap((topic, topicIndex) => {
      return topic.concepts.flatMap((concept, conceptIndex) => {
        return concept.relationships.map((relationship, relationshipIndex) => ({
          id: relationship.relationshipID,
          category: (topic.flag && concept.flag && relationship.flag) ? topic.name : '',
          action: relationshipIndex === 0 ? concept.name : '',
          relation: relationship.relName,
          data: Array.isArray(relationship.dataTypeID) ? relationship.dataTypeID.join(', ') : relationship.dataTypeID,
          dataHoverText: relationship.data.englishText,
          categoryRowSpan: (topic.flag && concept.flag && relationship.flag) ? categoryRowSpans[topicIndex] : undefined,
          actionRowSpan: relationshipIndex === 0 ? concept.relationships.length : undefined,
          startBorder: (topic.flag && concept.flag && relationship.flag) ? 'start-border': '',
          externalUserId: relationship.externalUserID
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

  const Transition = React.forwardRef(function Transition(props, ref) {
    return <Slide direction="up" ref={ref} {...props} />;
  });

  const [openBackdrop, setOpenBackdrop] = useState(false);
  const handleBackdropClose = () => {
    setOpenBackdrop(false);
  };
  const handleBackdropOpen = () => {
    setOpenBackdrop(true);
  };

  const [openDialog, setOpenDialog] = useState(false);

  const handleDialogOpen = () => {
    setOpenDialog(true);
  };

  const handleDialogClose = () => {
    setOpenDialog(false);
    handleBackdropClose();
  };

  const deleteOntology = async (event, relID, userID) =>{
    event.preventDefault();
    handleBackdropOpen();
    if(userID === user.uid){
      try {
        let data = {
          "scholarID": userID
        };
        const response = await fetch(`http://192.168.56.1:48275/ontologies/${relID}`, {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify(data)
        });
      } catch (error) {
        console.error("Error:", error);
      }
    } else{
      console.log('Cannot Delete!');
      handleBackdropClose();
      handleDialogOpen();
    }
  }


  return (
    <> {isLoadingOnt ? <Loader /> : renderRows() <= 0 ? <NoItems /> : 
    <>
      <Backdrop
          sx={{ color: '#fff', zIndex: (theme) => theme.zIndex.drawer + 1 }}
          open={openBackdrop}
          onClick={handleBackdropClose}
        >
        <CircularProgress color="inherit" />
      </Backdrop>
      <>
      <Dialog
        open={openDialog}
        // TransitionComponent={Transition}
        // keepMounted
        onClose={handleDialogClose}
        PaperProps={{
          component: 'form',
          onSubmit: (event) => {
            event.preventDefault();
            const formData = new FormData(event.currentTarget);
            const formJson = Object.fromEntries(formData.entries());
            const message = formJson.message;
            console.log(message);
            handleDialogClose();
          },
        }}
      >
        <DialogTitle>External Ontology</DialogTitle>
        <DialogContent>
          <DialogContentText>
            This Ontology is not created by you, so you cannot delete it.
            To delete this Ontology, please contact the scholar.
          </DialogContentText>
          <TextField
            autoFocus
            required
            margin="dense"
            id="name"
            name="message"
            label="Message"
            type="text"
            fullWidth
            variant="standard"
          />
        </DialogContent>
        <DialogActions>
          <Button color='error' onClick={handleDialogClose}>Cancel</Button>
          <Button type="submit">Send Message</Button>
        </DialogActions>
      </Dialog>
      </>
      <EButtons results={data.length}/>
      <TableContainer component={Paper} id='border'>
      <Table>
        <TableHead>
          <TableRow key='000'>
            <TableCell className='table-head'>Topic</TableCell>
            <TableCell className='table-head'>Concept</TableCell>
            <TableCell className='table-head'>Relationship</TableCell>
            <TableCell className='table-head'>Verse</TableCell>
            <TableCell className='table-head'>Actions</TableCell>
          </TableRow>
        </TableHead>
        {
        <TableBody>
          {renderRows().map((row, index) => (
            <TableRow key={row.id}>
              {row.categoryRowSpan && <TableCell id={row.startBorder} className='category' rowSpan={row.categoryRowSpan}>
                <Tooltip title={row.category} arrow followCursor TransitionComponent={Zoom}>
                  {row.category}
                </Tooltip>
              </TableCell>}
              {row.actionRowSpan && <TableCell id={row.startBorder} className='concept' rowSpan={row.actionRowSpan}>{row.action}</TableCell>}
              <TableCell id={row.startBorder ? "start-border":""} className='relation-cell'>
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
              <TableCell align="center" id={row.startBorder}>
                <Container maxWidth="sm" className='actions-container'>
                  <Tooltip title="Delete Ontology" arrow>
                    <div className='btn-con delete'>
                      <DeleteIcon color='error' onClick={(event)=>deleteOntology(event, row.id, row.externalUserId)}/>
                    </div>
                  </Tooltip>
                </Container>
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