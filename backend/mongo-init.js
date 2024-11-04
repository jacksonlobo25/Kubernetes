db.createUser({
    user: "springuser",
    pwd: "springpassword",
    roles: [{ role: "readWrite", db: "springbootdb" }]
  });
  