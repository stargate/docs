=== Start the Stargate container

Start the Stargate container in developer mode.
Developer mode removes the need to set up a separate Cassandra instance and is
meant for development and testing only.

[source,bash,subs="attributes+"]
----
docker run --name stargate \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8082:8082 \
  -p 127.0.0.1:9042:9042 \
  -d \
  -e CLUSTER_NAME=stargate \
  -e CLUSTER_VERSION=3.11 \
  -e DEVELOPER_MODE=true \
  stargateio/stargate-3_11:{stargate-docker-tag}
----

The ports align to the following services and interfaces:

.Default Port assignments for Stargate
|===
| Port | Service/Interface

| Port 8080 | GraphQL interface for CRUD
| Port 8081 | REST authorization service for generating tokens
| Port 8082 | REST interface for CRUD
| Port 9042 | CQL service
|===
