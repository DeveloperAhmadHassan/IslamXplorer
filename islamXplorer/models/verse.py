class Verse:
    def __init__(self, verseID, englishText, arabicText, surah):
        self.id = verseID
        self.englishText = englishText
        self.arabicText = arabicText
        self.surah = surah

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
            "surahName": self.surah
        }

    # TODO:Setters and Getters for attributes