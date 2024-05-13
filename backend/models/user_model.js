const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    require: "Name is required",
  },
  email: {
    type: String,
    require: "Email is required",
    unique: true,
  },
  password: String,
  isAdmin: Number,
});

const User = mongoose.model("User", userSchema);

module.exports = User;
