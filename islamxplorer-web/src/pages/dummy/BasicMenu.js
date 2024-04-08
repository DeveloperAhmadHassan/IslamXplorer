import * as React from 'react';
import Button from '@mui/material/Button';
import Draggable from 'react-draggable';
import { Box, TextField } from '@mui/material';
import CloseIcon from '@mui/icons-material/Close';
import DeleteIcon from '@mui/icons-material/Delete';

export default function BasicMenu(props) {
  return (
    <Draggable>
        <div className="context-menu">
            <h1>
            {
                props.data.id[0] !== 'n' && <TextField
            id="outlined-number"
            label="Weight"
            type="number"
            InputLabelProps={{
                shrink: true,
            }}
            onChange={(e)=>props.changeWeight(e, props.data.id)}
            defaultValue={parseInt(props.data.weight)}
            />
            }
            {props.data.type === 'edge' ? `Edge ${props.data.id.replace('>','')}` : `Node ${props.data.label}`}
            </h1>
            <Box sx={{ mt: 2 }} />
            <Box sx={{width:"100%"}}>
            <Button variant="contained" startIcon={<CloseIcon />} color="success" onClick={props.onClose}>
                Close Menu
            </Button>
            </Box>
            <Box sx={{ mt: 1 }} />
            {
            isNaN(parseInt(props.data.id[0])) ? 
                (<Box sx={{width: "100%"}}><Button variant="outlined" startIcon={<DeleteIcon />} color="error" onClick={()=>props.deleteNodeByID(props.data.id)}>
                Delete Node
                </Button></Box>) : 
                (<Box sx={{width: "100%"}}><Button variant="outlined" startIcon={<DeleteIcon />} color="error" onClick={()=>props.deleteEdge(props.data.id)}>
                Delete Edge
                </Button></Box>)
            }
        </div>
    </Draggable>
  );
}
