from itertools import groupby
import json


def getUniqueSurahs(surahs):
    return list({surah.name: surah for surah in surahs}.values())


def setSurahJson(surahs):
    surahJSON = {
        "Surahs": surahs
    }
    return json.dumps(surahJSON, ensure_ascii=False, default=obj_dict, indent=4)


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
