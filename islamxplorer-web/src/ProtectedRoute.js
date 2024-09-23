import { Route, Navigate } from 'react-router-dom';

// Define your ProtectedRoute component
export const ProtectedRoute = ({ element, isAdmin, ...rest }) => {
  if (!isAdmin) {
    return <Navigate to="/login" />;
  }

  return <Route {...rest} element={element} />;
};