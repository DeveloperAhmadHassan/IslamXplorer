import React, { useEffect, useState } from 'react';
import { collection, getDocs } from 'firebase/firestore';
import ScholarCard from './ScholarCard'; // Import your ScholarCard component
import { db } from '../../firebase';
import { Typography } from '@mui/material';

const ScholarCardList = (props) => {
  const [scholars, setScholars] = useState([]);

  useEffect(() => {
    const fetchScholars = async () => {
      try {
        const querySnapshot = await getDocs(collection(db, 'ScholarApplications'));
        const scholarData = [];
        querySnapshot.forEach((doc) => {
          const { name, email, profilePhoto, uid, id } = doc.data();
          scholarData.push({ name, email, profilePhoto, uid, id });
        });
        setScholars(scholarData);
      } catch (error) {
        console.error('Error fetching scholars:', error);
      }
    };
    fetchScholars();
  }, []); 

  const removeFromList = (index) => {
    setScholars(prevScholars => {
      const updatedScholars = prevScholars.filter((scholar, i) => i !== index);
      return updatedScholars;
    });
  };

  return (
    <>
        {scholars.length !== 0 && 
        <Typography variant='h3'>
            Scholar Applications
        </Typography>}
    <div className={'scholar-card-list'}>
    
      {scholars.map((scholar, index) => (
        <ScholarCard 
            key={index}
            index={index} 
            name={scholar.name} 
            email={scholar.email} 
            imageUrl={scholar.profilePhoto} 
            uid={scholar.uid} id={scholar.id} 
            approveScholar={props.approveScholar}
            disapproveScholar={props.disapproveScholar}
            removeFromList={removeFromList}
        />
      ))}
    </div>
    </>
  );
};

export default ScholarCardList;
