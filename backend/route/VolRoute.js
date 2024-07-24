const express = require("express");

const {createVol, readVol, editVol, updateVol, deleteVol } = require("../controller/VolController");

const router = express.Router();

router.route("/createVol").post(createVol);
router.route("/readVol").get(readVol);
router.route("/editVol/:volId").get(editVol);
router.route("/updateVol/:volId").put(updateVol);
router.route("/deleteVol/:volId").delete(deleteVol);

module.exports = router;