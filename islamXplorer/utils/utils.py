from itertools import groupby
import json


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


def createDataJSON(query, time, verse_objects, hadith_objects):
    total_results = len(verse_objects) + len(hadith_objects)

    verses_data = [verse.to_dict() for verse in verse_objects]
    hadiths_data = [hadith.to_dict() for hadith in hadith_objects]

    results = {
        "Cipher": query,
        "TotalResults": total_results,
        "TimeTaken": time,
        "data": verses_data+hadiths_data
    }
    return json.dumps(results, ensure_ascii=False, default=obj_dict, indent=4)


def createResultsJSON(data, query, total_results, time):
    results = {
        "Cipher": query,
        "TotalResults": total_results,
        "TimeTaken": time,
        "data": data["data"]
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
