import React, { useState, useEffect } from 'react';
import useTranslate from './useTranslate';

const useResults = (query) => {
  const [results, setResults] = useState([]);
  const [metaData, setMetaData] = useState({});
  const [isLoadingResults, setIsLoadingResults] = useState(true);
  const [error, setError] = useState(false);
  const { translatedText, error: translateError } = useTranslate(query);

  useEffect(() => {
    const fetchData = async () => {
      setError(false);
      setIsLoadingResults(true);

      let fetchQuery = query;

      // Use translated text if translation error is not present
      if (translatedText && !translateError) {
        fetchQuery = translatedText;
        console.log(fetchQuery);
      }

      try {
        const response = await fetch(`http://192.168.56.1:48275/results?q=${fetchQuery}`);
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        const fetchedData = await response.json();
        var microseconds = fetchedData.timeTaken;
        var timeTaken = microseconds / 100;
        timeTaken = timeTaken + 2.4;

        console.log(fetchedData.cipher.toString());

        setMetaData({
          cipher: fetchedData.cipher.toString(),
          timeTaken: timeTaken.toString(),
          total: fetchedData.totalResults.total.toString()
        });

        const data = fetchedData.data;

        console.log(data);

        const sortedResults = data.map(item => ({
          id: item.type === 'google' ? item.ID.toString() : item.type === 'hadith' ? item.hadithID.toString() : item.verseID.toString(),
          type: item.type,
          title: item.type === 'google' ? item.title.toString() : item.arabicText.toString(),
          subtitle: item.type === 'google' ? item.link.toString() : item.englishText.toString()
        }));
        setResults(sortedResults);
        setIsLoadingResults(false);
      } catch (error) {
        console.error('Error fetching data:', error);
        setIsLoadingResults(false);
        setError(true);
      }
    };

    if (query) {
      fetchData();
    }

    return () => {};
  }, [query, translatedText, translateError]);

  return { results, metaData, isLoadingResults, error };
};

export default useResults;
