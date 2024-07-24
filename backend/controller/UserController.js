const User = require("../models/User");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
const generateToken = require("../middleware/generateToken");
dotenv.config();

// ############################## REGISTER #################################//
const Registre = async (req, res, next) => {
  try {
    const { fullName, email, password, role } = req.body;
    console.log(fullName);
    console.log(req.body);
    console.log(email);
    console.log(password);
    if (!fullName || !email || !password || !role) {
      res.status(400).send("Please fill all required fields");
    } else {
      const isAlreadyExist = await User.findOne({ email });
      if (isAlreadyExist) {
        res.status(400).send("User already exists");
      } else {
        const newUser = new User({ fullName, email, role });
        bcrypt.hash(password, 10, (err, hashedPassword) => {
          newUser.set("password", hashedPassword);
          newUser.save();
          next();
        });
        return res.status(200).send("User registered successfully");
      }
    }
  } catch (error) {
    res.status(500).json(error);
    console.log(error);
  }
};
// ############################## ENDING #################################//

// ############################## LOGIN #################################//
const Login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      res.status(400).json({
        status: 400,
        message: "Please fill all required fields",
      });
    } else {
      const user = await User.findOne({ email });
      if (!user) {
        res.status(400).json({
          status: 400,
          message: "User email or password is incorrect",
        });
      } else {
        const validateUser = await bcrypt.compare(password, user.password);
        if (!validateUser) {
          res.status(400).json({
            status: 400,
            message: "User email or password is incorrect",
          });
        } else {
          try {
            const token = await generateToken(user);
            await User.updateOne({ _id: user._id }, { $set: { token } });
            user.save();
            return res.status(200).json({
              status: 200,
              user: {
                id: user._id,
                email: user.email,
                fullName: user.fullName,
                role: user.role,
              },
              token: token,
            });
          } catch (err) {
            res.status(500).json({
              status: 500,
              message: "Error generating token",
            });
            console.log(err);
          }
        }
      }
    }
  } catch (error) {
    res.status(500).json({
      status: 500,
      message: error,
    });
    console.log(error);
  }
};
// ############################## ENDING #################################//

// ############################## LOGOUT #################################//
const Logout = async (req, res, next) => {
  try {
    const { email } = req.body;

    if (!email) {
      res.status(400).json({
        status: 400,
        message: "Email is required",
      });
    } else {
      const user = await User.findOne({ email });
      if (!user) {
        res.status(400).json({
          status: 400,
          message: "User not found",
        });
      } else {
        await User.updateOne({ _id: user._id }, { $unset: { token: "" } });
        return res.status(200).json({
          status: 200,
          message: "User logged out successfully",
        });
      }
    }
  } catch (error) {
    res.status(500).json({
      status: 500,
      message: error,
    });
    console.log(error);
  }
};
// ############################## ENDING #################################//

module.exports = { Registre, Login, Logout };
