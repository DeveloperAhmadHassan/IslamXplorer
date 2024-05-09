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
import { Alert, Container, Snackbar } from '@mui/material';
import EnhancedTableToolbar from './EnhancedTableToolbar';
import { Button } from '@mui/base';
import { EButtons } from './EButtons';
import { useAuth } from '../../../hooks/useAuth';

import app, { db } from '../../../firebase';
import { getFirestore, collection, query, where, getDocs, addDoc, doc, updateDoc, arrayUnion, writeBatch, deleteDoc } from "firebase/firestore";
import useTokens from '../../../hooks/useTokens';
import { Loader } from '../../../components/items/loader/Loader';
import { NoItems } from '../../../components/items/noItems/NoItems';

import { createData, descendingComparator, getComparator, stableSort } from './utils';
import EnhancedTableHead from './EnhancedTableHead';


export const ApiTokenTable = () => {
  const [rows, setRows, loading] = useTokens(); 
  const [order, setOrder] = React.useState('asc');
  const [orderBy, setOrderBy] = React.useState('name');
  const [selected, setSelected] = React.useState([]);
  const [page, setPage] = React.useState(0);
  const [dense, setDense] = React.useState(false);
  const [rowsPerPage, setRowsPerPage] = React.useState(5);

  const { user } = useAuth();

  const [open, setOpen] = React.useState(false);
  const [snackbarData, setSnackbarData]=React.useState([{
    severity:'success',
    message:'dummy message'
  }]);

  const handleRequestSort = (event, property) => {
    const isAsc = orderBy === property && order === 'asc';
    setOrder(isAsc ? 'desc' : 'asc');
    setOrderBy(property);
  };

  const handleSelectAllClick = (event) => {
    if (event.target.checked) {
      const newSelected = rows.map((n) => n.id);
      setSelected(newSelected);
      return;
    }
    setSelected([]);
  };

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };

  const isSelected = (id) => selected.indexOf(id) !== -1;

  const emptyRows =
    page > 0 ? Math.max(0, (1 + page) * rowsPerPage - rows.length) : 0;

  const visibleRows = React.useMemo(
    () =>
      stableSort(rows, getComparator(order, orderBy)).slice(
        page * rowsPerPage,
        page * rowsPerPage + rowsPerPage,
      ),
    [order, orderBy, page, rowsPerPage, rows],
  );

  const handleClick = (event, id) => {
    const selectedIndex = selected.indexOf(id);
    let newSelected = [];

    if (selectedIndex === -1) {
      newSelected = newSelected.concat(selected, id);
    } else if (selectedIndex === 0) {
      newSelected = newSelected.concat(selected.slice(1));
    } else if (selectedIndex === selected.length - 1) {
      newSelected = newSelected.concat(selected.slice(0, -1));
    } else if (selectedIndex > 0) {
      newSelected = newSelected.concat(
        selected.slice(0, selectedIndex),
        selected.slice(selectedIndex + 1),
      );
    }
    setSelected(newSelected);
  };

  function formatDate(dateString) {
    try {
      const date = new Date(dateString);
      const dayNames = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
      const monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

      const day = dayNames[date.getDay()]; 
      const dateNumber = date.getDate(); 
      const month = monthNames[date.getMonth()]; 
      const year = date.getFullYear(); 
  
      const formattedDate = `${day}, ${dateNumber} ${month} ${year}`;
  
      return formattedDate;
    } catch (error) {
      console.error('Error formatting date string:', error);
      return null; 
    }
  }

  function copyToClipboard(content) {
    const textarea = document.createElement('textarea');
    textarea.value = content;
    textarea.style.position = 'fixed';
    textarea.style.opacity = 0;
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand('copy');
    document.body.removeChild(textarea);

    setSnackbarData({
      severity:'success',
      message:'Copied To Clipboard!'
    })

    setOpen(true);
  }

  const addTokenToFireStore = async (uid, token) =>{
    try { 
      const newToken = {
        id: "firebase_generated_unique_id", 
        name: `${token.name}`,
        token: `${token.token}`,
        createdOn: `${token.created}`,
        expiresOn: `${token.expiry}`
      };
    
      const tokenDocRef = await addDoc(collection(db, "Tokens"), newToken);
      const tokenId = tokenDocRef.id;

      const userDocRef = doc(db, "Users", uid);
      const newTokenDocRef = doc(db, "Tokens", tokenId);

      await updateDoc(userDocRef, {
        tokens: arrayUnion(tokenId) 
      });

      await updateDoc(newTokenDocRef, {
        id: tokenId
      });
    } catch (error) {
      console.error("Error adding token to Firestore:", error);
    }
  }

  const handleClose = (event, reason) => {
    if (reason === 'clickaway') {
      return;
    }

    setOpen(false);
  };

  const addToken = async(e)=>{
    // var a = window.confirm("Confirm")
    e.preventDefault()
    if(true){
        try {
            const response = await fetch("http://192.168.56.1:48275/login", {
              method: "POST",
              headers: {
                "Content-Type": "application/json"
              },
              body: JSON.stringify({
                idToken: user.accessToken
              })
            });

            if(response.ok){
              const responseData = await response.json();
              console.log(responseData);
              const today = new Date();
              const tomorrow = new Date(today);
              tomorrow.setDate(today.getDate() + 1);
              const newRow = createData(rows.length+1, 'Name', responseData.token, today, tomorrow);
              setRows(prevRows => {
                const newRows = [...prevRows]; 
                newRows.unshift(newRow);
                return newRows; 
              });


              addTokenToFireStore(user.uid, newRow);

              setSnackbarData({
                severity:'success',
                message:'Successfully Created New Token'
              });

              setOpen(true);

            } else{
              console.log("Couldn't get a token!");
              setSnackbarData({
                severity:'error',
                message:'Error Creating Token!'
              });

              setOpen(true);
            }
        } catch (error) {
            console.error("Error:", error);
            setSnackbarData({
              severity:'error',
              message:'Error Creating Token!'
            });

            setOpen(true);
        }
    }
  };

  const deleteToken = async (event, id) => {
    event.stopPropagation()
    try {
      const tokenRef = doc(db, 'Tokens', id);
      await deleteDoc(tokenRef);

      const updatedRows = rows.filter(row => row.id !== id);
      setRows(updatedRows);

      setSnackbarData({
        severity:'error',
        message:'Successfully Deleted Token'
      });

      setOpen(true);

    } catch (error) {
      console.error('Error deleting token:', error);
      throw error;
    }
  };

  const refreshToken = (event) => {
    event.stopPropagation()
  };
  

  return (
    <>
      {loading ? <Loader /> :
      rows.length <= 0 ? <>
      <EButtons addToken={addToken} results={rows.length}/>
      <NoItems />      
        <Snackbar open={open} autoHideDuration={2000} onClose={handleClose}>
          <Alert
            onClose={handleClose}
            severity={snackbarData.severity}
            variant="filled"
            sx={{ width: '100%' }}
          >
            {snackbarData.message}
          </Alert>
        </Snackbar>
      </>:
      <>
      <EButtons addToken={addToken} results={rows.length}/>
      <Box id='table-con'>
          <Paper sx={{ width: '100%', mb: 2 }}>
          <EnhancedTableToolbar numSelected={selected.length} />
          <TableContainer>
            <Table
              sx={{ minWidth: 750 }}
              aria-labelledby="tableTitle"
              size='medium'
            >
              <EnhancedTableHead
                numSelected={selected.length}
                order={order}
                orderBy={orderBy}
                onSelectAllClick={handleSelectAllClick}
                onRequestSort={handleRequestSort}
                rowCount={rows.length}
              />
              <TableBody>
                {visibleRows.map((row, index) => {
                  const isItemSelected = isSelected(row.id);
                  const labelId = `enhanced-table-checkbox-${index}`;

                  return (
                    <TableRow
                      onClick={(event) => handleClick(event, row.id)}
                      role="checkbox"
                      aria-checked={isItemSelected}
                      tabIndex={-1}
                      key={row.id}
                      selected={isItemSelected}
                      sx={{ cursor: 'pointer' }}
                    >
                      <TableCell padding="checkbox">
                        <Checkbox
                          color="primary"
                          checked={isItemSelected}
                          inputProps={{
                            'aria-labelledby': labelId,
                          }}
                        />
                      </TableCell>
                      <TableCell
                        component="th"
                        id={labelId}
                        scope="row"
                        padding="none"
                      >
                        {row.name}
                      </TableCell>
                      <TableCell align="center"><Container maxWidth="sm" className='token-container'><Container className='token'>{row.token}</Container> <Tooltip title="Copy to Clipboard" arrow><ContentCopyIcon onClick={()=>copyToClipboard(row.token)} className='btn-con copy-icon'/></Tooltip></Container></TableCell>
                      <TableCell align="center">{formatDate(row.created)}</TableCell>
                      <TableCell align="center">{formatDate(row.expiry)}</TableCell>
                      <TableCell align="center"><Container maxWidth="sm" className='actions-container'><Tooltip title="Delete Token" arrow><div className='btn-con delete'><DeleteIcon color='error' onClick={(event) => deleteToken(event, row.id)}/></div></Tooltip><Tooltip title="Refresh Token" arrow><div><RefreshIcon className='btn-con refresh' color='primary' onClick={(event) => refreshToken(event)} /></div></Tooltip></Container></TableCell>
                    </TableRow>
                  );
                })}
                {emptyRows > 0 && (
                  <TableRow
                    style={{
                      height: (dense ? 33 : 53) * emptyRows,
                    }}
                  >
                    <TableCell colSpan={6} />
                  </TableRow>
                )}
              </TableBody>
            </Table>
          </TableContainer>
          <TablePagination
            rowsPerPageOptions={[5, 10, 25]}
            component="div"
            count={rows.length}
            rowsPerPage={rowsPerPage}
            page={page}
            onPageChange={handleChangePage}
            onRowsPerPageChange={handleChangeRowsPerPage}
          />
        </Paper>
      </Box>
      <Snackbar open={open} autoHideDuration={2000} onClose={handleClose}>
        <Alert
          onClose={handleClose}
          severity={snackbarData.severity}
          variant="filled"
          sx={{ width: '100%' }}
        >
          {snackbarData.message}
        </Alert>
      </Snackbar>
      </>
      }</>
  );
}
