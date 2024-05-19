const express = require("express");
const multer = require("multer");
const { connected } = require("./config/db_config")
const userRouter = require("./routes/user_routes");
const authRouter = require("./routes/auth_routes");
const protected = require("./routes/protected_routes");
const { default: axios } = require("axios");
require("dotenv").config();

connected();

const app = express();
const mul = multer();

app.use(express.json());

app.use("/user", userRouter);
app.use("/auth", authRouter);
app.use("/verify", protected);
app.post('/translate', mul.single("image"), async (req, res) => {
  const image = req.file.buffer.toString("base64");
  const form = new FormData();
  form.append("image", image);
  try {
    const predict = await axios.post(`http://localhost:8000/translate`, form, { headers: { "Content-Type": "multipart/form-data" } });
    console.log(predict.data)
    res.status(200).json(predict.data)
  }
  catch (err) {
    console.log(err.response?.data ?? err.message)
  }
});

app.listen(3001, () => {
  console.log("server is running on port 3001");
});
