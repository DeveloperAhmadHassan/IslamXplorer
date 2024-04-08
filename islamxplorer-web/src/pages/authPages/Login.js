import React from "react";
import { NavLink, Link as RouterLink } from "react-router-dom";
import { Container, Typography, Link, Box, Divider } from "@mui/material";
import styled from "@emotion/styled";
import LoginForm from "../../components/forms/authForms/LoginForm";
import SocialAuth from "../../components/forms/authForms/SocialAuth";
import Logo from "../../components/forms/authForms//Logo";
import { motion } from "framer-motion";

import "./styles.scss";

let easing = [0.6, -0.05, 0.01, 0.99];
const fadeInUp = {
  initial: {
    y: 60,
    opacity: 0,
    transition: { duration: 0.6, ease: easing },
  },
  animate: {
    y: 0,
    opacity: 1,
    transition: {
      duration: 0.6,
      ease: easing,
    },
  },
};

const Login = ({ setAuth }) => {
  return (
    <Container maxWidth="sm" id="con">
        <div className="content">
          <Box className="heading" component={motion.div} {...fadeInUp}>
            <Logo />
            <Typography sx={{ color: "text.secondary", mb: 3 }}>
              Login to your account
            </Typography>
          </Box>

          <Box component={motion.div} {...fadeInUp}>
            <SocialAuth />
          </Box>

          <Divider sx={{ my: 3 }} component={motion.div} {...fadeInUp}>
            <Typography variant="body2" sx={{ color: "text.secondary" }}>
              OR
            </Typography>
          </Divider>

          <LoginForm setAuth={setAuth} />

          <Typography
            component={motion.p}
            {...fadeInUp}
            variant="body2"
            align="center"
            sx={{ mt: 3 }}
          >
            Don’t have an account?{" "}
            <NavLink to='/signup'>
              Sign up
            </NavLink>
          </Typography>
        </div>
      </Container>
  );
};

export default Login;
