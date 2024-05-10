const jwt = require("jsonwebtoken");

function verifyToken(req, res) {
  res.setHeader("Access-Control-Allow-Origin", "*");

  const token = req.params.token;
  if (!token) return res.status(401).json({ error: "Access denied" });
  try {
    const decoded = jwt.verify(token, "your-secret-key");
    req.userId = decoded.userId;
    res.status(201).json({ message: "Valid token" });
  } catch (error) {
    res.status(401).json({ error: "Invalid token" });
  }
}

module.exports = verifyToken;
