enum FailureType {
  // General
  unexpected,
  validation,
  conversion,

  // Network / API
  network,
  timeout,
  server,
  client,
  auth,
  forbidden,

  // Platform / Device
  permission,
  file,
  camera,
  notification,

  // App-specific
  database,
  payment,
  location,
  cache,
}
