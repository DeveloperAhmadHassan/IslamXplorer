import React, { useState, useEffect } from 'react';

const useAllHadiths = (url) => {
  const [data, setData] = useState([]);
  const [isLoadingHadiths, setIsLoadingHadiths] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(url);
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        const fetchedData = await response.json();
        setData(fetchedData.data);
        setIsLoadingHadiths(false);
      } catch (error) {
        console.error('Error fetching data:', error);
        setIsLoadingHadiths(false);
      }
    };

    fetchData();

    return () => {
     
    };
  }, [url]); 

  return {data, isLoadingHadiths};
};

export default useAllHadiths;