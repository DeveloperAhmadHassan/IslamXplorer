import React from "react";
import { NavLink, Link as RouterLink } from "react-router-dom";
import { Container, Typography, Link, Box, Divider } from "@mui/material";
import styled from "@emotion/styled";

import SocialAuth from "../../components/forms/authForms/SocialAuth";
import SignupForm from "../../components/forms/authForms/SignupForm";
import Logo from "../../components/forms/authForms/Logo";
import { motion } from "framer-motion";

let easing = [0.6, -0.05, 0.01, 0.99];
const fadeInUp = {
  initial: {
    y: 40,
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

const Signup = ({ setAuth }) => {
  return (
    <main>
      <Container maxWidth="sm">
        <div className="content">
          <Box className="heading" component={motion.div} {...fadeInUp}>
            <Logo />

            <Typography sx={{ color: "text.secondary", mb: 5 }}>
              Enter your details below.
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

          <SignupForm setAuth={setAuth} />

          <Typography
            component={motion.p}
            {...fadeInUp}
            variant="body2"
            align="center"
            sx={{ color: "text.secondary", mt: 2 }}
          >
            By registering, I agree to{" "}
            <NavLink to='/'>
              Terms of Service 
            </NavLink>{" "}
            &{" "}
            <NavLink to='/'>
              Privacy Policy
            </NavLink>
            .
          </Typography>

          <Typography
            component={motion.p}
            {...fadeInUp}
            variant="body2"
            align="center"
            sx={{ mt: 3 }}
          >
            Have an account?{" "}
            <NavLink variant="subtitle2" component={RouterLink} to="/login">
              Login
            </NavLink>
          </Typography>
        </div>
      </Container>
    </main>
  );
};

export default Signup;
