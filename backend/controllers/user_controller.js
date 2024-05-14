const User = require("../models/user_model");

const setValue = (items, value) => {
  if (items === "name") {
    const temp = { name: value };
    return temp;
  }
  if (items === "email") {
    const temp = { email: value };
    return temp;
  }
  if (items === "password") {
    const temp = { password: value };
    return temp;
  }
};
const getAll = async (req, res) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  try {
    const users = await User.find();
    return res.json(users);
  } catch (err) {
    return res.status(500).send("Internal server error");
  }
};

const getUser = async (req, res) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  try {
    const users = await User.find({ email: req.params.email });
    return res.json(users);
  } catch (err) {
    return res.status(500).send("Internal server error");
  }
};
const editUser = async (req, res) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  try {
    const email = { email: req.params.email };
    const item = setValue(req.params.item, req.params.value);
    const users = await User.findOneAndUpdate(email, item, { new: true });
    return res.json(users);
  } catch (err) {
    return res.status(500).send(err);
  }
};
const deleteUser = async (req, res) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  try {
    const email = { email: req.params.email };
    const users = await User.findOneAndDelete(email, { new: true });
    return res.json(users);
  } catch (err) {
    return res.status(500).send(err);
  }
};
module.exports = { getUser, editUser, deleteUser, getAll };
