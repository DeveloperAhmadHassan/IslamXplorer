// UserContext.js
import { createContext, useContext, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom/dist';

const UserContext = createContext();

export const UserProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const navigate = useNavigate();

  const login = async (userData) => {
    setUser(userData); 
    navigate("/services");
    // Update user state upon login
  };

  const logout = () => {
    setUser(null); // Clear user state upon logout
  };

  const value = useMemo(
    () => ({
      user,
      login,
      logout,
    }),
    [user]
  );

  return (
    <UserContext.Provider value={{ user, login, logout }}>
      {children}
    </UserContext.Provider>
  );
};

export const useUser = () => {
  return useContext(UserContext);
};
