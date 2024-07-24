const express = require("express");

const {
  createHoraire,
  readHoraire,
  editHoraire,
  updateHoraire,
  deleteHoraire,
} = require("../controller/HoraireController");

const router = express.Router();

router.route("/createHoraire").post(createHoraire);
router.route("/readHoraire").get(readHoraire);
router.route("/editHoraire/:hourId").get(editHoraire);
router.route("/updateHoraire/:hourId").put(updateHoraire);
router.route("/deleteHoraire/:hourId").delete(deleteHoraire);

module.exports = router;
