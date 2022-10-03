curl -L -X  GET '{base_doc_url_v2}{base_doc_api}/{namespace}/collections/{collection}?where=\{"book.*":\{"$in":["paperback","epub"]\}\}&page-size=3' \
--header "X-Cassandra-Token: {auth_token}" \
--header "Content-Type: application/json"
