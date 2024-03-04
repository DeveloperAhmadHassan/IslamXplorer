class Verse:
    def __init__(self, verseID, englishText, arabicText, surah=None, surahNumber=None):
        self.id = verseID
        self.englishText = englishText
        self.arabicText = arabicText
        self.surah = surah
        self.surahNumber = surahNumber

    @property
    def __str__(self):
        return "verseID: " + self.id

    def __repr__(self):
        return self.__str__

    def to_dict(self):
        verse_dict = {
            "type": "verse",
            "verseID": self.id,
            "arabicText": self.arabicText,
            "englishText": self.englishText,
        }
        if self.surah is not None:
            verse_dict["source"] = self.surah
        if self.surahNumber is not None:
            verse_dict["surahNumber"] = self.surahNumber
        return verse_dict
