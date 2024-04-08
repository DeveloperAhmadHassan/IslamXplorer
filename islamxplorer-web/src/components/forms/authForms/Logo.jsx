import React from "react";
import { Link } from "react-router-dom";
import { Box } from "@mui/material";

const Logo = () => {
  return (
    <Box>
      <Link to="/">
        <Box sx={{height:"100px", width:"auto"}} component="img" src="/static/main_logo.png" alt="logo" />
      </Link>
    </Box>
  );
};

export default Logo;
