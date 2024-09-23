class Hadith:
    def __init__(self, hadithID, hadithNo=None, englishText=None, embeddings=None, arabicText=None, source=None, narratedBy=None):
        self.id = hadithID
        self.hadithNo = hadithNo
        self.englishText = englishText
        self.arabicText = arabicText
        self.source = source
        self.embeddings = embeddings
        self.narratedBy = narratedBy

    @property
    def __str__(self):
        return "hadithID: " + self.id

    def __repr__(self):
        return self.__str__

    def toEmbeddingsStr(self):
        return {
            "id": self.id,
            "type": "Hadith",
            "embeddings": self.embeddings
        }

    def to_dict(self, embeddings=False):
        hadith_dict = {
            "type": "hadith",
            "hadithID": self.id,
            "arabicText": self.arabicText,
            "englishText": self.englishText,
        }

        if self.source is not None:
            hadith_dict["source"] = self.source
        if self.narratedBy is not None:
            hadith_dict["narratedBy"] = self.narratedBy

        if self.embeddings is not None and embeddings:
            hadith_dict["embeddings"] = self.embeddings

        return hadith_dict
