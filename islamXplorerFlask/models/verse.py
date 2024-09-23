class Verse:
    def __init__(self,
                 verseID,
                 englishText,
                 arabicText,
                 embeddings=None,
                 surah=None,
                 surahNumber=None,
                 uid=None,
                 verseNumber=None,
                 audioLink=None,
                 arabicTextSimple=None,
                 pageNumber=None,
                 juzNumber=None,
                 resource=None):
        self.id = verseID
        self.englishText = englishText
        self.arabicText = arabicText
        self.surah = surah
        self.embeddings = embeddings
        self.surahNumber = surahNumber
        self.uid = uid
        self.verseNumber = verseNumber
        self.audioLink = audioLink
        self.arabicTextSimple = arabicTextSimple
        self.pageNumber = pageNumber
        self.juzNumber = juzNumber
        self.resource = resource

    @property
    def __str__(self):
        return "verseID: " + self.id

    def __repr__(self):
        return self.__str__

    def toEmbeddingsStr(self):
        return {
            "id": self.id,
            "type": "Verse",
            "embeddings": self.embeddings
        }

    def to_dict(self, embeddings=False):
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
        if self.embeddings is not None and embeddings:
            verse_dict["embeddings"] = self.embeddings

        if self.audioLink is not None:
            verse_dict["audioLink"] = self.audioLink
            verse_dict["verseNumber"] = self.verseNumber
            verse_dict["arabicTextSimple"] = self.arabicTextSimple
            verse_dict["resource"] = self.resource

        return verse_dict
