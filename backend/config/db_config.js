const mongoose = require("mongoose");

const connected = () => {
  mongoose.connect(process.env.URL);

  mongoose.connection.on("connected", () => {
    console.log("Connected to mongoDB");
  });

  mongoose.connection.once("error", (err) => {
    console.log("Error: ", err);
  });
};

module.exports = { connected };
