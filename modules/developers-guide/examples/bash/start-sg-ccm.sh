ccm create stargate -v 3.11.8 -n 1 -s -b
./starctl --cluster-name stargate --cluster-seed 127.0.0.1 --cluster-version 3.11 \
          --listen 127.0.0.2 --bind-to-listen-address --simple-snitch
Obtain the authentication token:

curl -L -X POST 'http://127.0.0.2:8081/v1/auth' \
     -H 'Content-Type: application/json' \
     --data-raw '{
        "username": "cassandra",
        "password": "cassandra"
     }'

{"authToken":"2df7e75d-92aa-4cda-9816-f96ccbc91d80"}
Set the authentication token variable:

export SG_TOKEN=2df7e75d-92aa-4cda-9816-f96ccbc91d80
