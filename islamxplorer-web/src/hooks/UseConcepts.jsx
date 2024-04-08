import { useState, useEffect } from 'react';

const useConcepts = (props) => {
  const [conceptOptions, setConceptOptions] = useState([]);
  const [isLoadingConcepts, setIsLoadingConcepts] = useState(true);

  useEffect(() => {
      setIsLoadingConcepts(true);
      const apiUrl = `http://192.168.56.1:48275/concepts?type=${props.id}`;

      fetch(apiUrl)
        .then(response => response.json())
        .then(data => {
          const topic = data.data;
          const concepts = topic[0].concepts;

          const options = concepts.map(item => ({
              value: item.topicID.toString(),
              label: item.name.toString(),
          }));

          setConceptOptions(options);
          setIsLoadingConcepts(false);
        })
        .catch(error => {
          console.error('Error fetching data:', error);
          setIsLoadingConcepts(false);
        });
  }, [props.id]);

  return { conceptOptions, isLoadingConcepts };
}

export default useConcepts;
