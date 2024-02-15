class Topic:
    def __init__(self, name, identifier, concepts=None):
        self.name = name
        self.identifier = identifier
        self.concepts = concepts or []

    def setConcepts(self, concepts):
        self.concepts = concepts

    def __str__(self):
        return "name: " + self.name

    def __repr__(self):
        return self.__str__

    def to_dict(self):
        topic_dict = {
            "id": self.identifier,
            "name": self.name,
        }

        if self.concepts:
            topic_dict["concepts"] = [topic.to_dict() for topic in self.concepts]
        return topic_dict

