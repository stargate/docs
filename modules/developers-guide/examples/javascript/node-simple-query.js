const query = new Query();
query.setCql('select cluster_name from system.local');

// Must manually generate auth metadata if using insecure creds -
// see authentication section above for details
const authenticationMetadata = await creds.generateMetadata(
  {service_url: 'http://localhost:8081/v1/auth'}
);
await promisifiedClient.executeQuery(query, authenticationMetadata);
