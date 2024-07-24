const mongoose = require("mongoose");

const volSchema = mongoose.Schema({
  numVol: {
    type: String,
    required: true,
  },
  compagnieAerienne: {
    type: String,
    required: true,
  },
  heureArriveePrevue: {
    type: Date,
    required: true,
  },
  heureDepartPrevue: {
    type: Date,
    required: true,
  },
  status: {
    type: String,
    required: true,
  },
  pisteAssignee: { type: mongoose.Schema.Types.ObjectId, ref: "Piste" },
});

const Vol = mongoose.model("vol", volSchema);

module.exports = Vol;
