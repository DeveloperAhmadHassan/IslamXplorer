import { Navigate, Outlet } from "react-router-dom";
import { useAuth } from "./hooks/useAuth";
import { Link } from "react-router-dom/dist";

export const ProtectedLayout = ({ children, types }) => {
  const { user } = useAuth();

  console.log(user);

  if (!user) {
    return <Navigate to="/login" />;
  }

  if (!types) {
    return (
      <>
        <Outlet />
        {children}
      </>
    );
  }

  if (types.includes(user.type)) {
    return (
      <>
        <Outlet />
        {children}
      </>
    );
  } else {
    return <Navigate to="/" />;
  }
};
