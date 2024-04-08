import {Button, Checkbox, FormControlLabel, FormGroup, Snackbar } from "@mui/material";

import LoadingButton from '@mui/lab/LoadingButton';
import DeleteIcon from '@mui/icons-material/Delete';
import AddIcon from '@mui/icons-material/Add';
import ClearIcon from '@mui/icons-material/Clear';
import FileDownloadIcon from '@mui/icons-material/FileDownload';
import CenterFocusWeakIcon from '@mui/icons-material/CenterFocusWeak';
import SendIcon from '@mui/icons-material/Send';
import ShuffleIcon from '@mui/icons-material/Shuffle';
import AlertDialogSlide from "./AlertDialog";

export const SideMenu = (props) =>{
    
    return (
        <div className='side-menu'>
        <h3 style={{ margin: 5, textAlign: "center" }}>Menu</h3>
        <Button style={{maxWidth: '130px', maxHeight: '130px', minWidth: 'fit-content', minHeight: '30px', alignSelf:'center'}} variant="contained" startIcon={<AddIcon />} color="success" size="small" onClick={props.addNode}>
        Add Node
        </Button> 
        <Button style={{maxWidth: '130px', maxHeight: '130px', minWidth: 'fit-content', minHeight: '30px', alignSelf:'center'}} variant="contained" startIcon={<DeleteIcon />} color="error" onClick={props.deleteNode}>
        Delete Node
        </Button>
        <Button style={{maxWidth: '130px', maxHeight: '130px', minWidth: 'fit-content', minHeight: '30px', alignSelf:'center'}} variant="contained" startIcon={<ClearIcon />} color="secondary" onClick={props.clearCanvas}>
        Clear Canvas
        </Button>
        <Button style={{maxWidth: '130px', maxHeight: '130px', minWidth: 'fit-content', minHeight: '30px', alignSelf:'center'}} variant="contained" startIcon={<FileDownloadIcon />} color="secondary" onClick={props.exportGraph}>
        Export Graph
        </Button>
        <Button style={{maxWidth: '130px', maxHeight: '130px', minWidth: 'fit-content', minHeight: '30px', alignSelf:'center'}} variant="contained" startIcon={<CenterFocusWeakIcon />} color="secondary" onClick={props.centerGraph}>
        Center
        </Button>
        <LoadingButton
        size="small"
        onClick={props.sendData}
        endIcon={<SendIcon />}
        loading={props.loading}
        loadingPosition="end"
        variant="contained"
        style={{maxWidth: '130px', maxHeight: '130px', minWidth: '160px', minHeight: '30px', alignSelf:'center'}}
        ><span>Solve Graph</span></LoadingButton>

        {props.loading && <AlertDialogSlide slide={props.loading} />}

        <FormGroup>
        <FormControlLabel 
            control={<Checkbox
            onChange={props.handleCurveEdges}
            inputProps={{ 'aria-label': 'controlled' }}
            />} 
            label="Curve Edges" 
        />

        <FormControlLabel 
            control={<Checkbox
            onChange={props.handleDirectedEdges}
            inputProps={{ 'aria-label': 'controlled' }}
            />} 
            label={props.directed === 'end' ? "Directed Graph": "Undirected Graph"}
        />
        </FormGroup>

        </div>
    );
}