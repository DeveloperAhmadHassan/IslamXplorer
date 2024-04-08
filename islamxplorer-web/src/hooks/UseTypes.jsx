import { useState, useEffect } from 'react';

const useTypes = () => {
  const [typeOptions, setTypeOptions] = useState([]);
  const [isLoadingTypes, setIsLoadingTypes] = useState(true);

  useEffect(() => {
      setIsLoadingTypes(true);
      const apiUrl = `http://192.168.56.1:48275/types`;

      fetch(apiUrl)
        .then(response => response.json())
        .then(data => {
          const types = data.data;
          console.log(types);
          const options = types.map(item => ({
              value: item.topicID.toString(),
              label: item.name.toString(),
          }));

          console.log(options);

          setTypeOptions(options);
          setIsLoadingTypes(false);
        })
        .catch(error => {
          console.error('Error fetching data:', error);
          setIsLoadingTypes(false);
        });
  },[]);

  return { typeOptions, isLoadingTypes };
}

export default useTypes;
