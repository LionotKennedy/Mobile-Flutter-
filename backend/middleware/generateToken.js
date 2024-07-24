const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
dotenv.config();

const generateToken = (user) => {
  const load = {
    userId: user._id,
    email: user.email,
  };
  const JWT_SECRET_KEY = process.env.JWTKEY;
  return new Promise((resolve, reject) => {
    jwt.sign(
      load,
      JWT_SECRET_KEY,
      { expiresIn: 84600 },
      (err, token) => {
        if (err) {
          reject(err);
        } else {
          resolve(token);
        }
      }
    );
  });
};

module.exports = generateToken;