class Verse:
    def __init__(self, verseID, englishText, arabicText, surah, surahNumber):
        self.id = verseID
        self.englishText = englishText
        self.arabicText = arabicText
        self.surah = surah
        self.surahNumber = surahNumber

    @property
    def __str__(self):
        return "id: " + self.id

    def __repr__(self):
        return self.__str__

    def to_dict(self):
        return {
            "type": "verse",
            "verseID": self.id,
            "arabicText": self.arabicText,
            "englishText": self.englishText,
            "surahName": self.surah,
            "surahNumber": self.surahNumber
        }
