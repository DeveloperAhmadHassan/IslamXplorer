import { CircularProgress } from '@mui/material';
import './styles.css';

import errorImg from "../../../../src/assets/images/error.webp";

export const Error = ()=>{
    return (
        <div id="wrapper">
            <img src={errorImg} />
            <div id="info">
                <h3>This page could not be found</h3>
            </div>
        </div>
    );
}