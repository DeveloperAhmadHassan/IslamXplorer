from itertools import groupby
import json
import numpy as np
from sklearn.metrics.pairwise import cosine_similarity


def getUniqueSurahs(surahs):
    return list({surah.name: surah for surah in surahs}.values())


def getUniqueVerses(verses):
    return list({verse.id: verse for verse in verses}.values())


def getUniqueHadiths(hadiths):
    return list({hadith.id: hadith for hadith in hadiths}.values())


def setSurahJson(surahs):
    surahJSON = {
        "Surahs": surahs
    }
    return json.dumps(surahJSON, ensure_ascii=False, default=obj_dict, indent=4)


def cosineSimilarityScore(embedding1, embedding2):
    """
    Calculate cosine similarity between two embeddings.
    """
    return cosine_similarity([embedding1], [embedding2])[0][0]


def sortResults(queryResults, queryEmbeddings):
    """
    Sort query results based on cosine similarity between their embeddings and query embeddings.
    """
    similarityScores = [cosineSimilarityScore(result['embeddings'], queryEmbeddings) for result in queryResults]
    sortedResults = [result for _, result in sorted(zip(similarityScores, queryResults), reverse=True)]
    return sortedResults


def createDataJSON(query, time, verseObjects=None, hadithObjects=None, embeddingsFlag=False, inputQueryEmbeddings=None, googleObjects=None):
    versesData = []
    hadithsData = []
    googleData = []
    sortedResults = []

    if verseObjects is not None or hadithObjects is not None:
        versesData = [verse.to_dict(True) for verse in verseObjects]
        hadithsData = [hadith.to_dict(True) for hadith in hadithObjects]

    if googleObjects is not None:
        googleData = [google.to_dict(True) for google in googleObjects]

    if googleObjects is not None:
        sortedResults = googleData
    else:
        sortedResults = versesData + hadithsData

    if inputQueryEmbeddings is not None:
        sortedResults = sortResults(versesData + hadithsData, inputQueryEmbeddings)

    if not embeddingsFlag:
        for obj in sortedResults:
            obj.pop('embeddings', None)

    results = {
        "status": 200,
        "cipher": query,
        "totalResults": {
            "total": 0,
            "verses": 0,
            "hadiths": 0,
            "google": 0
        },
        "timeTaken": time,
        "data": sortedResults
    }

    if googleObjects is not None:
        results["totalResults"]["google"] = len(googleObjects)
        results["totalResults"]["total"] = len(googleObjects)

    if verseObjects is not None or hadithObjects is not None:
        results["totalResults"]["hadiths"] = len(hadithObjects)
        results["totalResults"]["verses"] = len(verseObjects)
        results["totalResults"]["total"] = len(hadithObjects) + len(verseObjects)

    return json.dumps(results, ensure_ascii=False, default=obj_dict, indent=4)


def createResultsJSON(data, query, totalResults, time, status):
    results = {
        "status": status,
        "cipher": query,
        "totalResults": totalResults,
        "timeTaken": time,
        "data": data['topics']
    }
    return json.dumps(results, ensure_ascii=False, default=obj_dict, indent=4)


def setSurahAndVerseJson(surahs, groupedVerses):
    for groupedVerse, surah in zip(groupedVerses, surahs):
        surah.verses = groupedVerse

    return surahs


def getSurahByNumber(surahs, targetNum):
    for surah in surahs:
        if surah.number == targetNum:
            return surah
    return None


def obj_dict(obj):
    return obj.__dict__


def groupVerses(verses):
    return [list(i) for j, i in groupby(verses, lambda a: a.id.split(':')[0])]
