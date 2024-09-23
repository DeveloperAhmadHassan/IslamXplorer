import { createContext, useContext, useMemo } from "react";
import { useNavigate } from "react-router-dom";
import { useLocalStorage } from "./useLocalStorage";

import app, { db } from '../firebase';
import { getFirestore, collection, query, where, getDocs, addDoc, doc, updateDoc, arrayUnion, writeBatch, deleteDoc, getDoc } from "firebase/firestore";

const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useLocalStorage("user", null);
  const navigate = useNavigate();

  const login = async (data) => {
    const { uid } = data;
    try {
        const userDoc = doc(db, "Users", uid);
        const userDocRef = await getDoc(userDoc);
        if (userDocRef.exists()) {
          const userData = userDocRef.data();
          data.photoUrl = userData.profileImage;
          data.type = userData.type;
          setUser(data);
          navigate("/");
        } else {
          console.log("User document does not exist");
      }
    } catch (error) {
        console.error("Error retrieving user data:", error);
    }
  };


  const logout = () => {
    setUser(null);
    navigate("/login", { replace: true });
  };

  const value = useMemo(
    () => ({
      user,
      login,
      logout,
    }),
    [user]
  );
  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
};

export const useAuth = () => {
  return useContext(AuthContext);
};