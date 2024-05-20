const express = require("express");
const { getUser, editUser, deleteUser, getAll } = require("../controllers/user_controller");

const router = express.Router();

router.get("/", getAll);
router.get("/:email/:token", getUser);
router.post("/:email/:item/:value/:token", editUser);

module.exports = router;
