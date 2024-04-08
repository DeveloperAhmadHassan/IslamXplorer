import { useState, useEffect } from 'react';

const useSources = () => {
    const [sourceOptions, setsourceOptions] = useState([]);
    const [isLoadingSources, setIsLoadingSources] = useState(true);

    useEffect(() => {
        const apiUrl = 'http://192.168.56.1:48275/hadith-sources';

        fetch(apiUrl)
          .then(response => response.json())
          .then(data => {
            const sources = data.data;
            console.log(sources);
            const options = sources.map(item => ({
                value: item.sourceName.toString(),
                label: item.sourceName.toString()
            }));

            setsourceOptions(options);

            console.log(options);
            setIsLoadingSources(false);
          })
          .catch(error => {
            console.error('Error fetching data:', error);
            setIsLoadingSources(false);
          });
    }, []); 

    return { sourceOptions: sourceOptions, isLoadingSources };
}

export default useSources;
