import React, { useState, useEffect } from 'react';

const useAllSurahs = (url) => {
  const [data, setData] = useState([]);
  const [isLoadingSurahs, setIsLoadingSurahs] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(url);
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        const fetchedData = await response.json();
        setData(fetchedData.data);
        setIsLoadingSurahs(false);
      } catch (error) {
        console.error('Error fetching data:', error);
        setIsLoadingSurahs(false);
      }
    };

    fetchData();

    return () => {
     
    };
  }, [url]); 

  return {data, isLoadingSurahs};
};

export default useAllSurahs;