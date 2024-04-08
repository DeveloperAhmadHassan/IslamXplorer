import { useState, useEffect } from 'react';

const useVerses = (props) => {
  const [verseOptions, setVerseOptions] = useState([]);
  const [isLoadingVerses, setIsLoadingVerses] = useState(true);

  useEffect(() => {
    console.log(props.id);
      setIsLoadingVerses(true);
      const apiUrl = `http://192.168.56.1:48275/surahs?id=${props.id}`;

      fetch(apiUrl)
        .then(response => response.json())
        .then(data => {
          console.log(data);
          const surah = data.data[0];
          console.log(surah);
          const verses = surah.verses;
          console.log(verses);
          const options = verses.map(item => ({
              value: item.verseID.toString(),
              label: item.englishText.toString(),
          }));

          setVerseOptions(options);
          setIsLoadingVerses(false);
        })
        .catch(error => {
          console.error('Error fetching data:', error);
          setIsLoadingVerses(false);
        });
  }, [props.id]);

  return { verseOptions, isLoadingVerses };
}

export default useVerses;
