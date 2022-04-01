curl -L -X POST '{base_auth_url}{base_auth_api_path}' \
  -H 'Content-Type: application/json' \
  --data-raw '{
    "username": "{cass_user}",
    "password": "{cass_passwd}"
}'
