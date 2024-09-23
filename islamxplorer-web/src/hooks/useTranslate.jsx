import { useState, useEffect } from 'react';

const API_KEY = 'AIzaSyBYysZJWoaIOUKHUMKyES6HUbtkV0WDCk0';
const API_URL = 'https://translation.googleapis.com/language/translate/v2';

const useTranslate = (text) => {
  const [translatedText, setTranslatedText] = useState('');
  const [error, setError] = useState(null);

  useEffect(() => {
    const translateText = async () => {
      try {
        const response = await fetch(`${API_URL}?key=${API_KEY}`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            q: text,
            target: 'en', // Target language set to English
            source: 'ur'  // Source language set to Urdu
          }),
        });

        if (!response.ok) {
          throw new Error('Error translating text');
        }

        const data = await response.json();
        setTranslatedText(data.data.translations[0].translatedText);
      } catch (err) {
        setError(err.message);
      }
    };

    if (text) {
      translateText();
    }
  }, [text]);

  return { translatedText, error };
};

export default useTranslate;
