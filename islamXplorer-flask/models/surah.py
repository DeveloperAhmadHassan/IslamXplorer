class Surah:
    def __init__(self, name, number, revealedIn=None, verses=None, totalVerses=None, euid=None):
        self.name = name
        self.number = number
        self.revealedIn = revealedIn
        self.verses = verses or []
        self.totalVerses = totalVerses
        self.euid = euid

    def setVerses(self, verses):
        self.verses = verses

    @property
    def __str__(self):
        return "name: " + self.name

    def __repr__(self):
        return self.__str__

    def to_dict(self):
        surah_dict = {
            "surahID": self.number,
            "name": self.name,
        }
        if self.revealedIn is not None:
            surah_dict["revealedIn"] = self.revealedIn
        if self.verses:
            surah_dict["verses"] = [verse.to_dict() for verse in self.verses]
        return surah_dict

    # TODO:Setters and Getters for attributes
