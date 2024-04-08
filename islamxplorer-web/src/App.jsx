import { Route, Routes } from "react-router-dom";
import "./App.scss";
import { Navbar } from "./components/navBar/NavBar";
import { Contact, Home, Services, AddVerse, Secret, Ontologies, Dummy, AddSurah, AddOntology, ApiTokens } from "./pages";
import Login from "./pages/authPages/Login";
import Signup from "./pages/authPages/Signup";
import { useContext, useState } from "react";
import { Navigate, useLocation, useNavigate } from "react-router-dom";
import { UserProvider, useUser } from "./contexts/userContext";
import { AuthProvider } from "./hooks/useAuth";
import { ProtectedRoute } from "./ProtectedRoute";
import { HomeLayout } from "./HomeLayout";
import { ProtectedLayout } from "./ProtectedLayout";
import Footer from "./components/footer/Footer";


function App() {
  const [auth, setAuth] = useState(false);
  const location = useLocation();
  // const { user } = useUser();

  // console.log("User in App component:", user); 

  return (
    <AuthProvider>
      <div className="App">
      {location.pathname !== '/login' && location.pathname !== '/signup' && <Navbar />}
        <main>
          <Routes>

            <Route path='/' element={<ProtectedLayout />}>
              <Route index element={<Home setAuth={setAuth}/>} />
              <Route path='contact' element={<Contact setAuth={setAuth}/>} />
              <Route path="about" element={<Ontologies setAuth={setAuth}/>} />
              <Route path="tokens" element={<ApiTokens />} />
            </Route>

            <Route path="/login" element={<Login />} />
            <Route path="/signup" element={<Signup />} />

            <Route path="/services" element={<ProtectedLayout />}>
              <Route index element={<Services setAuth={setAuth}/>} />
              <Route path="contact" element={<Contact setAuth={setAuth}/>} />
              <Route path="add-verse" element={<AddVerse setAuth={setAuth}/>} />
              <Route path="add-surah" element={<AddSurah setAuth={setAuth}/>} />
              <Route path="add-ontology" element={<AddOntology setAuth={setAuth}/>} />
            </Route>
            <Route path='/secret' element={<Secret />} />

            <Route path='/dummy' element={<Dummy />} />
            
          </Routes>
        </main>
        {location.pathname !== '/login' && location.pathname !== '/signup' && <Footer />}
      </div>
    </AuthProvider>
  );
}

export default App;