class GoogleResult:
    def __init__(self, resID, title, link):
        self.resID = resID
        self.title = title
        self.link = link

    @property
    def __str__(self):
        return "title: " + self.title

    def __repr__(self):
        return self.__str__

    def toEmbeddingsStr(self):
        return {
            "id": self.resID,
            "type": "google"
        }

    def to_dict(self, embeddings=False):
        res_dict = {
            "type": "google",
            "ID": self.resID,
            "title": self.title,
            "link": self.link,
        }

        return res_dict
