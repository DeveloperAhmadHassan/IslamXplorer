import { useState, useEffect } from 'react';

const useSurahs = () => {
    const [surahOptions, setSurahOptions] = useState([]);
    const [isLoadingSurahs, setIsLoadingSurahs] = useState(true);

    useEffect(() => {
        const apiUrl = 'http://192.168.56.1:48275/surahs';

        fetch(apiUrl)
          .then(response => response.json())
          .then(data => {
            const surahs = data.data;
            console.log(surahs);
            const options = surahs.map(item => ({
                value: item.surahID.toString(),
                label: item.name
            }));

            setSurahOptions(options);

            console.log(options);
            setIsLoadingSurahs(false);
          })
          .catch(error => {
            console.error('Error fetching data:', error);
            setIsLoadingSurahs(false);
          });
    }, []); 

    return { surahOptions, isLoadingSurahs };
}

export default useSurahs;
