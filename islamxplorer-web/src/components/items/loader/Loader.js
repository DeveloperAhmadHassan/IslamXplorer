import { CircularProgress } from '@mui/material';
import './styles.scss';

export const Loader = ()=>{
    return (<div id='loading'><CircularProgress /><p>Loading....</p></div>);
}