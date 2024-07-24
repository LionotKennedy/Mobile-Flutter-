const express = require("express");

const { createMaintenance, readMaintenance, editMaintenance, updateMaintenance, deleteMaintenance } = require("../controller/MaintenanceController");

const router = express.Router();

router.route("/createMaint").post(createMaintenance);
router.route("/readMaint").get(readMaintenance);
router.route("/editMaint/:maintId").get(editMaintenance);
router.route("/updateMaint/:maintId").put(updateMaintenance);
router.route("/deleteMaint/:maintId").delete(deleteMaintenance);

module.exports = router;