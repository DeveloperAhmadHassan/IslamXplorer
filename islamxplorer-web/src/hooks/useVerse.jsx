import { useState, useEffect } from 'react';

const useVerse = (id) => {
  const [item, setItem] = useState([]);
  const [isLoadingItem, setIsLoadingItem] = useState(true);
  const [error, setError] = useState(false);

  useEffect(() => {
    setIsLoadingItem(true);
    setError(false);

    let apiUrl = `http://192.168.56.1:48275/verses?verseID=${id}`;

    fetch(apiUrl)
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      })
      .then(data => {
        const itemData = data.data[0];
        // if (itemData === undefined || itemData === null{
        //   setIsLoadingItem(false);
        //   setError(true);
        //   return { item, isLoadingItem, error };
        // })
        console.log(itemData);
        setItem({
          id: itemData.verseID.toString(),
          englishText: itemData.englishText.toString(),
          arabicText: itemData.arabicText.toString(),
          source: itemData.source.toString(),
          verseNumber: itemData.verseNumber.toString(),
          audioLink: itemData.audioLink.toString()
        });
        setIsLoadingItem(false);
      })
      .catch(error => {
        console.error('Error fetching data:', error);
        setError(true);
        setIsLoadingItem(false);
      });
  }, [id]);

  return [ item, isLoadingItem, error ];
};

export default useVerse;