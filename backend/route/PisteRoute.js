const express = require("express");

const  { createPiste, getPiste, editPiste, updatePiste, deletePiste }  = require("../controller/PisteController.js");

const router = express.Router();
 
router.route("/createPiste").post(createPiste);
router.route("/readPiste").get(getPiste);
router.route("/editPiste/:pisteId").get(editPiste);
router.route("/updatePiste/:pisteId").put(updatePiste);
router.route("/deletePiste/:pisteId").delete(deletePiste);
// router.post("/",createPist)

module.exports = router;