from conn.neo4j_conn import Neo4jConn

query = """
MATCH (n)-[r]->(m)
WHERE NOT any(label IN labels(n) WHERE label IN ['Database', 'Message'])
WITH [label IN labels(n) WHERE label <> 'EXTERNAL'] AS labelList, 
     size(keys(n)) AS num_properties, 
     count(*) AS node_count, 
     keys(n) AS properties,
     labels(n) AS startLabel, 
     labels(m) AS endLabel, 
     type(r) AS relationship
WITH apoc.coll.toSet(labelList) AS label, 
     sum(num_properties) AS total_num_properties, 
     sum(node_count) AS total_node_count, 
     collect(properties) AS all_properties,
     apoc.coll.toSet(COLLECT({startLabel: startLabel[0], relationship: relationship, endLabel: endLabel[0]})) AS relationships
WITH apoc.coll.toSet([prop IN apoc.coll.flatten(all_properties) | prop]) AS unique_properties,
     reduce(s = "", x IN label | s + x) AS label_string,
     total_num_properties,
     total_node_count,
     relationships
WITH SIZE(unique_properties) AS TOTAL_PROPERTIES,
     label_string AS LABEL,
     total_node_count AS TOTAL_NODES,
     unique_properties AS PROPERTIES,
     relationships AS RELATIONSHIPS,
     size(relationships) AS TOTAL_RELATIONSHIPS
RETURN LABEL, TOTAL_PROPERTIES, TOTAL_NODES, PROPERTIES, RELATIONSHIPS,TOTAL_RELATIONSHIPS 
ORDER BY TOTAL_NODES DESC
"""


import jwt
import os
from datetime import datetime, timedelta

def refreshToken(expired_token):
    print("Here")
    decoded_token = jwt.decode(expired_token, 'your_secret_key_here', algorithms=['HS256'])
    print("Here")
    # Extract user information from the decoded token
    email = decoded_token['email']
    user_type = decoded_token['role']

    # Update expiration time of the token
    payload = {
        'email': email,
        'role': user_type,
        'exp': datetime.utcnow() + timedelta(minutes=5)  # Extend expiration by 5 minutes, adjust as needed
    }

    print(payload)
    refreshed_token = jwt.encode(payload, 'your_secret_key_here', algorithm='HS256')
    return refreshed_token



def main():
    # Example usage:
    expired_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFobWFkLmhhc3NhbnRhcmlxOTIxQGdtYWlsLmNvbSIsInJvbGUiOiJBIiwiZXhwIjoxNzExNDU3MzY4fQ.XhT5RWMt1J61ctwiFpr-WWJTeG90_bfdZG8FAR02fkM"
    refreshed_token = refreshToken(expired_token)
    if refreshed_token:
        print("Refreshed token:", refreshed_token)
    else:
        print("Token refresh failed.")


if __name__ == '__main__':
    main()
