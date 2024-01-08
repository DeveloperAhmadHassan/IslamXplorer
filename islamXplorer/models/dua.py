class Dua:
    def __init__(self, duaID, title, englishText, arabicText, transliteration, explanation, surah, verses, types):
        self.id = duaID
        self.englishText = englishText
        self.arabicText = arabicText
        self.title = title
        self.explanation = explanation
        self.transliteration = transliteration
        self.surah = surah
        self.verses = verses
        self.types = types

    @property
    def __str__(self):
        return "id: " + self.id

    def __repr__(self):
        return self.__str__

    def to_dict(self):
        return {
            "duaID": self.id,
            "arabicText": self.arabicText,
            "englishText": self.englishText,
            "transliteration": self.transliteration,
            "surah": self.surah,
            "verses": self.verses,
            "explanation": self.explanation,
            "title": self.title,
            "types": self.types,
        }

    # TODO:Setters and Getters for attributes