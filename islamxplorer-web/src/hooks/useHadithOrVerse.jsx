import { useState, useEffect } from 'react';

const useHadithOrVerse = (type, id) => {
  const [item, setItem] = useState([]);
  const [isLoadingItem, setIsLoadingItem] = useState(true);
  const [error, setError] = useState(false);

  useEffect(() => {
    setIsLoadingItem(true);
    setError(false);

    let apiUrl = null;
    if (type === 'verse') {
      apiUrl = `http://192.168.56.1:48275/verses?verseID=${id}`;
    } else if (type === 'hadith') {
      apiUrl = `http://192.168.56.1:48275/hadiths?hadithID=${id}`;
    } else {
      setError(true);
      setIsLoadingItem(false);
      return;
    }

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
          id: type === 'verse' ? itemData.verseID.toString() : itemData.hadithID.toString(),
          englishText: itemData.englishText.toString(),
          arabicText: itemData.arabicText.toString(),
          source: itemData.source.toString(),
        });
        setIsLoadingItem(false);
      })
      .catch(error => {
        console.error('Error fetching data:', error);
        setError(true);
        setIsLoadingItem(false);
      });
  }, [id, type]);

  return { item, isLoadingItem, error };
};

export default useHadithOrVerse;