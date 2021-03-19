db = db.getSiblingDB("growi");
db.createUser({
  user: "growi",
  pwd: "growi",
  roles: [
    {
      role: "dbOwner",
      db: "growi",
    },
  ],
});
