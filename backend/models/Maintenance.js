const mongoose = require("mongoose");

const maintenanceSchema = new mongoose.Schema({
  pisteID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Piste",
    required: true,
  },
  typeMaintenance: {
    type: String,
    required: true,
  },
  dateDebut: {
    type: Date,
    required: true,
  },
  dateFin: {
    type: Date,
    required: true,
  },
  description: {
    type: String,
  },
});

const maintenance = mongoose.model("maintenance", maintenanceSchema);

module.exports = maintenance;
