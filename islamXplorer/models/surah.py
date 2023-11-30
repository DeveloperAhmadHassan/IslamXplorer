class Surah:
    def __init__(self, name, number, revealedIn):
        self.name = name
        self.number = number
        self.revealedIn = revealedIn
        self.verses = []

    def setVerses(self, verses):
        self.verses = verses

    @property
    def __str__(self):
        return "name: " + self.name

    def __repr__(self):
        return self.__str__

    def to_dict(self):
        return {
            "name": self.name,
            "number": self.number,
            "revealedIn": self.revealedIn,
            "verses": [verse.to_dict() for verse in self.verses]
        }

    # TODO:Setters and Getters for attributes
