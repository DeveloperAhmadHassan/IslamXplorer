from googleapiclient.discovery import build
import json

search_engine_id = "352b3c6909ad14eff"
api_key = "AIzaSyA0_9zFuxao067Re-R-qieTrzx02fAV2FM"


def google_search(query, **kwargs):
    service = build("customsearch", "v1", developerKey=api_key)
    try:
        res = service.cse().list(q=query, cx=search_engine_id, **kwargs).execute()
        return res
    except Exception as e:
        print(f"Error: {e}")
        return None


result = google_search("Love")
if result:
    # Use json.dumps to print the JSON response in a pretty format
    print(json.dumps(result, indent=2))


