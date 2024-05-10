const express = require("express");
const router = express.Router();
const verifyToken = require("../middlewares/auth_middleware");

router.get("/:token", verifyToken);

module.exports = router;
