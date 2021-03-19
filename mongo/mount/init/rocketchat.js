db = db.getSiblingDB("rocketchat");
db.createUser({
  user: "rocketchat",
  pwd: "rocketchat",
  roles: [
    {
      role: "dbOwner",
      db: "rocketchat",
    },
    {
      role: "clusterMonitor",
      db: "admin",
    }
  ],
});
