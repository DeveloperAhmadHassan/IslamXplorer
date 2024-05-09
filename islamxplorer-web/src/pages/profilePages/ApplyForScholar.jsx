import React from 'react';
import { Avatar, Typography, Container, Grid, Paper, Button } from '@mui/material';
import { useAuth } from '../../hooks/useAuth';

import './styles.scss';
import { Navigate } from 'react-router-dom';
import { ScholarForm } from '../../components/forms/scholarForm/ScholarForm';

export const ApplyForScholar = () => {
  const { user, logout } = useAuth();

  return (
    <>
      <ScholarForm />
    </>
  );
};
