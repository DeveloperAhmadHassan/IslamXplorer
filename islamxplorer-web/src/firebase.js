// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getAuth } from "firebase/auth";
import { getFirestore, collection, getDocs} from "firebase/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyCjmUePETT4kz7XjamG8lG1X4KbCM77E5g",
  authDomain: "islamxplorer.firebaseapp.com",
  databaseURL: "https://islamxplorer-default-rtdb.firebaseio.com",
  projectId: "islamxplorer",
  storageBucket: "islamxplorer.appspot.com",
  messagingSenderId: "89245412373",
  appId: "1:89245412373:web:04871895fc6a3c7719f21c",
  measurementId: "G-T73VBNH18T"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

const analytics = getAnalytics(app);

export const auth = getAuth(app);

export const db = getFirestore(app);

// export const collection = collection;
// export const getDocs = getDocs;

export default app;