import React, { useState } from 'react';
import { TextField, Button, Container, Grid, Typography, Avatar } from '@mui/material';
// import './styles.scss';

import { useTheme } from '@mui/material/styles';
import Box from '@mui/material/Box';
import OutlinedInput from '@mui/material/OutlinedInput';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';
import Chip from '@mui/material/Chip';
import { db, storage } from '../../../firebase';
import { addDoc, collection, doc, updateDoc } from 'firebase/firestore';
import { array, date, object, string, union } from 'zod';
import { useAuth } from '../../../hooks/useAuth';
import AvatarComponent from './AvatarComponent';

import { getDownloadURL, getStorage, ref, uploadString } from "firebase/storage";


const ITEM_HEIGHT = 48;
const ITEM_PADDING_TOP = 8;
const MenuProps = {
  PaperProps: {
    style: {
      maxHeight: ITEM_HEIGHT * 4.5 + ITEM_PADDING_TOP,
      width: 250,
    },
  },
};

const isOver18 = (dateString) => {
  const today = new Date();
  const birthDate = new Date(dateString);
  const age = today.getFullYear() - birthDate.getFullYear();
  const monthDiff = today.getMonth() - birthDate.getMonth();
  if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
    return age - 1;
  }
  return age;
};

const schema = object({
  image: union([
    string().url(), // Accepts valid URLs
    string(), // Accepts other string types (e.g., base64 encoded image)
    object() // Accepts other image data types
  ]), // Modify the min and max lengths as needed
  name: string().min(2).max(50),
  email: string().email(),
  phone: string().min(6),
  dateOfBirth: string().transform((val) => new Date(val)).refine((val) => isOver18(val) >= 18, {
    message: 'Age must be 18 or over',
  }),
  languages: array(string()),
  skills: string().min(2),
  qualifications: string().min(2)
});


const names = [
  'English',
  'Arabic',
  'Urdu',
  'French',
  'Persian',
  'Turkish',
  'Indonesian',
  'German',
  'Kurdish',
  'Bengali',
];

function getStyles(name, personName, theme) {
  return {
    fontWeight:
      personName.indexOf(name) === -1
        ? theme.typography.fontWeightRegular
        : theme.typography.fontWeightMedium,
  };
}

export const ScholarForm = () => {
  const {user} = useAuth();

  console.log(user);
  
  const [formData, setFormData] = useState({
    image:'',
    name: '',
    email: '',
    phone: '',
    dateOfBirth: '',
    languages: '',
    skills: '',
    qualifications: ''
  });

  const setImage = (image) => {
    setFormData(prevState => ({
      ...prevState,
      image: image
    }));
  };

  const [errors, setErrors] = useState({});

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prevState => ({
      ...prevState,
      [name]: value
    }));
  };

  console.log(formData);

  
  const handleSubmit = async (e) => {
    e.preventDefault();
    const storage = getStorage();
  
    try {
      schema.parse(formData);


  
      let imageUrl = '';
      if (formData.image) {
        try {
          const storage = getStorage();
          const storageRef = ref(storage, `Users/Images/ScholarForms/${user.uid}`);
          const snapshot = await uploadString(storageRef, formData.image, 'data_url');
          imageUrl = await getDownloadURL(snapshot.ref);
          console.log('File available at', imageUrl);
        } catch (error) {
          console.error('Error uploading image:', error);
        }
      }

      let { image, ...dataToSave } = formData;

      dataToSave = { ...dataToSave, profilePhoto: imageUrl, uid: user.uid };

      const docRef = await addDoc(collection(db, 'ScholarApplications'), dataToSave);
      console.log("Document written with ID: ", docRef.id);

      const newDocId = docRef.id;

      await updateDoc(doc(db, 'ScholarApplications', newDocId), { id: newDocId });
      console.log("Document updated with additional field 'id'");

      setErrors({});
    } catch (error) {
      console.error("Validation error: ", error.errors); 
  
      if (error.errors && Array.isArray(error.errors)) {
        const formattedErrors = error.errors.reduce((acc, curr) => {
          acc[curr.path[0]] = curr.message;
          return acc;
        }, {});
        setErrors(formattedErrors);
      } else {
        console.error("Unhandled error: ", error);
      }
    }
  };
  

  const theme = useTheme();
  const [languages, setLanguages] = useState([]);

  const handleChipChange = (event) => {
    const {
      target: { value },
    } = event;
    setLanguages(
      // On autofill we get a stringified value.
      typeof value === 'string' ? value.split(',') : value,
    );
    formData.languages = languages;
  };

  return (
    <Container maxWidth="sm" className={'content'}>
      <Typography variant="h4" align="center" gutterBottom>
        Scholar Application Form
      </Typography>
      <FormControl onSubmit={handleSubmit}>
        
        <Grid container spacing={2}>
          <Grid item xs={12}>
            <AvatarComponent user={user} setImage={setImage}/>
          </Grid>
          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Name"
              name="name"
              value={formData.name}
              onChange={handleChange}
              required
              error={!!errors['name']}
              helperText={errors['name']}
            />
          </Grid>
          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Email"
              name="email"
              type="email"
              value={formData.email}
              onChange={handleChange}
              required
              error={!!errors['email']}
              helperText={errors['email']}
            />
          </Grid>
          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Phone"
              name="phone"
              type="tel"
              value={formData.phone}
              onChange={handleChange}
              required
              error={!!errors['phone']}
              helperText={errors['phone']}
            />
          </Grid>
          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Date of Birth"
              name="dateOfBirth"
              type="date"
              value={formData.dateOfBirth}
              onChange={handleChange}
              required
              error={!!errors['dateOfBirth']}
              helperText={errors['dateOfBirth']}
            />
          </Grid>
          <Grid item xs={12}>
            <Select
              fullWidth
              label="Language"
              labelId="demo-multiple-chip-label"
              id="demo-multiple-chip"
              multiple
              value={languages}
              onChange={handleChipChange}
              error={!!errors['languages']}
              helperText={errors['languages']}
              input={<OutlinedInput id="select-multiple-chip" label="Language" />}
              renderValue={(selected) => (
                <Box sx={{ display: 'flex', flexWrap: 'wrap', gap: 0.5 }}>
                  {selected.map((value) => (
                    <Chip key={value} label={value} />
                  ))}
                </Box>
              )}
              MenuProps={MenuProps}
            >
              {names.map((name) => (
                <MenuItem
                  key={name}
                  value={name}
                  style={getStyles(name, languages, theme)}
                >
                  {name}
                </MenuItem>
              ))}
            </Select>
          </Grid>
          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Skills"
              name="skills"
              value={formData.skills}
              onChange={handleChange}
              required
              error={!!errors['skills']}
              helperText={errors['skills']}
            />
          </Grid>
          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Qualifications"
              name="qualifications"
              multiline
              rows={4}
              value={formData.qualifications}
              onChange={handleChange}
              required
              error={!!errors['skills']}
              helperText={errors['skills']}
            />
          </Grid>
          <Grid item xs={12}>
            <Button type="submit" variant="contained" color="primary" fullWidth onClick={(event)=>handleSubmit(event)}>
              Submit
            </Button>
          </Grid>
        </Grid>
      </FormControl>
    </Container>
  );
}