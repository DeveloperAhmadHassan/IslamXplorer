import React, { useState, useEffect } from 'react';

const useResults = (query) => {
  const [results, setResults] = useState([]);
  const [isLoadingResults, setIsLoadingResults] = useState(true);
  const [error, setError] = useState(false);

  useEffect(() => {
    const fetchData = async () => {
      setError(false);
      try {
        const response = await fetch(`http://192.168.56.1:48275/results?q=${query}`);
        if (!response.ok) {
          // setError(true);
          // setIsLoadingResults(false);
          throw new Error('Network response was not ok');
        }
        const fetchedData = await response.json();
        const data = fetchedData.data;

        console.log(data);

        const sortedResults = data.map(item => ({
            id: item.type ==='hadith' ? item.hadithID.toString() : item.verseID.toString(),
            type: item.type,
            arabicText: item.arabicText.toString(),
            englishText: item.englishText.toString()
        }));
        setResults(sortedResults);
        setIsLoadingResults(false);
      } catch (error) {
        console.error('Error fetching data:', error);
        setIsLoadingResults(false);
        // setError(true);
      }
    };

    fetchData();

    return () => {
     
    };
  }, [query]); 

  return {results, isLoadingResults, error};
};

export default useResults;