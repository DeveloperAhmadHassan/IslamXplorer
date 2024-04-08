import { useState, useEffect } from 'react';

const useHadith = (props) => {
  const [hadithOptions, setHadithOptions] = useState([]);
  const [isLoadingHadiths, setIsLoadingHadiths] = useState(true);

  useEffect(() => {
    setIsLoadingHadiths(true);
    const apiUrl = `http://192.168.56.1:48275/hadiths?chapter=${props.chapter}`;

    fetch(apiUrl)
      .then(response => response.json())
      .then(data => {
        const hadiths = data.data;
        const options = hadiths.map(item => ({
            value: item.hadithID.toString(),
            label: item.englishText.toString(),
        }));

        setHadithOptions(options);
        setIsLoadingHadiths(false);
      })
      .catch(error => {
        console.error('Error fetching data:', error);
        setIsLoadingHadiths(false);
      });
  }, [props.chapter]);

  return { hadithOptions: hadithOptions, isLoadingHadiths: isLoadingHadiths };
}

export default useHadith;
