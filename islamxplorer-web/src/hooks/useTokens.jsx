import { useState, useEffect } from 'react';
import { collection, getDocs } from 'firebase/firestore';
import { db } from '../firebase'; // Assuming you have exported your Firestore instance

const useTokens = () => {
  const [rows, setRows] = useState([]);
  const [loading, setLoading] = useState(true);

  function parseDateString(timestamp) {
    try {
      if (!timestamp || typeof timestamp.toDate !== 'function') {
        throw new Error('Invalid timestamp object.');
      }
  
      const date = timestamp.toDate();
      return date;
    } catch (error) {
      console.error('Error parsing timestamp object:', error);
      return null; 
    }
  }
  

  useEffect(() => {
    const fetchTokens = async () => {
      try {
        const tokensCollection = collection(db, 'Tokens');
        const tokensSnapshot = await getDocs(tokensCollection);
        const tokensData = tokensSnapshot.docs.map(doc => {
          const data = doc.data();
          const createdDate = data.created ? parseDateString(data.created) : null;
          const expiryDate = data.expiry ? parseDateString(data.expiry) : null;

          return {
            id: doc.id,
            name: data.name,
            token: data.token,
            created: data.createdOn,
            expiry: data.expiresOn
          };
        });

        setRows(tokensData);
        setLoading(false);
      } catch (error) {
        console.error('Error fetching tokens:', error);
        setLoading(false);
      }
    };

    fetchTokens();
  }, []); 

  return [rows, setRows, loading];
};

export default useTokens;
