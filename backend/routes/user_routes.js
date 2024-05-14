const express = require("express");
const { getUser, editUser, deleteUser, getAll } = require("../controllers/user_controller");

const router = express.Router();

router.get("/", getAll);
router.get("/:email", getUser);
router.post("/:email/:item/:value", editUser);

router.delete("/:email",deleteUser);
module.exports = router;
