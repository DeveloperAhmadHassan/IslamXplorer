import { signInWithEmailAndPassword } from "firebase/auth";
import { useState } from "react";
import { useNavigate } from "react-router-dom"; // Correct import
import { auth } from "../firebase";

const loginByEmailAndPassword = (email, password, setAuth) => {
    const navigate = useNavigate(); // Use useNavigate hook to get the navigate function
    // const location = useLocation();
    // const from = location.state?.from?.pathname || "/";
    console.log("Inside Logging In 1...");

    // event.preventDefault();
    signInWithEmailAndPassword(auth, email, password)
    .then((userCredential) => {
        console.log("Inside Logging In 2...");
        // Signed in
        const user = userCredential.user;
        navigate("/services"); // Use navigate function here
        console.log(user);
        setAuth(true);
        return;
        // navigate(from, { replace: true });
    })
    .catch((error) => {
        // const errorCode = error.code;
        // const errorMessage = error.message;
        console.log(error);
    });  
}

export { loginByEmailAndPassword };
