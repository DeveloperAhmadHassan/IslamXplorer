class Hadith:
    def __init__(self, hadithID, hadithNo=None, englishText=None, arabicText=None, source=None, narratedBy=None):
        self.id = hadithID
        self.hadithNo = hadithNo
        self.englishText = englishText
        self.arabicText = arabicText
        self.source = source
        self.narratedBy = narratedBy

    @property
    def __str__(self):
        return "verseID: " + self.id

    def __repr__(self):
        return self.__str__

    def to_dict(self):
        return {
            "type": "hadith",
            "verseID": self.id,
            "hadithNo": self.hadithNo,
            "arabicText": self.arabicText,
            "englishText": self.englishText,
            "source": self.source,
            "narratedBy": self.narratedBy
        }

    # TODO:Setters and Getters for attributes