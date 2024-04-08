import { useState, useEffect } from 'react';

const useChapters = (props) => {
  const [chapterOptions, setChapterOptions] = useState([]);
  const [isLoadingChapters, setIsLoadingChapters] = useState(true);

  useEffect(() => {
    console.log(props.source);
    setIsLoadingChapters(true);
      const apiUrl = `http://192.168.56.1:48275/hadith-sources?source=${props.source}`;

      fetch(apiUrl)
        .then(response => response.json())
        .then(data => {
          const chapters = data.data;
          const options = chapters.map(item => ({
            value: item.chapterID.toString(),
            label: item.chapterID.toString()
        }));

          setChapterOptions(options);
          setIsLoadingChapters(false);
        })
        .catch(error => {
          console.error('Error fetching data:', error);
          setIsLoadingChapters(false);
        });
  }, [props.source]);

  return { chapterOptions, isLoadingChapters };
}

export default useChapters;
