import React, { useState } from 'react';
import { TextField, Button, Container, Grid, Typography, Avatar } from '@mui/material';

function AvatarComponent(props) {
  const [selectedImage, setSelectedImage] = useState(props.user ? props.user.photoUrl : "/k.jpg");
  const [showText, setShowText] = useState(false);

  const handleImageChange = (event) => {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = () => {
        setSelectedImage(reader.result);
        props.setImage(reader.result);
      };
      reader.readAsDataURL(file);
    }
    setShowText(true);
  };

  return (
    <Grid item xs={12}>
      <label htmlFor="avatar-input">
      <Avatar
        alt=""
        src={selectedImage}
        className={'avatar profile-cont'}
      />
      </label>
      <input
        id="avatar-input"
        type="file"
        accept="image/*"
        style={{ display: 'none' }}
        onChange={handleImageChange}
      />
      {showText && <p>The selected image will only be set with the form. It will not change your profile image</p>}
    </Grid>
  );
}

export default AvatarComponent;
