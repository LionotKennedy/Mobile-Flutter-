const mongoose = require("mongoose");

const horaireSchema = new mongoose.Schema({
  pisteID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Piste",
    required: true,
  },
  heureDebut: {
    type: Date,
    required: true,
  },
  heureFin: {
    type: Date,
    required: true,
  },
  volID: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Vol",
  },
});

const horaire = mongoose.model("horaire", horaireSchema);

module.exports = horaire;
