import { Navigate, Outlet } from "react-router-dom";
import { useAuth } from "./hooks/useAuth";
import { Link } from "react-router-dom/dist";

export const ProtectedLayout = ({children}) => {
  const { user } = useAuth();

  if (!user) {
    return <Navigate to="/login" />;
  }

  return (
    <>
      <Outlet />
      {children}
    </>
  )
};