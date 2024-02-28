class Topic:
    def __init__(self, identifier, flag=True, name=None, concepts=None, relationships=None):
        self.id = identifier
        self.name = name
        self.concepts = concepts or []
        self.relationships = relationships or []
        self.flag = flag

    def setConcepts(self, concepts):
        self.concepts = concepts

    def __str__(self):
        return "id: " + self.id

    def __repr__(self):
        return self.__str__()

    def to_dict(self):
        topic_dict = {
            "id": self.id,
            "flag": self.flag
        }

        if self.name:
            topic_dict["name"] = self.name

        if self.concepts:
            topic_dict["totalConcepts"] = len(self.concepts)
            topic_dict["concepts"] = [topic.to_dict() for topic in self.concepts]

        if self.relationships:
            topic_dict["totalRelationships"] = len(self.relationships)
            topic_dict["relationships"] = [rel.to_dict() for rel in self.relationships]

        return topic_dict
