from enum import Enum

from models.hadith import Hadith
from models.surah import Surah
from models.topic import Topic
from models.verse import Verse


class DataType(Enum):
    Verse = "Verse"
    Hadith = "Hadith"
    Surah = "Surah"


class NodeType(Enum):
    Verse = Verse
    Hadith = Hadith
    Surah = Surah
    Topic = Topic


class Ontology:
    def __init__(self, dataType, dataID, topic, concept, uid, startNode=None, endNode=None, relationshipName=None):
        if not isinstance(dataType, DataType) and dataType is not None:
            raise ValueError("Invalid dataType")
        self.dataType = dataType
        self.dataID = dataID
        self.topic = topic
        self.concept = concept
        self.uid = uid
        self.startNode = startNode
        self.endNode = endNode
        self.relationshipName = relationshipName

    @classmethod
    def from_relationship(cls, relationshipName, startNode, endNode, uid):
        if not any(isinstance(startNode, node_type.value) for node_type in NodeType):
            raise ValueError("Invalid startNode")

        if not any(isinstance(endNode, node_type.value) for node_type in NodeType):
            raise ValueError("Invalid endNode")
        return cls(None, None, None, None, uid, startNode, endNode, relationshipName)

    def to_dict(self):
        ontDict = {
            "externalUserID": self.uid,
        }

        if self.relationshipName:
            ontDict["relName"] = self.relationshipName

        if self.startNode or self.endNode:
            if self.relationshipName == "MENTIONED_IN":
                ontDict["dataTypeID"] = self.endNode.id
                ontDict["dataType"] = type(self.endNode).__name__
            elif self.relationshipName == "DESCRIBES":
                ontDict["dataTypeID"] = self.startNode.id
                ontDict["dataType"] = type(self.startNode).__name__

        return ontDict
