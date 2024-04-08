import React, { useState, useEffect } from 'react';

const useOnt = (url) => {
  const [data, setData] = useState([]);
  const [isLoadingOnt, setIsLoadingOnt] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch(url);
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        const fetchedData = await response.json();
        setData(fetchedData.data);
        setIsLoadingOnt(false);
      } catch (error) {
        console.error('Error fetching data:', error);
        setIsLoadingOnt(false);
      }
    };

    fetchData();

    return () => {
     
    };
  }, [url]); 

  return {data, isLoadingOnt};
};

export default useOnt;