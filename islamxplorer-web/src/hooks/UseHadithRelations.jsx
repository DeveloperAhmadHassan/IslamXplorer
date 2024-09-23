import { useState, useEffect } from 'react';

const useHadithRelations = (id) => {
  const [items, setItems] = useState([]);
  const [isLoadingItems, setIsLoadingItems] = useState(true);

  useEffect(() => {
    setIsLoadingItems(true);
    const apiUrl = `http://192.168.56.1:48275/hadith-relations?hadithID=${id}`;
    console.log(apiUrl);

    fetch(apiUrl)
      .then(response => response.json())
      .then(data => {
        const hadiths = data.data;
        console.log(hadiths);
        const options = hadiths.map(item => ({
          id: item.type ==='google' ? item.ID.toString() : item.type ==='hadith' ? item.hadithID.toString() : item.verseID.toString(),
          type: item.type,
          title: item.type === 'google' ? item.title.toString() : item.arabicText.toString(),
          subtitle:  item.type === 'google' ? item.link.toString() : item.englishText.toString()
        }));

        setItems(options);
        console.log(options);
        setIsLoadingItems(false);
      })
      .catch(error => {
        console.error('Error fetching data:', error);
        setIsLoadingItems(false);
      });
  }, [id]);

  return { items, isLoadingItems };
}

export default useHadithRelations;
