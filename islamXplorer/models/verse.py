class Verse:
    def __init__(self, verseID, englishText, arabicText):
        self.id = verseID
        self.englishText = englishText
        self.arabicText = arabicText

    @property
    def __str__(self):
        return "id: " + self.id

    def __repr__(self):
        return self.__str__

    def to_dict(self):
        return {
            "verseID": self.id,
            "arabicText": self.arabicText,
            "englishText": self.englishText
        }

    # TODO:Setters and Getters for attributes