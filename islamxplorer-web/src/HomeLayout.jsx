import { Navigate, Outlet } from "react-router-dom";
import { useAuth } from "./hooks/useAuth";
import { Link } from "react-router-dom/dist";

export const HomeLayout = () => {
//   const { user } = useAuth();

//   if (user) {
//     return <Navigate to="/dashboard/profile" />;
//   }

  return (
    <div>
      <nav>
        <Link to="/">Home</Link>
        <Link to="/login">Login</Link>
      </nav>
      <Outlet />
    </div>
  )
};