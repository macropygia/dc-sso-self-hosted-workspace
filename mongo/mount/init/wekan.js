db = db.getSiblingDB("wekan");
db.createUser({
  user: "wekan",
  pwd: "wekan",
  roles: [
    {
      role: "dbOwner",
      db: "wekan",
    },
  ],
});
