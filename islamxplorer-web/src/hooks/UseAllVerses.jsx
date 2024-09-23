import React, { useState, useEffect } from 'react';

const useAllVerses = (url) => {
  const [data, setData] = useState([]);
  const [isLoadingVerses, setIsLoadingVerses] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(url);
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        const fetchedData = await response.json();
        setData(fetchedData.data);
        setIsLoadingVerses(false);
      } catch (error) {
        console.error('Error fetching data:', error);
        setIsLoadingVerses(false);
      }
    };

    fetchData();

    return () => {
     
    };
  }, [url]); 

  return {data, isLoadingVerses};
};

export default useAllVerses;