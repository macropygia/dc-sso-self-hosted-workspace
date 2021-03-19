db = db.getSiblingDB("admin");

db.runCommand({
  createRole: "oplogger",
  privileges: [
    {
      resource: {
        db: "local",
        collection: "system.replset",
      },
      actions: ["find"],
    },
  ],
  roles: [
    {
      role: "read",
      db: "local",
    },
  ],
});

db.createUser({
  user: "oplogger",
  pwd: "oplogger",
  roles: [
    {
      role: "read",
      db: "local",
    },
  ],
});

db.runCommand({
  grantRolesToUser: "oplogger",
  roles: ["oplogger"],
});
