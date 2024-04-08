import React from "react";
import { Link } from "react-router-dom";
import { Box } from "@mui/material";

const Logo = (props) => {
  return (
    <Box>
      <Link to="/">
        <Box sx={{height:"auto", width:"170px", marginTop:"5px",...props.sx}} component="img" src="/static/secondary_logo.png" alt="logo" />
      </Link>
    </Box>
  );
};

export default Logo;
