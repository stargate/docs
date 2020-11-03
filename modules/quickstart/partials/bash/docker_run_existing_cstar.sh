=== Starting Stargate with existing Cassandra cluster

Stargate can be added to an existing Cassandra cluster operating in a
containerized environment with the following command:

[source,bash,subs="attributes+"]
----
docker run --name stargate \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8082:8082 \
  -p 127.0.0.1:9042:9042 \
  -d \
  -e CLUSTER_NAME=stargate \
  -e SEED=127.0.0.1 \
  -e CLUSTER_VERSION=3.11 \
  -e SIMPLE_SNITCH=true \
  -e ENABLE_AUTH=true \
  stargateio/stargate-3_11:{stargate-docker-tag}
----

where
  * `CLUSTER_NAME` identifies the cluster name
  * `SEED` is set to the IP address of the running Cassandra node
  * `CLUSTER_VERSION` is set to the version of Cassandra running in the cluster
  * `SIMPLE_SNITCH` sets the snitch on the Stargate node
  * `ENABLE_AUTH` enables `PasswordAuthenticator` in the cluster

[NOTE]
====
Use the `SIMPLE_SNITCH` option if the
  link:https://github.com/apache/cassandra/blob/cassandra-3.11/conf/cassandra.yaml#L962[endpoint_snitch]
  setting in the cluster is set to *SimpleSnitch*. If the cluster uses a
  different `endpoint_snitch` use the `--dc` and `--rack` options to define the
  topology of the node.
====

The ports align to the following services and interfaces:

.Default Port assignments for Stargate
|===
| Port | Service/Interface

| Port 8080 | GraphQL interface for CRUD
| Port 8081 | REST authorization service for generating tokens
| Port 8082 | REST interface for CRUD
| Port 9042 | CQL service
|===
