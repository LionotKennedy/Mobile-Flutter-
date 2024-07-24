const express = require("express");

const { Registre, Login, Logout } = require("../controller/UserController")

const router = express.Router();

router.route('/registre').post(Registre);
router.route('/login').post(Login);
router.route('/logout').put(Logout);

module.exports = router;