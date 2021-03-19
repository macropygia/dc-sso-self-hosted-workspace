db = db.getSiblingDB("admin");
db.createUser({
  user: "root",
  pwd: "root",
  roles: [
    {
      role: "root",
      db: "admin",
    },
  ],
});
