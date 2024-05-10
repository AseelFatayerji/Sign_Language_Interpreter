const express = require("express");
const { connected } = require("./config/db_config")

require("dotenv").config();

connected();

const app = express();

app.listen(3001, () => {
  console.log("server is running on port 3001");
});
