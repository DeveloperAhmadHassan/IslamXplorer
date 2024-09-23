import { Route, Routes } from "react-router-dom";
import "./App.scss";
import { Navbar } from "./components/navBar/NavBar";
import { Contact, Services, AddVerse, Secret, Ontologies, Dummy, AddSurah, AddOntology, ApiTokens, Verses, Hadiths, Surahs, SearchPage, ApplyForScholar, Home, SearchItemPage } from "./pages";
import Login from "./pages/authPages/Login";
import Signup from "./pages/authPages/Signup";
import { useContext, useState } from "react";
import { Navigate, useLocation, useNavigate } from "react-router-dom";
import { UserProvider, useUser } from "./contexts/userContext";
import { AuthProvider, useAuth } from "./hooks/useAuth";
import { HomeLayout } from "./HomeLayout";
import { ProtectedLayout } from "./ProtectedLayout";
import Footer from "./components/footer/Footer";
import { Profile } from "./pages/profilePages/Profile";
import { SnackbarProvider, useSnackbar } from 'notistack';


function App() {
  const [auth, setAuth] = useState(false);
  const location = useLocation();

  return (
    <SnackbarProvider>
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
              {/* <Route path="search" element={<SearchPage />} /> */}
              <Route path="search/:query?" element={<SearchPage />} />
              <Route path="search/item/:type?/:id?" element={<SearchItemPage />} />
              <Route path="profile" element={<Profile />} />
            </Route>

            <Route path="/login" element={<Login />} />
            <Route path="/signup" element={<Signup setAuth={setAuth}/>} />
            

            <Route path="/services" element={<ProtectedLayout types={['A' , 'S']}/>}>
              <Route index element={<Services setAuth={setAuth}/>} />
              <Route path="verses" element={<Verses />} />
              <Route path="hadiths" element={<Hadiths />} />
              <Route path="surahs" element={<Surahs />} />
              <Route path="ontologies" element={<Ontologies />} />
              <Route path="contact" element={<Contact setAuth={setAuth}/>} />
              <Route path="add-verse" element={<AddVerse setAuth={setAuth}/>} />
              <Route path="update-verse/:id" element={<AddVerse update={true}/>} />
              <Route path="add-surah" element={<AddSurah setAuth={setAuth}/>} />
              <Route path="add-ontology" element={<AddOntology setAuth={setAuth}/>} />
            </Route>

            <Route path="/profile" element={<ProtectedLayout />}>
              <Route path="apply" element={<ApplyForScholar />} />
              
            </Route>

            <Route path='/secret' element={<Secret />} />

            <Route path='/dummy' element={<Dummy />} />
            
          </Routes>
        </main>
        {location.pathname !== '/login' && location.pathname !== '/signup' && <Footer />}
      </div>
    </AuthProvider>
    </SnackbarProvider>
  );
}

export default App;